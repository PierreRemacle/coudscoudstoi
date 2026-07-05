import { Controller } from "@hotwired/stimulus"

// Manages single-selection chip/segmented groups.
// Sets is-active on the clicked chip and updates a hidden input by id.
export default class extends Controller {
  select(event) {
    const btn = event.currentTarget
    const value = btn.dataset.chipValueParam
    const targetId = this.element.dataset.chipTargetParam
    const alreadyActive = btn.classList.contains("is-active")

    this.element.querySelectorAll(".chip, .seg-btn, .seg-tab").forEach(el => el.classList.remove("is-active"))

    if (!alreadyActive) {
      btn.classList.add("is-active")
    }

    if (targetId) {
      const input = document.getElementById(targetId)
      if (input) input.value = alreadyActive ? "" : value
    }
  }
}
