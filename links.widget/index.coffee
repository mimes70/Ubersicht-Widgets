command: "links.widget/lighthouse.sh && links.widget/pivotal_people.sh"

refreshFrequency: 600000

style: """
  top: 15px
  left: 15px
  color: #fff
  font-family: Helvetica Neue
  border-radius: 10px;

  a
    text-decoration:none

  p
    margin:3px
    padding-left: 5px
    font-size: 13px;
    font-weight: 400
    text-shadow: 0 1px 5px #000000;

  .task
    font-weight: 200
    padding-left: 15px
    text-shadow:none

  table
    padding-top:10px

  tr
    height: 50px

  .tickets
    //border-bottom-style: solid;
    //border-bottom-width: 1px;
    //border-bottom-color: rgba(#fff, 0.3)
    background-color:rgba(0,0,0,0.3);
    border-radius: 4px;

  .logoCoB
    bottom: 5px;
    margin-left: 7px;
    margin-right:13px
    border-radius: 10px;
    background-color: #d5184b;
    text-align: center;
    vertical-align: middle;
    height: 31px;

  .symbolCoB
    margin: 0px;
    padding: 0px;
    font-size: 32px;
    font-family: verdana;
    color: #fff;
    font-weight: bolder;

  .cgd
    border-radius: 10px;
    background-color: rgba(#fff, 0.7);
    padding: 2px

"""


render: -> """
  <table>
    <tr>
      <td>
        <a href="https://cob.lighthouseapp.com/dashboard">
          <img style="width:36px;margin-left:6px" src="links.widget/images/lighthouse.png">
          </a>
      </td>
      <td class="tickets lighthousetickets">
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://www.pivotaltracker.com/n/workspaces/111914">
          <img style="width:36px;margin-left:5px" src="links.widget/images/pivotaltracker.png">
        </a>
      </td>
      <td class="tickets pivotaltickets">
    </tr>
    <tr>
      <td>
        <a href="https://dogfooding.cultofbits.com">
          <div class="logoCoB">  <div class="symbolCoB">*</div>  </div>
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com">
          <img style="width:47px;" src="links.widget/images/github.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://trello.com">
          <img style="width:32px;margin-left:7px" src="links.widget/images/trello.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="http://daytum.com/mimes70">
          <img style="width:32px;margin-left:7px" src="links.widget/images/daytum.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://andyet.talky.io/cob">
          <img style="width:32px;margin-left:7px" src="links.widget/images/talky.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="http://devdocs.io/">
          <img style="width:32px;margin-left:7px" src="links.widget/images/html5.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://cultofbits.kindlingapp.com/login?from=%2F#all-activity">
          <img style="width:62px;margin-left:-9px" src="links.widget/images/kindling.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://www.cgd.pt/Pages/Default.aspx">
          <img class="cgd" style="width:28px;margin-left:6px" src="links.widget/images/cgd.gif">
        </a>
      </td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')

  table     = $('.lighthousetickets')
  table.empty()
  for process, i in processes.slice(0,2)
    table.append "<p>#{process}</p>"

  table     = $('.pivotaltickets')
  table.empty()
  for process, i in processes.slice(2)
    table.append "<p class=\"#{'task' if (process.charCodeAt(0)==32)}\">#{process}</p>"
