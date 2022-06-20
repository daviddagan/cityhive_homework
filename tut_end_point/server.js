const express = require("express");
// const cors = require("cors");
const helmet = require("helmet");
const createError = require("http-errors");
const dotenv = require('dotenv');
dotenv.config();


const app = express();
app.use(helmet());
app.use(express.json());

require("./startup/routes")(app);

app.use((req, res, next) => {
    next(createError.NotFound());
});

const port = process.env.PORT || 5000;

app.listen(port, () => {
    console.log(`Server started on port ${port}`);
});


