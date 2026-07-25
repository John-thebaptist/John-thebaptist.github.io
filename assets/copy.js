/* Copy-to-clipboard for terminal blocks.
   Progressive enhancement: buttons are injected here, so with JavaScript
   disabled the code stays fully readable and no dead control is shown. */
(function () {
  "use strict";

  var RESET_MS = 1800;
  var timers = new WeakMap();

  function label(button, text, state) {
    button.textContent = text;
    if (state) {
      button.setAttribute("data-state", state);
    } else {
      button.removeAttribute("data-state");
    }
    // Mirror into a live region so the change is announced, not just seen.
    var status = button.parentNode.querySelector(".terminal__status");
    if (status) status.textContent = state ? text : "";
  }

  function feedback(button, text, state) {
    label(button, text, state);
    clearTimeout(timers.get(button));
    timers.set(
      button,
      setTimeout(function () {
        label(button, "Copy", null);
      }, RESET_MS)
    );
  }

  /* Fallback for browsers or contexts where the async clipboard API is
     unavailable (non-secure origins, older engines). */
  function legacyCopy(text) {
    var area = document.createElement("textarea");
    area.value = text;
    area.setAttribute("readonly", "");
    area.style.position = "fixed";
    area.style.top = "-1000px";
    area.style.opacity = "0";
    document.body.appendChild(area);
    area.select();
    var ok = false;
    try {
      ok = document.execCommand("copy");
    } catch (err) {
      ok = false;
    }
    document.body.removeChild(area);
    return ok;
  }

  function fallback(button, text) {
    var ok = legacyCopy(text);
    feedback(button, ok ? "Copied" : "Copy failed", ok ? "done" : "error");
  }

  function copy(button) {
    var code = button.parentNode.querySelector("pre code");
    if (!code) return;
    var text = code.textContent;

    if (navigator.clipboard && window.isSecureContext) {
      navigator.clipboard.writeText(text).then(
        function () {
          feedback(button, "Copied", "done");
        },
        function () {
          fallback(button, text);
        }
      );
      return;
    }

    fallback(button, text);
  }

  function build() {
    var terminals = document.querySelectorAll(".terminal");
    Array.prototype.forEach.call(terminals, function (terminal) {
      if (terminal.querySelector(".terminal__copy")) return;

      var button = document.createElement("button");
      button.type = "button";
      button.className = "terminal__copy";
      button.textContent = "Copy";

      var name = terminal.querySelector(".terminal__label");
      button.setAttribute(
        "aria-label",
        name ? "Copy " + name.textContent + " code to clipboard" : "Copy code to clipboard"
      );

      var status = document.createElement("span");
      status.className = "terminal__status visually-hidden";
      status.setAttribute("role", "status");
      status.setAttribute("aria-live", "polite");

      terminal.appendChild(button);
      terminal.appendChild(status);
    });
  }

  function init() {
    build();
    document.addEventListener("click", function (event) {
      var button = event.target.closest && event.target.closest(".terminal__copy");
      if (button) copy(button);
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
