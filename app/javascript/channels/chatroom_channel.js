import consumer from "./consumer";

const initChatroomCable = () => {
  // Check if the element is there, if it is, do the rest
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      // Called when there is new info that arrives on the chatroom channel
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initChatroomCable };
