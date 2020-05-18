command: ""

refreshFrequency: 6000000

style: """
  top: 15px
  left: 9px
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
    border-bottom-style: solid;
    border-bottom-width: 1px;
    border-top-style: solid;
    border-top-width: 1px;
    border-bottom-color: rgba(#fff, 0.3)
    //background-color:rgba(0,0,0,0.3);
    border-radius: 4px;

  .logoCoB
    margin-left: 8px;
    border-radius: 10px;
    background-color: #d5184b;
    text-align: center;
    vertical-align: middle;
    height: 32px;
    width:32px;

  .symbolCoB
    margin-left: 1px;
    padding-top: 2px;
    font-size: 29px;
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
        <a href="https://dogfooding.cultofbits.com">
          <div class="logoCoB">  <div class="symbolCoB">*</div>  </div>
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://www.evernote.com/Home.action">
          <img style="padding:9px;width:32px;" src="links.widget/images/Evernote.png">
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
        <a href="http://gitlab.com/">
          <img style="width:32px;margin-left:7px" src="links.widget/images/gitlab.svg">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://www.cgd.pt/Pages/Default.aspx">
          <img class="cgd" style="width:28px;margin-left:7px" src="links.widget/images/cgd.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="http://bestof.js.org/">
          <img style="width:32px;margin-left:7px" src="links.widget/images/bestofjs.png">
        </a>
      </td>
      <td>
        <a href="https://nodejs.libhunt.com">
          <img style="width:32px;margin-left:7px" src="links.widget/images/AwesomeJS.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://www.timeanddate.com/worldclock/meetingtime.html?p1=214&p2=146&p3=141&p4=138&p5=133&p6=233&p7=41">
          <img style="width:32px;margin-left:7px" src="links.widget/images/timeanddate.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://my.shelly.cloud/#dashboard">
          <img style="width:32px;margin-left:7px" src="links.widget/images/shelly.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://alexa.amazon.com/spa/index.html">
          <img style="width:32px;margin-left:7px" src="links.widget/images/alexa.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="zoommtg://zoom.us/join?confno=668244305&zc=2&browser=chrome&uname=Miguel">
          <img style="width:32px;margin-left:7px" src="links.widget/images/zoom.us.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="vnc://192.168.33.2">
          <img style="width:32px;margin-left:7px" src="https://cdn-stack.compsmag.com/alternative/wp-content/uploads/sites/28/2020/05/screens_88019.png">
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://portal.eu.lidl.com/vpn/index.html">
          <img style="width:32px;margin-left:7px" src="https://res-3.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_120,w_120,f_auto,b_white,q_auto:eco/49f34540da856c90142c">
        </a>
      </td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')

  table     = $('.pivotaltickets')
  table.empty()
  for process, i in processes
    table.append "<p class=\"#{'task' if (process.charCodeAt(0)==32)}\">#{process}</p>"
