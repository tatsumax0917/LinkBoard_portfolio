import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header-menu"
export default class extends Controller {

  static targets = ["menu", "menuIcon", "bgMask"]
  isOpen = false;
  connect() {
    this.bgMaskTarget.addEventListener('click', () => {
      this.menuTarget.classList.remove('menu--open');
      this.menuIconTarget.classList.remove('hamburger__icon--close');
      this.bgMaskTarget.classList.remove('header__mask--cover');
      this.isOpen = !this.isOpen;
    });
  }

  open_close() {
    if (this.isOpen) {
      this.menuTarget.classList.remove('menu--open');
      this.menuIconTarget.classList.remove('hamburger__icon--close');
      this.bgMaskTarget.classList.remove('header__mask--cover');
      this.isOpen = !this.isOpen;
    } else {
      this.menuTarget.classList.add('menu--open');
      this.menuIconTarget.classList.add('hamburger__icon--close');
      this.bgMaskTarget.classList.add('header__mask--cover');
      this.isOpen = !this.isOpen;
    }
  }
}