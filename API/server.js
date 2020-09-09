const app = require('./app');

// start a server
const port = process.env.PORT || 8080;
app.listen(port, () => {
    console.log(`Listening on port ${port}`)
});