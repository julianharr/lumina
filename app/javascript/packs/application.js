// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "dom/donate";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
// CSS

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

// For Chatrooms
import { initChatroomCable } from "../channels/chatroom_channel";
import { initMapbox } from "../plugins/init_mapbox";

// *********************************************************************************************


// FOR THE INTERESTS SELECTION TO ARRAY
window.interests = [];

const images = document.querySelectorAll(".image-checkbox");
if (images) {
  const nextPage = document.getElementById("next-page");
  // nextPage.href = nextPage.href + "?interests="
  images.forEach((image) => {
    image.addEventListener("click", () => {
      image.classList.toggle("image-checkbox-checked");
      if (image.classList.contains("image-checkbox-checked")) {
        window.interests.push(image.dataset.name);
        // nextPage.href = nextPage.href + window.interests
      } else {
        window.interests = arrayRemove(window.interests, image.dataset.name);
      }
      nextPage.href = "/interests?interest=" + window.interests;
    });
  });
}

// TURBO DOWN HERE !!!
document.addEventListener("turbolinks:load", () => {
  initMapbox();
  // createPost();
  initChatroomCable();
});




// const feedCards = document.querySelector('.feed_cards');
// // The Scroll Event.
// window.addEventListener('scroll',()=>{
//   const {scrollHeight,scrollTop,clientHeight} = document.documentElement;
//   if(scrollTop + clientHeight > scrollHeight - 5){
//     setTimeout(createDiv,2000);
//   }
// });

// // The createPost function creates The HTML for the blog post.
// // It append it to the container.

const feedCards = document.querySelector('.feed_cards');
// The Scroll Event.
window.addEventListener('scroll',()=>{
  const {scrollHeight,scrollTop,clientHeight} = document.documentElement;
  if(scrollTop + clientHeight > scrollHeight - 5){
    setTimeout(createDiv,2000);
  }
});

// The createPost function creates The HTML for the blog post.
// It append it to the container.

// function createDiv(){
//   const post = document.createElement('div');
//   post.className = 'text';
//   post.innerHTML = <%= render "components/feed_page/feed_randomising" %>
// //   Appending the post to the container.
//   feedCards.appendChild(post);
// }

