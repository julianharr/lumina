// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
// CSS
import 'mapbox-gl/dist/mapbox-gl.css';
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

// For chatrooms
import { initChatroomCable } from '../channels/chatroom_channel';
import { initMapbox } from '../plugins/init_mapbox';


// *********************************************************************************************

// INFINITE SCROLLING 🚀
// NEED TO ADD TO NEW FILE

// Credit Mehdi Aoussiad
// https://js.plainenglish.io/building-an-infinite-scroll-with-vanilla-javascript-32810bae9a8c

// Selecting The Container
const container = document.querySelector('.container-infinite');

// The Scroll Event
window.addEventListener('scroll', () => {
  const {scrollHeight,scrollTop,clientHeight} = document.documentElement;
  if(scrollTop + clientHeight > scrollHeight - 5){
    setTimeout(createPost,2000);
  }
});
// The createPost function creates The HTML for the charity post
// Appends to the bottom of the container
function createPost(){
  const post = document.createElement('div');
  post.className = 'card-charity';
  post.innerHTML = `<img src="https://source.unsplash.com/random/600x400" alt=""><h1>Lorem ipsum dolor sit amet</h1>
  <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Doloremque eos, atque sed saepe
     tempore, sequi qui excepturi voluptate ut perspiciatis culpa sit harum, corrupti ullam
     voluptatibus obcaecati sint dignissimos quas.</p>`;
//   Appending the post to the container.
  container.appendChild(post);
}



// This is JAVASCRIPT for the INTERESTS SELECTOR
// image gallery
// // init the state from the input
// $(".image-checkbox").each(function () {
//   if ($(this).find('input[type="checkbox"]').first().attr("checked")) {
//     $(this).addClass('image-checkbox-checked');
//   }
//   else {
//     $(this).removeClass('image-checkbox-checked');
//   }
// });
function arrayRemove(arr, value) {

        return arr.filter(function(ele){
            return ele != value;
        });
    }

window.interests = []

const images = document.querySelectorAll(".image-checkbox")
if (images) {
  const nextPage = document.getElementById("next-page")
  // nextPage.href = nextPage.href + "?interests="
  images.forEach((image) => {
    image.addEventListener('click', () => {
      image.classList.toggle('image-checkbox-checked')
      if (image.classList.contains('image-checkbox-checked')) {
        window.interests.push(image.dataset.name)
        // nextPage.href = nextPage.href + window.interests
      }   else {
        window.interests = arrayRemove(window.interests, image.dataset.name)
      }
        nextPage.href = "/interests?interest=" + window.interests
    })
  })
}



// TURBO DOWN HERE !!!
document.addEventListener('turbolinks:load', () => {
  initMapbox();
  // createPost();
  initChatroomCable();
})

