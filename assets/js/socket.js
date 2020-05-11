import { Socket } from "phoenix"
import moment from './moment';

let socket = new Socket("/socket");


let lobbyChannel = socket.channel("room:lobby");

function updateTime(time) {
    document.getElementById('last-updated').innerHTML = `<b>Last updated:</b> ${moment.utc(time).fromNow()}`;
}

const connectToTheLobby = () => {

    socket.connect();

    console.log('connecting to the socket ....');

    lobbyChannel.join()
        .receive("ok", resp => {
            console.log('connected to the socket!');
            resp.rooms.forEach(room => {
                updateTheRoomStats(room);
            });
            const last_updated = getLatestUpdatedDate(resp.rooms);
            updateTime(last_updated);
        })
        .receive("error", resp => {
            //TODO: put an alert on UI
            console.error("Unable to join", resp)
        })

    lobbyChannel.on("update", function(data) {
        updateTheRoomStats(data.room)
    });

    lobbyChannel.on("inc", function(data) {
        updateTheRoomStats(data);
    });
    lobbyChannel.on("dec", function(data) {
        updateTheRoomStats(data);
    });

    function updateTheRoomStats(room) {
        room.percentage = Math.round(room.count / room.capacity * 100);

        room.css_class = "green";
        if (room.percentage > 60 & room.percentage <= 80) {
            room.css_class = "orange";
        } else {
            room.css_class = "red";
        }

        document.getElementById(`room_${room.id}_count`).innerText = room.count;
        document.getElementById(`room_${room.id}_percentage`).innerText = `${room.percentage}%`;
        document.getElementById(`bar_${room.id}`).className = `progress-bar ${room.css_class}`;
        document.getElementById(`bar_${room.id}`).style.width = `${room.percentage}%`;
    }

    function getLatestUpdatedDate(rooms) {
        return rooms.reduce((m, v, i) => (v.last_updated > m.last_updated) && i ? v : m).last_updated;
    }

}

document.addEventListener("DOMContentLoaded", function() {
    moment.locale(window.navigator.userLanguage || window.navigator.language);
});

const disconnect = () => {
    console.log('disconnecting from the socket!');
    socket.disconnect();
}

const changeRoomPopulation = (action, roomId) => {
    lobbyChannel.push(action, { room_id: roomId })
}

window.changeRoomPopulation = changeRoomPopulation;
window.connectToTheLobby = connectToTheLobby;
window.disconnect = disconnect