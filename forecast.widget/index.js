render: function () { return '<!-- <link type="text/css" href="forecast.widget/style.css" rel="stylesheet"> -->  <div class="fe-forecast loading" style="display:flex; flex-direction:row;">      <div class="fe-currently" id="current-weather" style="display:flex; flex-direction:column;">         <!-- Top of Current Weather -->         <div style="display:flex; flex-direction:row;">             <div id="fe-current-icon" class="weather-icon big"></div>             <div style="display:flex; flex-direction:column;">                 <div class="fe-temp"></div>                 <div class="fe-temp-direction" id="temp-direction"></div>             </div>         </div>         <!-- Bottom of Current Weather -->         <div class="fe-more-info" style="display:flex; flex-direction:column;">             <div class="fe-summary"></div>             <div class="fe-wind"></div>         </div>     </div>      <div class="days" style="display:flex; flex-direction:row;">         <div id="day0" style="display:flex; flex-direction:column;">             <div class="day-text"></div>             <div class="weather-icon"></div>             <div class="temp-range">                 <div class="center-bar">                     <div class="bar"></div>                 </div>             </div>         </div>         <div id="day1" style="display:flex; flex-direction:column;">             <div class="day-text"></div>             <div class="weather-icon"></div>             <div class="temp-range">                 <div class="center-bar">                     <div class="bar"></div>                 </div>             </div>         </div>         <div id="day2" style="display:flex; flex-direction:column;">             <div class="day-text"></div>             <div class="weather-icon"></div>             <div class="temp-range">                 <div class="center-bar">                     <div class="bar"></div>                 </div>             </div>         </div>         <div id="day3" style="display:flex; flex-direction:column;">             <div class="day-text"></div>             <div class="weather-icon"></div>             <div class="temp-range">                 <div class="center-bar">                     <div class="bar"></div>                 </div>             </div>         </div>         <div id="day4" style="display:flex; flex-direction:column;">             <div class="day-text"></div>             <div class="weather-icon"></div>             <div class="temp-range">                 <div class="center-bar">                     <div class="bar"></div>                 </div>             </div>         </div>         <div id="day5" style="display:flex; flex-direction:column;">             <div class="day-text"></div>             <div class="weather-icon"></div>             <div class="temp-range">                 <div class="center-bar">                     <div class="bar"></div>                 </div>             </div>         </div>         <div id="day6" style="display:flex; flex-direction:column;">             <div class="day-text"></div>             <div class="weather-icon"></div>             <div class="temp-range">                 <div class="center-bar">                     <div class="bar"></div>                 </div>             </div>         </div>         <div id="day7" style="display:flex; flex-direction:column;">             <div class="day-text"></div>             <div class="weather-icon"></div>             <div class="temp-range">                 <div class="center-bar">                     <div class="bar"></div>                 </div>             </div>         </div>     </div> </div> '; },
style: '@charset "UTF-8"; #forecast-widget-index-js {   bottom: 90px;   right: -88px;   width: 360px;   font-family: Roboto;   color: rgba(255,255,255,0.35);   text-align: center; }  @font-face {   font-family: Weather;   src: url("forecast.widget/icons.svg") format("svg"); }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-Thin.ttf") format("truetype");   font-weight: 100;   font-style: normal; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-ThinItalic.ttf") format("truetype");   font-weight: 100;   font-style: italic; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-Light.ttf") format("truetype");   font-weight: 300;   font-style: normal; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-LightItalic.ttf") format("truetype");   font-weight: 300;   font-style: italic; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-Regular.ttf") format("truetype");   font-weight: 400;   font-style: normal; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-RegularItalic.ttf") format("truetype");   font-weight: 400;   font-style: italic; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-Medium.ttf") format("truetype");   font-weight: 500;   font-style: normal; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-MediumItalic.ttf") format("truetype");   font-weight: 500;   font-style: italic; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-Bold.ttf") format("truetype");   font-weight: 700;   font-style: normal; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-BoldItalic.ttf") format("truetype");   font-weight: 700;   font-style: italic; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-Black.ttf") format("truetype");   font-weight: 900;   font-style: normal; }  @font-face {   font-family: Roboto;   src: url("forecast.widget/fonts/Roboto-BlackItalic.ttf") format("truetype");   font-weight: 900;   font-style: italic; }  .fe-forecast {   opacity: 1;   -webkit-transition: opacity 0.5s; }  .weather-icon {   width: 25px;   height: 25px;   background-size: cover; }   .weather-icon.big {     width: 80px;     height: 80px; }  .fe-temp {   width: 90px;   font-weight: 700;   font-size: 50px;   letter-spacing: -1px; }  .fe-temp::after {   content: "°"; }  .fe-temp-direction {   margin-top: -6px;   margin-right: 5px;   font-size: 13px;   text-align: center; }  .days {   width: 100%; }  .days > div {   width: 12.5%;   -webkit-align-content: center;   align-content: center; }  .days .weather-icon {   margin-left: auto;   margin-right: auto;   background: rgba(255,255,255,0.35);   -webkit-mask-position: 0 0;   -webkit-mask-image: url("");   -webkit-mask-size: 25px 25px; }  .day-text {   font-weight: 900;   font-size: 12px; }  .temp-range {   position: relative;   width: 100%;   height: 100px;   margin-top: 15px; }   .temp-range .center-bar {     margin-left: auto;     margin-right: auto;     width: 20px; }     .temp-range .center-bar .bar {       position: absolute;       width: 20px;       border-radius: 20px;       background-color: rgba(255,255,255,0.35);       -webkit-transition: top 0.5s, bottom 0.5s; }       .temp-range .center-bar .bar::before {         position: absolute;         top: -14px;         left: 4px;         content: attr(data-content-high);         font-weight: 300;         font-size: 11px; }       .temp-range .center-bar .bar::after {         position: absolute;         left: 4px;         bottom: -15px;         content: attr(data-content-low);         font-weight: 300;         font-size: 11px; }  #fe-current-icon {   background: rgba(255,255,255,0.35);   -webkit-mask-position: 0 0;   -webkit-mask-image: url("");   -webkit-mask-size: 80px 80px; }  .fe-more-info {   margin-top: 5px; }   .fe-more-info .fe-summary {     font-weight: bold;     font-size: 18px; }  .fe-currently {   width: 260px; }   .fe-currently:first-child {     margin-top: 5px; }   .fe-currently:last-child {     margin-bottom: auto; }   .fe-currently .fe-wind {     font-weight: 300;     font-size: 14px; }  .prepare-loading {   transition: opacity 0.5s; }  .loading {   opacity: 0; } ',

    // ################################# BEGIN SETTINGS #################################
    // To get your own API key, go to https://developer.forecast.io/                    #
    api_key: '9c4dda3ec3a895232661210bef8c0753', // Put your Forcast.io api key inside the quotes here          #
    refresh_rate: 300000, // Time in milliseconds between refreshes                     #
    lat: '38.7471569', // Options are auto, or a valid latitude (auto doesn't always work)    #
    lon: '-9.1442295', // Options are auto, or a valid longitude (auto doesn't always work)   #
    units: 'si', // Options are us, si, ca, uk, auto                                  #
    onclick_link: 'http://www.wunderground.com', // Link to open when widget is clocked #
    // ################################## END SETTINGS ##################################

    command: '',
    refreshFrequency: false,

    // Runs once at the load of the script
    afterRender: function () {

        // A workaround to use scss instead of stylus
        var widget = $('#forecast-widget-index-js');
        for (var i = 0; i < document.styleSheets.length; i++) {
            if (document.styleSheets[i].ownerNode.nextElementSibling.id === 'forecast-widget-index-js') {
                for (var j in document.styleSheets[i].rules[0].style) {
                    if (typeof document.styleSheets[i].rules[0].style[j] === 'string' && document.styleSheets[i].rules[0].style[j] !== '') {
                        widget.css(j, document.styleSheets[i].rules[0].style[j]);
                    }
                }
                break;
            }
        }

        // Keeping a constant context through varying scopes
        var uber = this;

        // Show an error if no API key is set
        if (uber.api_key === 'API_KEY') {
            widget.html(uber.api_instructions);
            widget.css('text-shadow', '1px 1px 15px rgb(0, 0, 0)');
            widget.css('font-weight', 900);
            widget.css('font-size', '20px');
            return;
        }

        // Executes shell command (curl)
        var ready = function () {
            uber.run(uber.command, function () {});
            uber.refresh();
            setInterval(function () {
                uber.run(uber.command, function () {});
                uber.refresh();
            }, uber.refresh_rate);
        };

        // Gets the location and makes the shell command to send to forecast.io
        if (uber.lat == 'auto' && uber.lon == 'auto') {
            geolocation.getCurrentPosition(function (e) {
                uber.lat = e.position.coords.latitude;
                uber.lon = e.position.coords.longitude;
                uber.command = uber.makeCommand(uber.api_key, uber.lat + ',' + uber.lon, uber.units);
                ready();
            });
        } else {
            uber.command = uber.makeCommand(uber.api_key, uber.lat + ',' + uber.lon, uber.units);
            ready();
        }

        // Opens a specified link when the widget is clicked
        $('#forecast-widget-index-js').click(function () {
            uber.run('open ' + uber.onclick_link, function () {});
        });
    },

    // Makes the shell command to execute (curl)
    makeCommand: function (api_key, location, units) {
        var exclude = 'minutely,alerts,flags';
        return 'curl -sS "https://api.forecast.io/forecast/' + api_key + '/' + location + '?units=' + units + '&exclude=' + exclude + '"';
    },

    // Runs every <refresh_rate> milliseconds
    update: function (output) {
        // Make sure that we have valid JSON (first run is empty, no api key is Forbidden)
        if (output && output !== '' && output !== 'Forbidden\n') {
            output = JSON.parse(output);

            // Temperature direction (rising or falling)
            var next_hour_temp = output.hourly.data[1].temperature; // Next hour's temp
            var current_temp = output.currently.temperature; // Current temp
            if (next_hour_temp > current_temp) {
                $('#temp-direction').text('and rising');
            } else {
                $('#temp-direction').text('and falling');
            }

            // Temperature and summary
            $('.fe-temp').text(Math.round(current_temp));
            $('.fe-summary').text(output.currently.summary);

            // Wind speed and bearing
            var wind_speed = Math.round(output.currently.windSpeed);
            var wind_speed_units = this.unit_labels[this.units || 'us'].speed;
            var wind_bearing = this.bearing(output.currently.windBearing);
            $('.fe-wind').text('Wind: ' + wind_speed + ' ' + wind_speed_units + ' (' + wind_bearing + ')');

            // Icon
            this.changeIcon($('#fe-current-icon'), output.currently.icon);

            // TODO: Check if there is a output.weekly.high / low
            // Find the max and min temperatures for the week
            var temp_min_week = 1000;
            var temp_max_week = -1000;
			var i_mimes = 0;
            for (var day in output.daily.data) {
				if(i_mimes++ > 3) continue;

                if (output.daily.data[day].temperatureMax > temp_max_week) {
                    temp_max_week = output.daily.data[day].temperatureMax;
                }
                if (output.daily.data[day].temperatureMin < temp_min_week) {
                    temp_min_week = output.daily.data[day].temperatureMin;
                }
            }

			i_mimes = 0;
            for (day in output.daily.data) {

				if(i_mimes++ > 3) continue;

                // Change current day's name
                $('#day' + day).find('.day-text').text(this.dayMapping[new Date(output.daily.data[day].time * 1000).getDay()]);

                // Set day's weather icon
                this.changeIcon($('#day' + day).find('.weather-icon'), output.daily.data[day].icon);

                // Temperature bars
                var day_high = Math.round(output.daily.data[day].temperatureMax) + '°';
                var day_low = Math.round(output.daily.data[day].temperatureMin) + '°';
                var day_high_rel = this.map(output.daily.data[day].temperatureMax, temp_min_week, temp_max_week, 0, 1);
                var day_low_rel = this.map(output.daily.data[day].temperatureMin, temp_min_week, temp_max_week, 0, 1);
                var height = 100;
                $('#day' + day).find('.bar').attr('data-content-high', day_high);
                $('#day' + day).find('.bar').attr('data-content-low', day_low);
                $('#day' + day).find('.bar').css('top', height - (day_high_rel * height));
                $('#day' + day).find('.bar').css('bottom', day_low_rel * height);
            }
            // Makes the widget visible after it's loaded
            $('.fe-forecast').removeClass('loading');

        } else {
            // Show an error message if API key is invalid
            if (output === 'Forbidden\n') {
                var widget = $('#forecast-widget-index-js');
                widget.html(this.api_instructions);
                widget.css('text-shadow', '1px 1px 15px rgb(0, 0, 0)');
                widget.css('font-weight', 900);
                widget.css('font-size', '20px');
            }
        }
    },

    // Fades icons out and in (and handles loading them)
    changeIcon: function (element, icon) {
        if (element.css('-webkit-mask-image') !== 'url(' + window.location.origin + '/forecast.widget/icons/' + icon + '.png)') {
            if (element.css('-webkit-mask-image') === 'url(' + window.location.origin + '/)') {
                element.addClass('loading');
                element.addClass('prepare-loading');
                element.css('-webkit-mask-image', 'url(forecast.widget/icons/' + icon + '.png)');
                element.removeClass('loading');
                setTimeout(function () {
                    element.removeClass('prepare-loading');
                }, 500);
            } else {
                element.addClass('prepare-loading');
                element.addClass('loading');
                setTimeout(function () {
                    element.css('-webkit-mask-image', 'url(forecast.widget/icons/' + icon + '.png)');
                    element.removeClass('loading');
                    setTimeout(function () {
                        element.removeClass('prepare-loading');
                    }, 500);
                }, 500);
            }
        }
    },

    // Maps a value in range A to a value in range B
    map: function (x, in_min, in_max, out_min, out_max) {
        return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
    },

    // Returns a readable (N, S, E, W, etc) bearing based on degrees
    bearing: function (bearing) {
        var direction_index = Math.round(bearing / 45);
        return ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW', 'N'][direction_index];
    },

    unit_labels: {
        auto: {
            speed: 'mph'
        },
        us: {
            speed: 'mph'
        },
        si: {
            speed: 'm/s'
        },
        ca: {
            speed: 'km/h'
        },
        uk: {
            speed: 'mph'
        }
    },

    dayMapping: {
        0: 'Sun',
        1: 'Mon',
        2: 'Tue',
        3: 'Wed',
        4: 'Thu',
        5: 'Fri',
        6: 'Sat'
    },

    api_instructions: '<b>Installation Instructions</b><br>Replace "API_KEY" in index.js with an API key obtained from https://developer.forecast.io/'
