'use strict';

import { request } from './network.js';


// get logged username
let session_username = null;
request('post', '../api/fetch_session.php', {}, true, function () {
    session_username = JSON.parse(this.response);
});

// get nodes div
const nodes = document.getElementById('nodes');
let node_id = 1;

// get edges div
const edges = document.getElementById('edges');


const urlParams = new URL(window.location).searchParams;
const conference_id = urlParams.get('id');

if (conference_id != null) {
    // get conference nodes
    request('post', '../api/fetch_conference_nodes.php', {conference_id: conference_id}, true, function (){
        let list_nodes = JSON.parse(this.response);

        for (let i = 0; i < list_nodes.length; i++) {
            draw_node_form(list_nodes[i]['conf_id'], list_nodes[i]['name'], list_nodes[i]['x'], list_nodes[i]['y']);
        }

        node_id = list_nodes.length + 1;
    });
    // get conference edges
    request('post', '../api/fetch_conference_edges.php', {conference_id: conference_id}, true, function (){
        let list_edges = JSON.parse(this.response);

        for (let i = 0; i < list_edges.length; i++) {
            draw_edge_form(list_edges[i]['origin'], list_edges[i]['destination']);
        }

    });
}

// ---------------============== NODES ====================-----------------------

const add_node = document.getElementById('add_node');
add_node.addEventListener('click', function () {
    draw_node_form(node_id++);
});

function draw_node_form(id, name_val, x_val, y_val) {
    let node = document.createElement('div');
    node.setAttribute('class', 'node');

    let header = document.createElement('div');
    header.setAttribute('class', 'form_entry');
    header.innerHTML = "<label>Id</label><input class=\"node_id\" type=\"text\" name=\"node_id[]\" value=\"" + id + "\" readonly>";

    let name = document.createElement('div');
    name.setAttribute('class', 'form_entry');
    name.innerHTML = "<label>Name</label><input type=\"text\" name=\"node_name[]\" value=\"" + name_val + "\" required>";

    let x = document.createElement('div');
    x.setAttribute('class', 'form_entry');
    x.innerHTML = "<label>X</label><input type=\"number\" name=\"node_x[]\" value=\"" + x_val + "\" required>";

    let y = document.createElement('div');
    y.setAttribute('class', 'form_entry');
    y.innerHTML = "<label>Y</label><input type=\"number\" name=\"node_y[]\" value=\"" + y_val + "\" required>";

    let remove = document.createElement('button');
    remove.setAttribute('class', 'remove_node');
    remove.setAttribute('type', 'button');
    remove.innerHTML = 'remove';

    node.appendChild(header);
    node.appendChild(name);
    node.appendChild(x);
    node.appendChild(y);
    node.appendChild(remove);
    nodes.insertBefore(node, document.getElementById('add_node'));
}



// ---------------============== EDGES ====================-----------------------

const add_edge = document.getElementById('add_edge');
add_edge.addEventListener('click', function () {
    draw_edge_form();
});

function draw_edge_form(origin_id, destination_id) {
    let edge = document.createElement('div');
    edge.setAttribute('class', 'edge');

    let origin = document.createElement('div');
    origin.setAttribute('class', 'form_entry');
    origin.innerHTML = "<label>Origin id</label><input type=\"number\" name=\"edge_origin[]\" value=\"" + origin_id + "\" required>";

    let destination = document.createElement('div');
    destination.setAttribute('class', 'form_entry');
    destination.innerHTML = "<label>Destination id</label><input type=\"number\" name=\"edge_destination[]\" value=\"" + destination_id + "\" required>";

    let remove = document.createElement('button');
    remove.setAttribute('class', 'remove_edge');
    remove.setAttribute('type', 'button');
    remove.innerHTML = 'remove';

    edge.appendChild(origin);
    edge.appendChild(destination);
    edge.appendChild(remove);
    edges.insertBefore(edge, document.getElementById('add_edge'));
}



// Add event listener to remove nodes and edges
document.addEventListener('click', function (event) {
    if (!event.target)
        return;

    let elem_class = event.target.getAttribute('class');
    if (elem_class == null)
        return;

    if (elem_class.includes('remove_node')) {
        event.target.parentElement.remove();
        update_nodes();
    }
    else if (elem_class.includes('remove_edge')) {
        event.target.parentElement.remove();
    }
});

function update_nodes() {
    node_id = 1;

    let node_ids = document.getElementsByClassName('node_id');
    for (let i = 0; i < node_ids.length; i++) {
        node_ids[i].value = node_id++;
    }
}