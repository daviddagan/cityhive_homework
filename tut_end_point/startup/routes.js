const users = require("../routes/usersRoute");

module.exports = function (app) {
    app.use("/api/messages", users);
};