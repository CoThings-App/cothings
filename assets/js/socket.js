import { Socket } from "phoenix"
import moment from './moment';

let socket = new Socket("/socket");

const connectToTheRoom = (room_id) => {

    socket.connect({
        token: window.userToken,
    });

    console.log('connecting to the socket ....');

    let channel = socket.channel("lobby:" + room_id, {})
    channel.join()
        .receive("ok", resp => {
            console.log('connected to the socket!');
            updateCounters(resp.room);
        })
        .receive("error", resp => {
            //TODO: put an alert on UI
            console.error("Unable to join", resp)
        })

    channel.on("inc", function(data) {
        updateCounters(data.room);
    });
    channel.on("dec", function(data) {
        updateCounters(data.room);
    });

    document.getElementById("btn-inc").addEventListener('click', () => {
        channel.push("inc");
    });

    document.getElementById("btn-dec").addEventListener('click', () => {
        channel.push("dec");
    });

    function updateCounters(room) {
        const counter = document.getElementById("counter");
        counter.innerText = `${room.count}/${room.limit}`;
        counter.className = room.css_class;
        document.getElementById("percentage").innerText = `${room.percentage}%`;
        document.getElementById("percentage-circle").className = `c100 p${room.percentage} ${room.css_class}`;
        updateTime(room.last_updated)
    }
}

function updateTime(time) {
    document.getElementById('last-updated').innerHTML = `<b>Last updated:</b> ${moment.utc(time).fromNow()}`;
}

const connectToTheLobby = () => {

    socket.connect({
        token: window.userToken
    });

    console.log('connecting to the socket ....');

    let channel = socket.channel("lobby:*", {})
    channel.join()
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

    channel.on("update", function(data) {
        console.log("update", data);
        updateTheRoomStats(data.room)
    });

    function updateTheRoomStats(room) {
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

window.connectToTheRoom = connectToTheRoom;
window.connectToTheLobby = connectToTheLobby;
window.disconnect = disconnect