// *** Stimulus化 OK ***

// document.addEventListener("DOMContentLoaded", function() {
 
//   // URL貼付ボタンのクリックイベントをイベントデリゲーションで処理
//   $(document).on('click', '.links__paste-btn', function() {
//     console.log('paste');
//     // 最も近い .links__item を取得
//     const parentItem = $(this).closest('.links__item');
//     // 対応する input 要素を取得
//     const urlForm = parentItem.find('input[name$="[link_url]"]');    
//     navigator.clipboard.readText().then(function(text) {
//       urlForm.val(text);
//     }).catch(function(err) {
//       console.error('クリップボードの内容の取得に失敗しました:', err);
//     });
//   });

//   // リンク設定フォームのクリアボタンのクリックイベントをイベントデリゲーションで処理
//   $(document).on('click', '.links__clear-btn', function() {
//     // 最も近い .links__item を取得
//     const parentItem = $(this).closest('.links__item');
//     // 対応する input 要素を取得
//     const linkNameInput = parentItem.find('input[name$="[link_name]"]');
//     const linkUrlInput = parentItem.find('input[name$="[link_url]"]');

//     if (confirm('フォームの内容をリセットしますか？')) {
//       // 値をクリア
//       linkNameInput.val('');
//       linkUrlInput.val('');
//     }
//   });
// });
