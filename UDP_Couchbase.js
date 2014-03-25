var dgram = require('dgram');
var couchbase = require('couchbase');

var PORT = 33333;
var HOST = '192.168.1.148';
var count = 1;
var key = '';

var db = new couchbase.Connection({host: 'localhost:8091', bucket: 'acquire-demo'});

var server = dgram.createSocket('udp4');

server.on('listening', function() {
    var address = server.address();
    console.log('UDP Server listening on ' + address.address + ":" + address.port);
});

server.on('message', function(message, remote) {
    key = 'id_' + count++;

    db.set(key, message + '', function(err, result) {
        console.log(message + '');
    });
});

server.bind(PORT, HOST);