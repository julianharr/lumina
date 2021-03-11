// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

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

// For chatrooms
import { initChatroomCable } from "../channels/chatroom_channel";
import { initMapbox } from "../plugins/init_mapbox";

// *********************************************************************************************


// Donate Button Animation

const tipButtons = document.querySelectorAll('.tip-button')

// Loop through all buttons (allows for multiple buttons on page)
tipButtons.forEach((button) => {
  let coin = button.querySelector('.coin')

  // The larger the number, the slower the animation
  coin.maxMoveLoopCount = 90

  button.addEventListener('click', () => {
    if (button.clicked) return

    button.classList.add('clicked')

    // Wait to start flipping the coin because of the button tilt animation
    setTimeout(() => {
      // Randomize the flipping speeds just for fun
      coin.sideRotationCount = Math.floor(Math.random() * 5) * 90
      coin.maxFlipAngle = (Math.floor(Math.random() * 4) + 3) * Math.PI
      button.clicked = true
      flipCoin()
    }, 50)
  })

  const flipCoin = () => {
    coin.moveLoopCount = 0
    flipCoinLoop()
  }

  const resetCoin = () => {
    coin.style.setProperty('--coin-x-multiplier', 0)
    coin.style.setProperty('--coin-scale-multiplier', 0)
    coin.style.setProperty('--coin-rotation-multiplier', 0)
    coin.style.setProperty('--shine-opacity-multiplier', 0.4)
    coin.style.setProperty('--shine-bg-multiplier', '50%')
    coin.style.setProperty('opacity', 1)
    // Delay to give the reset animation some time before you can click again
    setTimeout(() => {
      button.clicked = false
    }, 300)
  }

  const flipCoinLoop = () => {
    coin.moveLoopCount++
    let percentageCompleted = coin.moveLoopCount / coin.maxMoveLoopCount
    coin.angle = -coin.maxFlipAngle * Math.pow((percentageCompleted - 1), 2) + coin.maxFlipAngle

    // Calculate the scale and position of the coin moving through the air
    coin.style.setProperty('--coin-y-multiplier', -11 * Math.pow(percentageCompleted * 2 - 1, 4) + 11)
    coin.style.setProperty('--coin-x-multiplier', percentageCompleted)
    coin.style.setProperty('--coin-scale-multiplier', percentageCompleted * 0.6)
    coin.style.setProperty('--coin-rotation-multiplier', percentageCompleted * coin.sideRotationCount)

    // Calculate the scale and position values for the different coin faces
    // The math uses sin/cos wave functions to similate the circular motion of 3D spin
    coin.style.setProperty('--front-scale-multiplier', Math.max(Math.cos(coin.angle), 0))
    coin.style.setProperty('--front-y-multiplier', Math.sin(coin.angle))

    coin.style.setProperty('--middle-scale-multiplier', Math.abs(Math.cos(coin.angle), 0))
    coin.style.setProperty('--middle-y-multiplier', Math.cos((coin.angle + Math.PI / 2) % Math.PI))

    coin.style.setProperty('--back-scale-multiplier', Math.max(Math.cos(coin.angle - Math.PI), 0))
    coin.style.setProperty('--back-y-multiplier', Math.sin(coin.angle - Math.PI))

    coin.style.setProperty('--shine-opacity-multiplier', 4 * Math.sin((coin.angle + Math.PI / 2) % Math.PI) - 3.2)
    coin.style.setProperty('--shine-bg-multiplier', -40 * (Math.cos((coin.angle + Math.PI / 2) % Math.PI) - 0.5) + '%')

    // Repeat animation loop
    if (coin.moveLoopCount < coin.maxMoveLoopCount) {
      if (coin.moveLoopCount === coin.maxMoveLoopCount - 6) button.classList.add('shrink-landing')
      window.requestAnimationFrame(flipCoinLoop)
    } else {
      button.classList.add('coin-landed')
      coin.style.setProperty('opacity', 0)
      setTimeout(() => {
        button.classList.remove('clicked', 'shrink-landing', 'coin-landed')
        setTimeout(() => {
          resetCoin()
        }, 300)
      }, 1500)
    }
  }
});




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

