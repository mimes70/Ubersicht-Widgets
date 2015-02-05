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

refreshFrequency: 5000

style: """
  bottom: 55px
  left:1032px
  text-align:center
  color: #fff

  .output
    font-family: Helvetica Neue
    font-weight: 100
    text-shadow: 0 1px 5px #000000;

  .task
    font-size: 30px
    color:red
    font-weight: 200
    text-decoration: none

  .project
    font-size: 26px
    color:white
    text-decoration: none

  .area
    font-size: 20px
    color:white
    text-decoration: none
"""

render: (output) -> @getVisual output

update: (output, domEl) ->
  $domEl = $(domEl)
  $domEl.html @getVisual output

getVisual: (output) ->
  console.log(output)
  data = []
  try
    data = JSON.parse output
  catch ex
    return """
      <div class='github-notifications #{if @enterprise then "enterprise" else "public"}'>
        <span>Error: #{output}</span>
      </div>
    """
  return """
      <div class="output">
        <a href="#{data.task}" class="task">#{data.task}</a>
        <br/>
        <a href="#{data.project}" class="project">#{data.project}</a>
        &nbsp;(<a href="spotify:search:#{data.area}" class="area">#{data.area}</a>)
      </div>
  """
