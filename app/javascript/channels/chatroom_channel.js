import consumer from "./consumer";
import chatWindowBottom from "../dom/chatwindow";

const initChatroomCable = () => {

  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      // Called when there is new info that arrives on the chatroom channel
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data);
        messagesContainer.scrollTop = messagesContainer.scrollHeight; // keep window at scrolled down on each message send
      },
    });
  };
}

export { initChatroomCable };
