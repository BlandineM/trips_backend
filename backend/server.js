const { connection } = require("./conf");
const express = require("express");
const app = express();
const port = 5000;
const cors = require("cors");
const bodyParser = require("body-parser");

/* ------------------------------------------------------------ Tools */

app.use(bodyParser.json());
app.use(cors());

/* -------------------------------------------------------------- Public Routes */

app.use("/", require("./route/type"));

app.listen(port, err => {
  if (err) {
    throw new Error("Something bad happened...");
  }

  console.log(`Server is listening on ${port}`);
});
