const express = require("express");
const fileUpload = require('express-fileupload');
const app = express();
const port = 5000;
const cors = require("cors");
const bodyParser = require("body-parser");
const initScript = require("./initScript/initdb")
const passport = require("passport");

/* ------------------------------------------------------------ Tools */
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());
app.use(passport.initialize());
app.use(fileUpload());

/* -------------------------------------------------------------- Public Routes */

app.use("/type", require("./route/type"));
app.use("/auth", require("./route/auth"));
app.use("/profil", require("./route/profil"));
app.use("/me", require("./route/me"));
app.use("/countries", require("./route/countries"));
app.use("/suggestion", require("./route/suggestion"));


initScript.initDb()
  .then(() => {
    app.listen(port, err => {
      if (err) {
        throw new Error("Something bad happened...");
      }
      console.log(`Server is listening on ${port}`);
    });

  }
  )
