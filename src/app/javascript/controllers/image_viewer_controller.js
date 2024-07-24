import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "previewImage", "viewer", "background", "container", "reset", "close", "prev", "next" ]

  connect() {
    this.currentIndex = 0
    this.images = []
  }

  openViewer(event) {
    event.preventDefault()
    this.images = this.previewImageTargets.map(img => img.src)
    this.currentIndex = this.previewImageTargets.indexOf(event.target)
    this.updateArrows()
    this.showImage()
    this.viewerTarget.classList.remove("hidden")
  }

  closeImage() {
    this.viewerTarget.classList.add("hidden")
  }

  showImage() {
    const img = document.createElement("img")
    img.src = this.images[this.currentIndex]
    this.containerTarget.innerHTML = ""
    this.containerTarget.appendChild(img)
  }

  prevImage() {
    this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length
    this.updateArrows()
    this.showImage()
  }

  nextImage() {
    this.currentIndex = (this.currentIndex + 1) % this.images.length
    this.updateArrows()
    this.showImage()
  }

  updateArrows() {
    this.prevTarget.style.display = this.currentIndex > 0 ? 'block' : 'none';
    this.nextTarget.style.display = this.currentIndex < this.images.length - 1 ? 'block' : 'none';
  }
}