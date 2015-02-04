command: """
read -r running <<<"$(ps -ef | grep \"MacOS/Spotify\" | grep -v \"grep\" | wc -l)" &&
test $running != 0 &&
IFS='|' read -r theArtist theName theId theApp <<<"$(osascript <<<'
    global aname, tname, alname, rate

    set musicapp to item 1 of my appCheck()
    set playerstate to item 2 of my appCheck()

    --return musicapp

    try
    	if musicapp is not "" then
    		--if playerstate is not "Paused"
    		if musicapp is "iTunes" then
    			tell application "iTunes"
    				set {tname, aname, tid} to {name, artist, id} of current track
    				set tpos to player position
    			end tell
    		else if musicapp is "Spotify" then
    			tell application "Spotify"
    				set {tname, aname, tid} to {name, artist, id} of current track
    				set tpos to player position
    			end tell
    		end if
    		return aname & "|" & tname & "|" & tid & "|" & musicapp
    		--end if
    	else
    		return "NA" & "|" & "NA" & "|" & "NA" & "|" & "NA" & "| " & "NA" & "|" & "NA" & "|" & "NA"
    	end if
    on error e
    	return e
    end try

    on appCheck()
    	set apps to {"iTunes", "Spotify"}
    	set playerstate to {}
    	set activeApp to {}
    	repeat with i in apps
    		tell application "System Events" to set state to (name of processes) contains i
    		if state is true then
    			set activeApp to (i as string)
    			using terms from application "iTunes"
    				tell application i
    					if player state is playing then
    						set playerstate to "Playing"
    						exit repeat
    					else
    						set playerstate to "Paused"
    						--exit repeat
    					end if
    				end tell
    			end using terms from
    		else
    			set activeApp to ""
    		end if
    	end repeat
    	return {activeApp, playerstate}
    end appCheck
')" &&
echo '{ "artist":"'$theArtist'","song": "'$theName'", "id": "'$theId'", "app":"''$theApp"}' || echo "Not Connected To Spotify"
"""

refreshFrequency: 2000

style: """
  bottom: 15px
  left: 15px
  color: #fff

  .output
    font-family: Helvetica Neue
    font-weight: 100
    text-shadow: 0 1px 5px #000000;

  .artist
    font-size: 30px
    color:red
    font-weight: 200
    text-decoration: none

  .song
    font-size: 26px
    color:white
    text-decoration: none

  .link
    color:white
    font-size: 15px
    text-decoration: none

"""

render: (output) -> @getVisual output

update: (output, domEl) ->
  $domEl = $(domEl)
  $domEl.html @getVisual output

getVisual: (output) ->
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
        <a href="spotify:search:#{data.artist}" class="artist">#{data.artist}</a>
        <br/>
        <a href="#{data.id}" class="song">#{data.song}</a>
        <a href="spotify:" class="link">↩︎</a>
      </div>
  """
