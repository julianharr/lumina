const chatroom = document.querySelectorAll(".conversation");

for (let i = 0; i < chatroom.length; i++) {
  chatroom[i].addEventListener("click", function() {
    let current = document.getElementsByClassName("active");

    // If there's no active class
    if (current.length > 0) {
      current[0].className = current[0].className.replace(" active", "");
    }

    // Add the active class to the current/clicked button
    this.className += " active";
  });
}
