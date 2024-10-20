import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="url-generator"
export default class extends Controller {
  static targets = ["serviceSelect", "accountName", "urlGenerateBtn", "resultArea", "urlCopyBtn"]

  // クラスプロパティとしてセレクトボックスのサービス選択配列（constだとすべてのメソッドからアクセスできない）
  serviceList = {
    default: "",
    X: "x.com",
    Instagram: "instagram.com",
    Tiktok: "tiktok.com",
    TiktokLive: "tiktok.com",
    Youtube: "youtube.com",
    Twicas: "twitcasting.tv",
    Twitch: "twitch.tv",
    // サービスを追加
  }

  connect() {
    // イベントリスナーを設定
    this.accountNameTarget.addEventListener("keydown", (event) => {
      // Enterキーが押された場合
      if (event.key === "Enter") {
        event.preventDefault();
        const url = this.urlGenerate(); // メソッドを呼び出す
        this.resultAreaTarget.textContent = url; // 結果を表示
      }
    });
  }

  // URL生成処理
  urlGenerate() {
    const serviceName = this.serviceSelectTarget.value;
    const accountName = this.accountNameTarget.value;
    const result = this.resultAreaTarget;
    let url = "";

    // 選択されていない場合
    if (serviceName === "default") {
      return url;
    }

    // 通常URLサービス
    if (
      serviceName === "X" ||
      serviceName === "Instagram" ||
      serviceName === "Twitch" ||
      serviceName === "Twicas" 
    ) {
      url += "https://";
      url += this.serviceList[serviceName]
      url += '/';
      url += accountName;
      url;
    }

    // @付きURLサービス
    if (
      serviceName === "Youtube" ||
      serviceName === "Tiktok"
    ) {
      url += "https://";
      url += this.serviceList[serviceName]
      url += '/@';
      url += accountName;
      url;
    }

    // 独自URLサービス
    if (serviceName == "TiktokLive") {
      url += "https://";
      url += this.serviceList[serviceName]
      url += '/@';
      url += accountName;
      url += '/live';
      url;
    }


    result.textContent = url;
    return url;
  }

  copyUrl() {
    navigator.clipboard.writeText(this.resultAreaTarget.textContent)
      .then(() => {
        alert('URLをコピーしました。');
      })
      .catch(err => {
        alert('URLのコピーに失敗しました:');
      });
  }
}
