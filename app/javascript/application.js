// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// content missingを防ぐためにturbo-visit-controlを指定すると、チェックインモーダルが開かなくなる。
// サイトを参考にcontent missingが表示されるのを防いだ
// https://stackoverflow.com/questions/75738570/getting-a-turbo-frame-error-of-content-missing/75881699
document.addEventListener("turbo:frame-missing", (event) => {
  const {
    detail: { response, visit },
  } = event;
  event.preventDefault();
  visit(response.url);
});

document.addEventListener("DOMContentLoaded", function () {
  const alertMessage = document.getElementById("flash-alert");
  if (alertMessage) {
    alert(alertMessage.innerText);
  }
});
