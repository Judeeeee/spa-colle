import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(event) {
    event.stopPropagation();
    const menu = this.element.querySelector(".dropdown-menu");

    if (menu) {
      menu.classList.toggle("hidden");
    }
  }
}

// ドロップダウンメニュー以外をクリックすると、メニューが閉じる
document.addEventListener("click", (event) => {
  document
    .querySelectorAll("[data-controller='dropdown']")
    .forEach((dropdown) => {
      const menu = dropdown.querySelector(".dropdown-menu");
      if (menu && !dropdown.contains(event.target)) {
        menu.classList.add("hidden");
      }
    });
});
