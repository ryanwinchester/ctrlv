// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";

// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix";
import {LiveSocket} from "phoenix_live_view";
import {Editor} from "./hooks";
import topbar from "../vendor/topbar";

// Extend the window interface to include liveSocket.
declare global {
  interface Window {
    liveSocket: LiveSocket;
  }
}

// Show progress bar on live navigation and form submits.
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"});
window.addEventListener("phx:page-loading-start", info => topbar.show());
window.addEventListener("phx:page-loading-stop", info => topbar.hide());

// CSRF token.
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

// Live Socket.
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: {Editor},
  params: {_csrf_token: csrfToken},
});

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
