import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "list", "zone", "label", "icon", "attach", "attachIcon", "attachText"]

  connect() {
    this.type = this.element.dataset.dropzoneTypeValue
  }

  change(event) {
    const files = Array.from(event.target.files)
    if (!files.length) return
    this.type === "image" ? this.showPreviews(files) : this.showFiles(files)
  }

  showPreviews(files) {
    if (this.hasLabelTarget) {
      this.labelTarget.textContent = `${files.length} photo${files.length > 1 ? "s" : ""} sélectionnée${files.length > 1 ? "s" : ""}`
    }
    if (this.hasIconTarget) {
      this.iconTarget.innerHTML = '<i data-lucide="check-circle-2"></i>'
      this.iconTarget.style.background = "#f0fdf4"
      this.iconTarget.style.color = "#2f9e6b"
    }
    if (this.hasPreviewTarget) {
      this.previewTarget.innerHTML = ""
      files.forEach(file => {
        const reader = new FileReader()
        reader.onload = e => {
          const img = document.createElement("img")
          img.src = e.target.result
          img.style.cssText = "width:80px;height:80px;object-fit:cover;border-radius:8px;"
          this.previewTarget.appendChild(img)
        }
        reader.readAsDataURL(file)
      })
    }
    if (window.lucide) lucide.createIcons()
  }

  showFiles(files) {
    if (this.hasListTarget) {
      this.listTarget.innerHTML = ""
      files.forEach(file => {
        const row = document.createElement("div")
        row.className = "file-row"
        row.innerHTML = `
          <span class="file-ico"><i data-lucide="file-text"></i></span>
          <div style="flex:1;min-width:0">
            <div class="file-name">${file.name}</div>
            <div class="file-meta">${formatSize(file.size)}</div>
          </div>
          <i data-lucide="check-circle-2" style="color:#2f9e6b"></i>
        `
        this.listTarget.appendChild(row)
      })
    }
    if (this.hasAttachTarget) {
      const count = files.length
      if (this.hasAttachTextTarget) {
        this.attachTextTarget.textContent = `${count} fichier${count > 1 ? "s" : ""} sélectionné${count > 1 ? "s" : ""}`
      }
      if (this.hasAttachIconTarget) {
        this.attachIconTarget.setAttribute("data-lucide", "check")
      }
      this.attachTarget.style.color = "#2f9e6b"
      this.attachTarget.style.borderColor = "#bbf7d0"
    }
    if (window.lucide) lucide.createIcons()
  }
}

function formatSize(bytes) {
  if (bytes < 1024) return `${bytes} o`
  if (bytes < 1048576) return `${(bytes / 1024).toFixed(1)} Ko`
  return `${(bytes / 1048576).toFixed(1)} Mo`
}
