import { Socket } from "phoenix"
import moment from './moment';

let socket = new Socket("/socket");


let lobbyChannel = socket.channel("room:lobby");

function updateTime(room) {
    document.getElementById('last-updated').innerHTML = `<b>Last updated room</b></br>${room.group}'s ${room.name}, ${moment.utc(room.updated_at).fromNow()}`;
}

const connectToTheLobby = () => {

    socket.connect();

    console.log('connecting to the socket ....');

    lobbyChannel.join()
        .receive("ok", resp => {
            console.log('connected to the socket!');
            const last_updated_room = getLatestUpdatedRoom(resp.rooms);
            resp.rooms.forEach(room => {
                updateTheRoomStats(room, room.id === last_updated_room.id);
            });
            updateTime(last_updated_room);
        })
        .receive("error", resp => {
            //TODO: put an alert on UI
            console.error("Unable to join", resp)
        })

    lobbyChannel.on("update", function(data) {
        updateTheRoomStats(data.room, true)
    });

    lobbyChannel.on("inc", function(data) {
        updateTheRoomStats(data, true);
    });
    lobbyChannel.on("dec", function(data, ) {
        updateTheRoomStats(data, true);
    });

    function updateTheRoomStats(room, last) {
        room.percentage = Math.round(room.count / room.capacity * 100);

        if (room.percentage <= 60) {
            room.css_class = "green";
        } else if (room.percentage > 60 && room.percentage <= 80) {
            room.css_class = "orange";
        } else {
            room.css_class = "red";
        }

        document.getElementById(`room_${room.id}_count`).innerText = `Occupied ${room.count} of ${room.capacity}`;
        let timeElement = document.getElementById(`room_${room.id}_last_updated`);
        const time = `${moment.utc(room.updated_at).fromNow()}`;
        timeElement.innerHTML = `Updated: `;
        if (last) {
            // remove other rooms's class
            const timeElements = document.getElementsByClassName("last-updated");
            for (var i = 0; i < timeElements.length; i++) {
                timeElements[i].classList.remove('last-updated');
            }
            timeElement.innerHTML += `<span class="last-updated">${time}</span>`;
        } else {
            timeElement.innerHTML += `${time}`;
        }

        document.getElementById(`room_${room.id}_percentage`).innerText = `${room.percentage}%`;
        document.getElementById(`bar_${room.id}`).className = `progress-bar ${room.css_class}`;
        document.getElementById(`bar_${room.id}`).style.width = `${room.percentage}%`;
        updateTime(room);
    }

    function getLatestUpdatedRoom(rooms) {
        return rooms.reduce((m, v, i) => (v.last_updated > m.last_updated) && i ? v : m);
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