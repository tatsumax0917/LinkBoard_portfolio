import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-password-hidden"
export default class extends Controller {
  static targets = ["currentPassword"]

  connect() {
    if (this.currentPasswordTarget) {
      this.currentPasswordTarget.value = '●●●●●●●●●●';
    }
  }

}
