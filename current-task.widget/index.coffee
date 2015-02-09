command: """
IFS='~' read -r theArea theProject theTask <<<"$(osascript <<<'
  tell application "System Events" to (name of processes) contains "Things"

  if result is true then
  	tell application "Things"
  		repeat with theTodo in to dos of list "Today"
  			if status of theTodo is open then exit repeat
  		end repeat

  		set theAreaName to ""
  		set theNotesText to ""

  		set theTaskName to name of the theTodo
  		try
  			set theProject to the project of the theTodo
  			set theProjectName to the name of theProject
  			set theArea to the area of theProject
  			set theAreaName to the name of theArea
  		on error errStr number errorNumber
  			#Uma vez que o primeiro iteam do Today não pertence a um projecto vamos assumir que o item é um projecto
  			set theProjectName to name of theTodo
  			try
  				#tentamos agora obter a lista de to dos
  				set projectTodos to to dos of the theTodo
  				#se foi possível é porque é mesmo um projecto e logo não tem tarefa
  				set theTaskName to ""
  			on error errStr number errorNumber
  				#se falhou é porque era mesmo só uma tarefa
  				set theProjectName to ""
  			end try
  			try
  				set theArea to the area of the theTodo
  				set theAreaName to the name of theArea
  			end try
  		end try

  		set theTagsList to the tag names of the theTodo


  		#if notes of theTodo is not "" then
  		#	set theNotesText to notes of theTodo
  		#end if

  		set message to theAreaName & "~" & theProjectName & "~" & theTaskName & "~" & theTagsList
  	end tell
  else
  	return "No focus (Things closed)!"
  end if
')"
echo '{ "area":"'$theArea'","project": "'$theProject'", "task": "'$theTask'"}'
"""

refreshFrequency: 15000

style: """
  bottom: 16px
  left:683px
  text-align:center
  font-family: Helvetica Neue

  div
    width:1190px

  p
    text-shadow: 0 1px 5px #000000;
    text-decoration: none
    color:white
    margin:0px

  .thing
    font-size: 30px
    color:#ffffc7
    font-weight: 200

  .project
    font-size: 18px
    font-weight: 200

  .area
    font-size: 12px
    font-weight: 200
"""

render: (output) ->
    data = []
    try
      data = JSON.parse output
    catch ex
      return """
        <div>
          <span>Error: #{output}</span>
        </div>
      """

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
      <img id="toggl" style="vertical-align:3%" src="current-task.widget/images/Inactive-19.png"/>
      <div>
          <p class="thing"/>
          <p class="project"/>
          <p class="area"/>
      </div>
    """

update: (output, domEl) ->
  data = []
  try
    data = JSON.parse output
  catch ex
    return """
      <div>
        <span>Error: #{output}</span>
      </div>
    """

  $(".thing").text(data.task);
  $(".project").text(data.project);
  $(".area").text(data.area);
  if !$("#toggl").hasClass("reactDone")
    $("#toggl").addClass("reactDone")
    $("#toggl").click(@clickReact)
  $.ajax({url: "/Status", success: @updateStatus});


updateStatus: (result) ->
    if result == "On"
      $("#toggl").attr("src","current-task.widget/images/Active-19.png");
    else
      $("#toggl").attr("src","current-task.widget/images/Inactive-19.png");


clickReact: () ->
  debugger
  if $("#toggl").attr("src") == "current-task.widget/images/Active-19.png"
    $("#toggl").attr("src","current-task.widget/images/Inactive-19.png");
    $.ajax({url: "/Stop", success: @stop});
  else
    $("#toggl").attr("src","current-task.widget/images/Active-19.png");
    task = $(".thing").text();
    project = $(".project").text();
    area = $(".area").text();
    url = "/Start/"+area+"/"+project+"/"+task

    $.ajax({url: encodeURI(url), success: @start});

stopToggl: () ->

startToggl: () ->


serverCode: () ->
    ###
    var WID = 795785;
    var clientName = null;
    var clientName = "Pessoal - Finance";
    var projectName = "Ampliar funcionalidades do Uberstich";
    var projectName = null;
    var timeDescription = "Controlar tempo gasto em cada tarefa";

    var TogglClient = require('toggl-api'), toggl = new TogglClient({apiToken: '5bb060a61d08f401c4d2422925178593'});

    function getEntryByKey(array, key, value) {
    	if(!value) return null;
    	for(var i = 0; array && i < array.length ; i++) {
    		//console.log(array[i][key]);
    		if(array[i][key] == value) {
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
    		var p = getEntryByKey(projects, "name", projectName);
    		//Cria se o id for a flag de 'não encontrado' ou se o cliente do projecto não é o cliente pretendido
    		if(p && (p.id < 0 || p.cid != cid)) {
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
    	toggl.getClients(function(err, clients) {
    		var c = getEntryByKey(clients, "name", clientName);
    		if(c && c.id < 0) {
    			toggl.createClient({"name":clientName, "wid":WID}, function(err, clientData) {
    				console.log("Created client:", clientName, clientData.id);
    				startTimeWithCid(clientData.id, projectName, timeDescription);
    			});
    		} else {
    			if(c) {
    				console.log('ClientId: '+c.id);
    				startTimeWithCid(c.id, projectName, timeDescription);
    			} else {
    				console.log('No client');
    				startTimeWithCid(null, projectName, timeDescription);
    			}
    		}
    	});
    }


    server = connect().use('/status', function fooMiddleware(req, res, next) {
            toggl.getCurrentTimeEntry(function(err, timeEntry) {
                if(timeEntry) {
                    res.end("On");
                } else {
                    res.end("Off");
                }
            });
        }).use('/start', function fooMiddleware(req, res, next) {
            var args = req.url.substr(1).split('/');
            startTime(decodeURI(args[0]), args[1]?decodeURI(args[1]):"Generic", decodeURI(args[2]));
        }).use('/stop', function fooMiddleware(req, res, next) {
            toggl.getCurrentTimeEntry(function(err, timeEntry) {
                toggl.stopTimeEntry(timeEntry.id, function(err) {
                        res.end('Stop: '+timeEntry.description);
                });
            });
        }).use(connect["static"](path.resolve(__dirname, './public'))).use(WidgetCommandServer(widgetDir)).use(WidgetsServer(widgetDir)).use(changesServer.middl
    ###
