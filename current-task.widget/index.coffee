command: """
IFS='~' read -r theArea theProject theTask theTags theNotes <<<"$(osascript current-task.widget/getTaskDetails.scpt)"
echo '{ "area":"'$theArea'","project": "'$theProject'", "task": "'$theTask'", "tags": "'$theTags'", "notes": "'$theNotes'"}'
"""

refreshFrequency: 15000

style: """
  bottom: 11px
  left:50%
  width:1000px
  margin-left:-500px
  border-radius:10px

  text-align:center
  font-family: Helvetica Neue
  font-weight: 200
  text-shadow: 0 1px 5px #000000;
  text-decoration: none
  color:white

  p
    margin:0px

  #currentTaskContent
    padding:5px

  #timelapse
    margin:5px
    color:rgba(255,255,255,0.4)

  .thing
    font-size: 30px
    color:#ffffc7

  .project
    font-size: 18px

  .area
    font-size: 12px

  .warning
    background:rgba(255,0,0,0.20)
    -webkit-transition: background-color 2000ms linear;

  .success
    background:rgba(0,255,0,0.15)
    -webkit-transition: background-color 2000ms linear;

"""

render: (output) ->
    return """
      <script>
        $(document).ready(function(){
          $.ajax({url: "/Status", success: function(result){
              if(result == "On") {
                $("#toggl").attr("src","current-task.widget/images/Active-19.png");
              } else {
                $("#toggl").attr("src","current-task.widget/images/Inactive-19.png");
              }
          }});
          $("#toggl").click(function(){
              if( $("#toggl").attr("src") == "current-task.widget/images/Active-19.png") {
                $.ajax({url: "/Stop", success: function(result){
                    $("#toggl").attr("src","current-task.widget/images/Inactive-19.png");
                }});
              } else {
                $.ajax({url: "/Start", success: function(result){
                    $("#toggl").attr("src","current-task.widget/images/Active-19.png");
                }});
              }
          });
        });
      </script>
      <div id="currentTaskContent">
        <p id="timelapse"/>
        <p id="timegoal"style="display:none"/>
        <p id="timelimit"style="display:none"/>
        <div>
            <img id="toggl" style="vertical-align:3%" src="current-task.widget/images/Inactive-19.png"/>
            <p class="thing"/>
            <p class="project"/>
            <p class="area"/>
        </div>
      </div>
    """

update: (output, domEl) ->
  data = []
  try
    data = JSON.parse output
  catch ex
    $(".area").text("Error Parsing JSON response: #{output}");

  $(".thing").text(data.task);
  $(".project").text(data.project);
  $(".area").text(data.area);

  tg = /\[TimeGoal:\s*([^\]]*)\]/.exec(data.notes);
  if(tg)
    tg = tg[1]
  else
    tg = "00:00"
  tl = /\[TimeLimit:\s*([^\]]*)\]/.exec(data.notes);
  if(tl)
    tl = tl[1]
  else
    tl = "00:00"

  $("#timegoal").text(tg);
  $("#timelimit").text(tl);
  if !$("#toggl").hasClass("reactDone")
    $("#toggl").addClass("reactDone")
    $("#toggl").click(@clickReact)
  $.ajax({url: "/Status", success: @updateStatus});


updateStatus: (resultArray) ->
    NUMERO_MINUTOS_COM_ALARME = 5
    NUMERO_MINUTOS_PRE_AVISO = 5
    tmp = resultArray.split('\n')
    result = tmp[0]
    timeLapse = tmp[1]

    if result == "Off"
      $("#timelapse").text("")
      $("#toggl").attr("src","current-task.widget/images/Inactive-19.png");
      $("#currentTaskContent").removeClass("warning")
    else
      timeGoalT  = new Date('1970-01-01T' + $("#timegoal").text() + ':00Z').getTime() / 60000;
      timeLimitT = new Date('1970-01-01T' + $("#timelimit").text() + ':00Z').getTime() / 60000;
      timeLapseT = new Date('1970-01-01T' + timeLapse + ':00Z').getTime() / 60000;
      txtPassam = "passam"
      txtFaltam = "faltam"
      txtMinutos = "minutos"

      missingForTimeLimit = timeLimitT - timeLapseT
      missingForTimeGoal  = timeGoalT - timeLapseT


      $("#currentTaskContent").removeClass("success")
      $("#timelapse").removeClass("warning")
      if(timeLimitT && missingForTimeLimit<NUMERO_MINUTOS_PRE_AVISO)
        if(missingForTimeLimit==-1 || missingForTimeLimit==1)
          txtPassam = "passa"
          txtFaltam = "falta"
          txtMinutos = "minuto"
        if(missingForTimeLimit<=0)
          $("#timelapse").text(timeLapse+" ("+txtPassam+" "+(-missingForTimeLimit)+" "+txtMinutos+" do limite)")
          if(missingForTimeLimit>-NUMERO_MINUTOS_COM_ALARME)
            audio = new Audio('http://www.storiesinflight.com/html5/audio/flute_c_long_01.wav');
            audio.play();
        else
          $("#timelapse").text(timeLapse+" ("+txtFaltam+" "+(missingForTimeLimit)+" "+txtMinutos+" para o limite)")
        $("#timelapse").addClass("warning")
      else if(timeGoalT)
        if(missingForTimeGoal==-1 || missingForTimeGoal==1)
          txtPassam = "passa"
          txtFaltam = "falta"
          txtMinutos = "minuto"
        if(missingForTimeGoal>0)
          $("#timelapse").text(timeLapse+" ("+txtFaltam+" "+missingForTimeGoal+" "+txtMinutos+" para objectivo)")
          $("#currentTaskContent").removeClass("success")
        else
          if(missingForTimeGoal==0)
            audio = new Audio('http://www.pacdv.com/sounds/applause-sounds/app-5.mp3');
            audio.play();
          $("#timelapse").text(timeLapse+ " (" + (-missingForTimeGoal)+" "+txtMinutos+" acima do objectivo)")
          $("#currentTaskContent").addClass("success")
      else
        $("#timelapse").text(timeLapse)

      $("#toggl").attr("src","current-task.widget/images/Active-19.png");
      if result.substring(3) != $(".thing").text()
        $("#currentTaskContent").addClass("warning")
      else
        $("#currentTaskContent").removeClass("warning")

clickReact: () ->
  $("#currentTaskContent").removeClass("warning")
  if $("#toggl").attr("src") == "current-task.widget/images/Active-19.png"
    $("#toggl").attr("src","current-task.widget/images/Inactive-19.png");
    $.ajax({url: "/Stop", success: @stopToggl});
  else
    $("#toggl").attr("src","current-task.widget/images/Active-19.png");
    task = $(".thing").text();
    project = $(".project").text();
    area = $(".area").text();
    url = "/Start/"+encodeURIComponent(area)+"/"+encodeURIComponent(project)+"/"+encodeURIComponent(task)
    $.ajax({url: url, success: @startToggl});

stopToggl: () ->


startToggl: () ->


serverCode: () ->
    ###
    Para instalar o Ubersicht:
    1) Download do site: http://tracesof.net/uebersicht/
    2) Correr inicialmente inalterado
    3) Aplicar o patch: ```patch server.js server.patch```
    4) Instalar a dependência do "toggl-api": ```npm install toggl-api```

    Para criar o patch (originalmente) usar:
    ```diff -u server.original.js server.modified.js > server.patch```
    ###
