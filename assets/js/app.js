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

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
// update select fields
function updateSubtypeOptions() {
  const typeSelect = document.getElementById("investment-type");
  const subtypeSelect = document.getElementById("investment-subtype");
  const selectedType = typeSelect.value;

  const subtypes = {
    renda_fixa: ["cdb", "lci_lca", "cri_cra", "debentures"],
    fundos: ["renda_fixa", "multimercado"],
    tesouro_direto: ["selic", "prefixado", "ipca"],
    renda_variavel: ["fiis"],
  };

  const options = subtypes[selectedType] || [];
  subtypeSelect.innerHTML = '<option value="">Choose a value</option>';

  options.forEach((option) => {
    const opt = document.createElement("option");
    opt.value = option;
    opt.text = option;
    subtypeSelect.add(opt);
  });
}

window.updateSubtypeOptions = updateSubtypeOptions;

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

