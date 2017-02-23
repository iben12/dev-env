var echo = require('laravel-echo-server');

var options = {
  authHost: 'http://myapp.dev',
  authPath: '/broadcasting/auth',
  host: 'http://echo-server.dev',
  port: 6001,
  socketPath: '/broadcasting/socket',
  databaseConfig: {
      redis: {
        host: 'redis',
        port: '6379'
      }
  }
};

echo.run(options);