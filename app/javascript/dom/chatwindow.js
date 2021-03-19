const chatWindowBottom = () => {

const chatWindow = document.getElementById('messages');

if(chatWindow) {
  // Keep chat window scrolled to the bottom at all times
  chatWindow.scrollTop = chatWindow.scrollHeight;
  };
}

export { chatWindowBottom };
