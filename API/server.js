const app = require('./app');

// start a server
const port = process.env.PORT || 8080;
const apiVersion = process.env.VERSION || 'v1';
app.listen(port, () => {
    console.log(`API version: ${apiVersion}`);
    console.log(`Listening on port ${port}`)
});