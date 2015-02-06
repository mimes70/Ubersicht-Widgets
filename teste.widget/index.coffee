command: ""

refreshFrequency: 10000000

style: """
  .ui-widget-content
    background:rgba(white,0.2)

  #draggable
    width: 15px
    height: 15px
    padding: 0.5em
"""

render: (output) -> """
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <div id="draggable" class="ui-widget-content" onclick="$('#draggable').draggable(); $('#draggable').resizable();;">
    <p></p>
  </div>
"""
