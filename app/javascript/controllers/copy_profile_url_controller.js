import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-url"
export default class extends Controller {
  connect() {
  }

  copy() {
    const link = window.location.href; // 現在のページのURL取得
    navigator.clipboard.writeText(link)
      .then(() => {
        alert('マイページのURLをコピーしました');
      })
      .catch(err => {
        console.error('コピーに失敗しました：', err);
      });
  }
}
