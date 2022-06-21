const messages = require("../routes/messageRoute");

module.exports = function (app) {
    app.use("/api/messages", messages);
};