command: "links.widget/pivotal_people.sh"

refreshFrequency: 1200000

style: """
"""


render: -> """
"""

update: (output, domEl) ->
  processes = output.split('\n')

  table     = $('.pivotaltickets')
  table.empty()
  for process, i in processes
    table.append "<p class=\"#{'task' if (process.charCodeAt(0)==32)}\">#{process}</p>"
