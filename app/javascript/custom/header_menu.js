// *** Stimulus化 OK ***

// document.addEventListener("DOMContentLoaded", function() {

//   // ハンバーガーメニューの開閉
//   function initializeMenu() {
//     if (!$('#hamburger').data('initialized')) {
//       $('#hamburger').on('click', function() {
//         $('.menu').toggleClass('menu--open');
//         $('.hamburger__icon').toggleClass('hamburger__icon--close');
//         $(".header__mask").toggleClass('header__mask--cover');
//         $('#search-text').val('');
//       }).data('initialized', true);
//     }

//     if (!$('.header__mask').data('initialized')) {
//       $('.header__mask').on('click', function() {
//         $('.menu').removeClass('menu--open');
//         $('.hamburger__icon').removeClass('hamburger__icon--close');
//         $(".header__mask").removeClass('header__mask--cover');
//         $('#search-text').val('');
//       }).data('initialized', true);
//     }
//   }

//   document.addEventListener('turbo:load', initializeMenu);
//   document.addEventListener('turbo:render', initializeMenu);
// });