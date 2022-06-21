const messageService = require("../services/message");

exports.createMessage = async function (req, res) {
    try {
        const message = await messageService.createMessage(req.body);
        res.status(200).json(message);
    } catch (e) {
        res.status(500).send({
            message: e.message || "failed create message"
        });
    }
};

exports.getAllMessages = async function (req, res) {
    try {
        const messagesList = await messageService.getAllmessages();
        res.status(200).json(messagesList);
    } catch (e) {
        res.status(500).send({
            message: e.message || "failed load messages"
        });
    }
};





