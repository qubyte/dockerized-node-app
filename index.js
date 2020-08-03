'use strict';

const { createServer } = require('http');

const server = createServer((req, res) => {
  res.writeHead(200).end('Hello, world!');
});

// eslint-disable-next-line no-console
server.listen(8000, () => console.log('Listening on port 8000.'));
