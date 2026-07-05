import { Controller } from "@hotwired/stimulus"

// Manages the taille_type tab switcher (Lettres / Chiffres)
// and individual size-button toggles within the active panel.
export default class extends Controller {
  show(event) {
    const btn = event.currentTarget
    const value = btn.dataset.segTabsValueParam
    const panelId = btn.dataset.segTabsPanelParam
    const targetId = this.element.dataset.segTabsTargetParam

    // Switch active tab
    this.element.querySelectorAll(".seg-tab").forEach(el => el.classList.remove("is-active"))
    btn.classList.add("is-active")

    // Show correct size grid
    this.element.querySelectorAll(".size-grid").forEach(el => el.style.display = "none")
    const panel = document.getElementById(panelId)
    if (panel) panel.style.display = ""

    // Update hidden input
    if (targetId) {
      const input = document.getElementById(targetId)
      if (input) input.value = value
    }
  }

  toggleSize(event) {
    const btn = event.currentTarget
    const label = btn.dataset.segTabsLabelParam
    const wrapper = btn.closest("label")
    const checkbox = wrapper?.querySelector("input[type=checkbox]")

    btn.classList.toggle("is-active")
    if (checkbox) checkbox.checked = btn.classList.contains("is-active")
  }
}
