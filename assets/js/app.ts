// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";

// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix";
import {LiveSocket} from "phoenix_live_view";
import { CodeEditorHook } from "../../deps/live_monaco_editor/priv/static/live_monaco_editor.esm"

// Extend the window interface to include liveSocket.
declare global {
  interface Window {
    liveSocket: LiveSocket;
  }
}

// CSRF token.
let csrfToken = document.querySelector("meta[name='csrf-token']")?.getAttribute("content");

// Live Socket.
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: {CodeEditorHook},
  params: {_csrf_token: csrfToken},
});

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

// Autofocus editor on mount.
window.addEventListener("lme:editor_mounted", (event: any) => {
  event.detail.editor.standalone_code_editor.focus();
});
