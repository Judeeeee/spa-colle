import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  close(event) {
    const url = event.target.dataset.url;

    this.element.remove();
    if (url) {
      window.location.href = url;
    }
  }
}
