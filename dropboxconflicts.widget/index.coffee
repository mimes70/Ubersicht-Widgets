command: "find ~/Dropbox/ -name '*onflicted*'"

#ligação à lidl?: netstat -an| grep "2345" | grep LISTEN | say -v Joana
#verificação de mudança de IPs: dig app.chooseyouroutfit.com | grep "54.165.242.4" &&  say -v Joana "IP alterado" || ( echo "Not Yet"; False )

refreshFrequency: 60000

style: """
  bottom: 100px
  left: 15px
  color: #fff
  font-family: Helvetica Neue
  border-radius: 10px;

  div
    width:1000px

  p
    margin:0px
    font-size: 11px;
    font-weight: 400
    text-shadow:none
"""


render: -> """
  <div class="conflicts"/>
"""

update: (output, domEl) ->
  conflicts = output.split('\n')

  placeholder     = $('.conflicts')
  placeholder.empty()
  for conflict, i in conflicts
    placeholder.append "<p>#{conflict}</p>"
