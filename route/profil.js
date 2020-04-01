const express = require("express");
const { connection } = require("../config/db");
const router = express.Router();
const passport = require("passport");
require("../passport-startegies");

router.use((req, res, next) => {
  passport.authenticate("jwt", { session: false }, (error, user) => {
    if (error) return res.status(500).send(error, info);
    if (!user) return res.status(401).send("Unauthorized");
    next();
  })(req, res);
});

router.get("/:idUser", (req, res) => {
  const { idUser } = req.params;
  // Connection to the database and selection of information
  connection.query(
    `SELECT users.id, users.name, users.avatar
      FROM users
    WHERE users.id=?`, [idUser],
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in destination");
      }

      res.json(results);
    }
  );
});
module.exports = router;