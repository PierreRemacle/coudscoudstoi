import { Controller } from "@hotwired/stimulus"

// Manages multi-selection check-styled labels.
// Toggles is-active and the hidden checkbox inside each label.
export default class extends Controller {
  // For chip-style buttons (filter sidebar)
  toggleChip(event) {
    const btn = event.currentTarget
    const checkbox = btn.querySelector("input[type=checkbox]")
    btn.classList.toggle("is-active")
    if (checkbox) checkbox.checked = btn.classList.contains("is-active")
  }

  // For check-style labels (patron form)
  toggle(event) {
    const label = event.currentTarget
    const checkbox = label.querySelector("input[type=checkbox]")

    label.classList.toggle("is-on")
    const icon = label.querySelector(".check-box")

    if (label.classList.contains("is-on")) {
      checkbox.checked = true
      if (icon) icon.innerHTML = '<i data-lucide="check"></i>'
    } else {
      checkbox.checked = false
      if (icon) icon.innerHTML = ""
    }

    if (window.lucide) lucide.createIcons()
  }
}
