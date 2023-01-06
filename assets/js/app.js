// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}

Hooks.MapHandler = {
  mounted() {

    const handleNewTruckFunction = ({ truck }) => {
      var pinColor = truck.pin_color;
      var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
          new google.maps.Size(21, 34),
          new google.maps.Point(0,0),
          new google.maps.Point(10, 34));
      var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
          new google.maps.Size(40, 37),
          new google.maps.Point(0, 0),
          new google.maps.Point(12, 35));
      var markerPosition = { lat: truck.latitude, lng: truck.longitude }

      const marker = new google.maps.Marker({
        position: markerPosition,
        animation: google.maps.Animation.DROP,
        icon: pinImage,
        shadow: pinShadow
      })

      // To add the marker to the map, call setMap();
      marker.setMap(window.map)

      var content = 
            '<div id="content">' +
              '<div id="siteNotice">' +
              "</div>" +
              '<h1 id="firstHeading" class="text-black text-lg font-bold">' + truck.title +  '</h1>' +
              '<h2 id="openTimes" class="text-black text-sm font-bold">Open: ' + truck.day + " " + truck.open_times +  '</h2>' +
              '<div id="bodyContent" class="mt-3 text-blue-700">' +
                '<p >' + truck.optional_text + '</p>'
              "</div>" +
            "</div>";

      var infoWindow = new google.maps.InfoWindow();
      google.maps.event.addListener(marker, 'click', function () {
                var markerContent = content;
                infoWindow.setContent(markerContent);
                infoWindow.open(map, this);
            });
    };

    // handle new trucks as they show up
    this.handleEvent("new_truck", handleNewTruckFunction)
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

