import {Socket} from "phoenix"
import moment from './moment.min';

let socket = new Socket("/socket", {params: {}})

socket.connect()

const connectToTheRoom = (room_id) => {

  let channel = socket.channel("lobby:" + room_id, {})
  channel.join()
    .receive("ok", resp => { 
        updateCounters(resp.room);
    })
    .receive("error", resp => { 
      //TODO: put an alert on UI
      console.error("Unable to join", resp)
    })

  channel.on("enter", function(data) {
    updateCounters(data.room);
  });
  channel.on("left", function(data) {
    updateCounters(data.room);
  });
  
  document.getElementById("btn-inc").addEventListener('click', () => {
    channel.push("enter");
  });

  document.getElementById("btn-dec").addEventListener('click', () => {
    channel.push("left");
  });

  function updateCounters(room) {
    const counter = document.getElementById("counter");
    counter.innerText = `${room.count}/${room.limit}`;
    counter.className = room.css_class;
    document.getElementById("last-updated").innerText = moment.utc(room.last_updated).fromNow();
    document.getElementById("percentage").innerText = `${room.percentage}%`;
    document.getElementById("percentage-circle").className = `c100 p${room.percentage} ${room.css_class}`;
  }
}

document.addEventListener("DOMContentLoaded", function() {
  moment.locale(window.navigator.userLanguage || window.navigator.language);
});

window.connectToTheRoom = connectToTheRoom;
