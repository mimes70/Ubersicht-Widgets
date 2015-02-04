command: ""

refreshFrequency: 600000

style: """
  top: 15px
  left: 15px
  color: #fff
  font-family: Helvetica Neue
  //background: rgba(#333, 0.45)
  border-radius: 10px;

  a
    text-decoration:none

  p
    margin:3px
    font-weight: 200
    text-shadow: 0 1px 5px #000000;



  table
    padding-top:10px

  tr
    height: 50px
    vertical-align:top

  .logo
    bottom: 5px;
    margin: 8px;
    border-radius: 10px;
    background-color: #d5184b;
    text-align: center;
    vertical-align: middle;
    height: 31px;

  .symbol
    margin: 0px;
    padding: 0px;
    font-size: 32px;
    font-family: verdana;
    color: #fff;
    font-weight: bolder;
"""


render: -> """
  <table>
    <tr>
      <td>
        <a href="https://cob.lighthouseapp.com/dashboard">
          <img style="width:36px;margin-left:6px" src="links.widget/images/lighthouse.png">
          </a>
      </td>
      <td class="lighthousetickets">
        <p>teste 21</p>
        <p>teste 21</p>
        <p>teste 21</p>
        <p>teste 21</p>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://www.pivotaltracker.com/n/workspaces/111914">
          <img style="width:36px;margin-left:5px" src="links.widget/images/pivotaltracker.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://dogfooding.cultofbits.com">
          <div class="logo">  <div class="symbol">*</div>  </div>
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
  </table>
"""
