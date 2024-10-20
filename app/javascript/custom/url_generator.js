// document.addEventListener("DOMContentLoaded", function() {
 
//   function initialized() {
  
//     // 要素の取得
//     const selectedService = $('#generator-url__select');
//     const generateBtn = $('#generator-url__btn');
//     const generateResult = $('#generator-result__url');
//     const accountName = $('.generator-url__account');
//     const urlCopyBtn = $('.generator-result__copy');


//     // セレクトボックスのサービス選択配列
//     const serviceList = {
//       default: "",
//       x: "x.com",
//       instagram: "instagram.com",
//       tiktok: "tiktok.com",
//       youtube: "youtube.com",
//       twicas: "twitcasting.tv",
//       note: "note.com",
//       line: "line.me/ti/p",
//       twitch: "twitch.tv",
//       // サービスを追加
//     }
    
//     // URL生成処理
//     function urlGenerate() {
//       const serviceName = selectedService.val();
//       let url = "";

//       // 選択されていない場合
//       if (serviceName == "default") {
//         return url;
//       }

//       if (serviceName == "tiktok" || serviceName == "youtube") {
//         url += "https://";
//         url += serviceList[serviceName]
//         url += '/@';
//         url += accountName.val();
//         return url;
//       }
      
//       if (serviceName == "tiktok_live") {
//         url += "https://";
//         url += serviceList[serviceName]
//         url += '/@';
//         url += accountName.val();
//         url += '/live';
//         return url;
//       }

//       if (serviceList[serviceName]) {
//         url += "https://";
//         url += serviceList[serviceName]
//         url += '/';
//         url += accountName.val();
//       }

//       return url;
//     }

//     // URL生成ボタンクリック
//     $(generateBtn).on('click', function(){
//       const url = urlGenerate();
//       generateResult.text(url);
//     });

    
//     $(accountName).on("keydown", function(event) {
//       // Enter = 13　が押された場合
//       if (event.key === "Enter") {
//         event.preventDefault();
//         const url = urlGenerate();
//         generateResult.text(url);
//       }
//     });

//     // URLコピーボタンクリック
//     $(urlCopyBtn).on('click', function(){
//       navigator.clipboard.writeText(generateResult.text())
//         .then(() => {
//           alert('URLをコピーしました。');
//         })
//         .catch(err => {
//           alert('URLのコピーに失敗しました:');
//         });
//     });
  
//     document.addEventListener('turbo:render', initialized);
//   }

//   initialized();

// });

