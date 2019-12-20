'use strict';


export function request(method, url, data, async, listener) {
    let request = new XMLHttpRequest();
    request.onload = listener;

    if (method === 'post') {
        request.open(method, url, async);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.send(encodeForAjax(data));
    }
    else if (method === 'get') {
        request.open(method, url + '?' + encodeForAjax(data), async);
        request.send();
    }
}


function encodeForAjax(data) {
    return Object.keys(data).map(function (k) {
        // replace instances of certain characters by escape sequences 
        // representing the utf-8 encoding of the character
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k]);
        // the join method creates and returns a new string by concatenating
        // all of the elements in an array separated bt commas or the specified 
        // separator string, in this case '&'
    }).join('&');
}
