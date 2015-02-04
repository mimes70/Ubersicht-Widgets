command: "links.widget/lighthouse.widget/lighthouse.sh && cat /Users/mimes/Dropbox/Application\\ Support/--Scripts--/bash/pivotal_people.output"

refreshFrequency: 20000

style: """
  top: 15px
  left: 150px
  color: #fff
  font-family: Helvetica Neue

  table
    border-collapse: collapse
    table-layout: fixed

  .alarm
    background: rgba(#f00, 0.4)

  td
    border: 1px solid #fff
    font-size: 24px
    font-weight: 100
    width: 110px
    max-width: 110px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative
    background: rgba(#fff, 0.1)

  p
    padding: 0
    margin: 0
    font-size: 11px
    font-weight: normal
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis
    text-shadow: none

  .type
    position: absolute
    top: 2px
    right: 2px
    font-size: 15px
    font-weight: normal

"""


render: -> """
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $('.lighthousetickets')
  table.empty()

  for process, i in processes
    table.append "<p>#{process}</p>"
