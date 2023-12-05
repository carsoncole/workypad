import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }

  static targets = [ "hideable" ]

  toggleTargets() {
    this.hideableTargets.forEach((el) => {
      el.style.display = el.style.display == 'block' ? 'none' : 'block';
    });
  }
}
