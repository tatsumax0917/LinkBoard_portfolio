import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lock-id"
export default class extends Controller {
  static targets = ["lock", "editButton"] // ボタンのターゲットを追加
  isLocked = false; // 初期状態をfalseに

  connect() {
    // 初期状態でボタンテキストを設定
    this.updateButtonText();
  }

  change() {
    this.isLocked = !this.isLocked; // 状態を反転させる
    this.updateButtonText(); // テキストを更新
  }

  updateButtonText() {
    if (this.isLocked) {
      this.lockTarget.disabled = false; // 入力をロック
      this.editButtonTarget.textContent = "IDロック"; // ボタンテキストを変更
    } else {
      this.lockTarget.disabled = true; // 入力を解除
      this.editButtonTarget.textContent = "IDを編集"; // ボタンテキストを変更
    }
  }
}