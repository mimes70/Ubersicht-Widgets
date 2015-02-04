command: "ps axro \"pid, %cpu, ucomm\" | awk 'FNR>1' | head -n 2 | awk '{ printf \"%5.1f%%,%s,%s\\n\", $2, $3, $1}'  && ps aux  | awk 'BEGIN { sum = 0 }  { sum += $3 }; END { print sum }' && sysctl hw.ncpu | awk '{print $2}'"

refreshFrequency: 20000

style: """
  bottom: 15px
  right: 15px
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
  <table>
    <tr>
      <td class='col1'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='type'>cpu</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)

  totalCpuUsage = processes[2]
  cpuQuantity = processes[3]
  alarm = parseInt(totalCpuUsage/cpuQuantity) > 50

  if(alarm)
    table.find("td").toggleClass("alarm")
