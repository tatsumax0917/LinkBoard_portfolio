// *** Stimulus化 OK ***

// document.addEventListener("turbo:load", function() {
//   function initialized() {
//     const editButton = document.getElementById('id_edit_btn');
//     const id = document.getElementById('user_unique_user_id');
    
//     if (editButton && id) {
//       if (!$(editButton).data('initialized')) {
//         $(editButton).on('click', function() {
//           id.disabled = !id.disabled;
//           if (id.disabled) {
//             editButton.textContent = 'IDを編集';
//           } else {
//             editButton.textContent = 'IDロック'
//           }
//         }).data('initialized', true);
//       }
//     }
//     document.addEventListener('turbo:load', initialized);
//     document.addEventListener('turbo:render', initialized);
//   }

//   initialized();
// });
