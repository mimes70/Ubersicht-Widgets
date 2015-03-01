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
    #var clientName = null;
    #var clientName = "Pessoal - Finance";
    #var projectName = "Ampliar funcionalidades do Uberstich";
    #var projectName = null;
    #var timeDescription = "Controlar tempo gasto em cada tarefa";

    var WID = 795785;
    var TogglClient = require('toggl-api'), toggl = new TogglClient({apiToken: '5bb060a61d08f401c4d2422925178593'});

    function getEntryByKey(array, key, value, key2, value2) {
    	if(!value) return null;
    	for(var i = 0; array && i < array.length ; i++) {
    		//console.log(array[i][key]);
    		if(array[i][key] == value && (!key2 || !value2 && !array[i][key2] || array[i][key2] == value2)) {
    			return array[i];
    		}
    	}
    	//flag não encontrado
    	return {id:-1};
    }

    function startTimeWithPid(pid, timeDescription) {
    	toggl.startTimeEntry({"description":timeDescription, "pid": pid }, function(err, taskData) {
    		console.log("Created task:", timeDescription, taskData.id );
    	});
    }

    function startTimeWithCid(cid, projectName, timeDescription) {
    	var next = function(projects) {
    		var p = getEntryByKey(projects, "name", projectName, "cid", cid);
    		//Cria se o id for a flag de 'não encontrado' ou se o cliente do projecto não é o cliente pretendido
    		if(p && (p.id < 0 || (cid && p.cid != cid))) {
    			toggl.createProject({"name":projectName, "wid":WID, "cid":cid, "is_private":false }, function(err, projectData) {
    				console.log("Created project:", projectName, projectData.id);
    				startTimeWithPid(projectData.id, timeDescription);
    			});
    		} else {
    			if(p) {
    				console.log('ProjectId: '+p.id);
    				startTimeWithPid(p.id, timeDescription);
    			} else {
    				console.log('No project');
    				startTimeWithPid(null, timeDescription);
    			}
    		}
    	}

    	if(cid) {
    		toggl.getClientProjects(cid, true, function(err, projects) {
    			next(projects);
    		});
    	} else {
    		toggl.getWorkspaceProjects(WID, function(err, projects) {
    			next(projects);
    		});
    	}
    }

    function startTime(clientName,projectName,timeDescription) {
		if (!clientName) {
			console.log('No client');
			startTimeWithCid(null, projectName, timeDescription);
		} else {
			toggl.getClients(function(err, clients) {
				var c = getEntryByKey(clients, "name", clientName);
				if(c && c.id < 0) {
					toggl.createClient({"name":clientName, "wid":WID}, function(err, clientData) {
						console.log("Created client:", clientName, clientData.id);
						startTimeWithCid(clientData.id, projectName, timeDescription);
					});
				} else if(c) {
					console.log('ClientId: '+c.id);
					startTimeWithCid(c.id, projectName, timeDescription);
				}
			});
		}
    }

	server = connect().use('/status', function fooMiddleware(req, res, next) {
		toggl.getCurrentTimeEntry(function(err, timeEntry) {
			if(timeEntry) {
				var now = new Date();
				var timeLapse = new Date(now - new Date(timeEntry.start));
				var timeLapseStr = ("0"+timeLapse.getHours()).slice(-2)+":"+("0"+timeLapse.getMinutes()).slice(-2);
				res.end("On:"+ (timeEntry.description?timeEntry.description:"")+"\n"+timeLapseStr);
			} else {
				res.end("Off");
			}
		});
	}).use('/start', function fooMiddleware(req, res, next) {
		var args = req.url.substr(1).split('/');
		startTime(decodeURIComponent(args[0]), args[1]?decodeURIComponent(args[1]):"Generic", decodeURIComponent(args[2]));
	}).use('/stop', function fooMiddleware(req, res, next) {
		toggl.getCurrentTimeEntry(function(err, timeEntry) {
			toggl.stopTimeEntry(timeEntry.id, function(err) {
				res.end('Stop: '+timeEntry.description);
			});
		});
	}).use(connect["static"](path.resolve(__dirname, './public'))).use(WidgetCommandServer(widgetDir)).use(WidgetsServer(widgetDir)).use(changesServer.middleware).use(connect["static"](widgetPath)).listen(port, function() {
    ###
