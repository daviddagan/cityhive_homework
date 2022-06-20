const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const phoneNumber = process.env.TWILIO_PHONE_NUMBER;
const client = require('twilio')(accountSid, authToken);


const createUser = (message) => {
    console.log("message", message)
    return client.messages
        .create({
            body: message,
            from: phoneNumber,
            to: '+15558675310'
        });


};


const getAllusers = async () => {
    return await client.messages.list();
};


module.exports = {
    createUser,
    getAllusers,
};
