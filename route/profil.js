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
    `SELECT users.id, users.name, users.avatar, pays.name, periodes.month, assoc_pays_periodes_users.year
      FROM assoc_pays_periodes_users
    INNER JOIN pays on pays.id = assoc_pays_periodes_users.id_pays
    INNER JOIN users on users.id = assoc_pays_periodes_users.id_users
    INNER JOIN periodes on periodes.id = assoc_pays_periodes_users.id_periodes
    WHERE users.id=?`, [idUser],
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in destination");
      }
      const string = JSON.stringify(results);
      const user = JSON.parse(string);
      res.status(200).send(user);
    }
  );
});


module.exports = router;