const userService = require("../services/user");

exports.createUser = async function (req, res) {
    try {
        const user = await userService.createUser(req.body);
        res.status(200).json(user);
    } catch (e) {
        res.status(500).send({
            message: e.message || "failed create user"
        });
    }
};

exports.getAllUsers = async function (req, res) {
    try {
        const usersList = await userService.getAllusers();
        res.status(200).json(usersList);
    } catch (e) {
        res.status(500).send({
            message: e.message || "failed load users"
        });
    }
};





