import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="link-form"
export default class extends Controller {
  static targets = ["linkName", "linkUrl"]
  
  connect() {
  }

  // リンクフォームにURLペースト
  paste(event) {
    const parentItem = event.target.closest('.links__item');
    const linkUrlInput = parentItem.querySelector('input[data-link-form-target="linkUrl"]');
    navigator.clipboard.readText().then(function(text){
        linkUrlInput.value = text;
      }).catch(function(err) {
        console.error('クリップボードの内容の取得に失敗しました:', err);
      });
  }

  // フォームの内容リセット
  reset(event) {
    // 最も近い .links__item を取得
    const parentItem = event.target.closest('.links__item');
    // 親の.links__itemからlinkNameの子要素を取得
    const linkNameInput = parentItem.querySelector('input[data-link-form-target="linkName"]');
    const linkUrlInput = parentItem.querySelector('input[data-link-form-target="linkUrl"]');

    if (confirm('フォームの内容をリセットしますか？')) {
      linkNameInput.value = '';
      linkUrlInput.value = '';
    }
  }

}
