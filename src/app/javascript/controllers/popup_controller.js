import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "popup" ]

  toggle() {
    this.popupTarget.style.display = (this.popupTarget.style.display === 'block') ? 'none' : 'block'
  }

  close() {
    this.popupTarget.style.display = 'none'
  }
}