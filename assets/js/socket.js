import {Socket} from "phoenix"
import moment from './moment.min';

let socket = new Socket("/socket", {params: {}})

socket.connect()

const createSocket = () => {

console.log("Calledd createSocket")

  let channel = socket.channel("lobby:Kitchen", {})
  channel.join()
    .receive("ok", resp => { 
        console.log("Joined successfully", resp)
        updateCounter(resp);
    })
    .receive("error", resp => { 
      //TODO: put an alert on UI
      console.error("Unable to join", resp)
    })

  channel.on("enter", function(data) {
    console.log("entered", data)
    updateCounter(data);
  });
  channel.on("left", function(data) {
    console.log("left", data)
    updateCounter(data);
  });
  
  document.getElementById("btn-enter").addEventListener('click', () => {
    channel.push("enter");
  });

  document.getElementById("btn-left").addEventListener('click', () => {
    channel.push("left");
  });

  function updateCounter(data) {
    const counter = document.getElementById("counter");
    const count = data.count;
    counter.innerText = count;
    if (count <= 3) {
      counter.className = "green";
    } else if (count > 3 && count < 6) {
      counter.className = "yellow";
    } else {
      counter.className = "red";
    }
    document.getElementById("last-updated").innerText = moment.utc(data.last_updated).fromNow();
  }

}

document.addEventListener("DOMContentLoaded", function() {
  moment.locale(window.navigator.userLanguage || window.navigator.language);
  window.createSocket();
});

window.createSocket = createSocket;
