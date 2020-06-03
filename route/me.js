const express = require("express");
const router = express.Router();
const passport = require("passport");
const { connection } = require("../config/db");

router.use((req, res, next) => {
  passport.authenticate("jwt", { session: false }, (error, user) => {
    if (error) return res.status(500).send(error, info);
    if (!user) return res.status(401).send("Unauthorized");
    req.idUser = user.id
    next();
  })(req, res);
});


router.get('/profil', (req, res) => {
  const idUser = req.idUser;
  connection.query(
    `SELECT users.id AS user_id, users.name AS user_name, users.avatar 
    FROM users
    WHERE id=?;`, [idUser],
    (err, results) => {
      if (err) {
        res.status(500).send(`erreur lors de la récuppération de l'user ${err}`);
      }
      res.json(results);
    });
}
);


router.get("/profil/countries", (req, res) => {
  const idUser = req.idUser;
  // Connection to the database and selection of information
  connection.query(
    `SELECT countries.flag, countries.pictures, countries.name AS country_name, countries.code, periods.month AS month, trips.year, trips.check
      FROM trips
    INNER JOIN countries on countries.id = trips.id_countries
    INNER JOIN users on users.id = trips.id_users
    LEFT JOIN periods on periods.id = trips.id_periods
    WHERE users.id=?
    ORDER BY trips.year DESC`, [idUser],
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in destination");
      }
      res.status(200).send(results);
    }
  );
});

router.post('/trip', (req, res) => {
  const idUser = req.idUser;
  const { country, month, year, check } = req.body;
  connection.query(
    `INSERT INTO trips 
    SET trips.id_countries = ?, trips.id_periods = ?, trips.year = ?, trips.check = ?, trips.id_users = ?;`,
    [country, month, year, check, idUser],
    (err, results) => {

      if (err) {
        return res.status(500).send(`erreur lors de l\'ajout du voyage ${err}`);
      }
      return res.status(200).send('ok');
    });
}
);

router.delete('/trip', (req, res) => {
  const idUser = req.idUser;
  const { country, month, year, check } = req.body;
  connection.query(
    `DELETE From trips 
    WHERE trips.id_countries = ?, trips.id_periods = ?, trips.year = ?, trips.check = ?, trips.id_users = ?;`,
    [country, month, year, check, idUser],
    (err, results) => {

      if (err) {
        return res.status(500).send(`erreur lors de l\'ajout du voyage ${err}`);
      }
      return res.status(200).send('ok');
    });
}
);

router.put('/trip', (req, res) => {
  const idUser = req.idUser;
  const { country, month, year, check } = req.body;
  connection.query(
    `UPDATE trips 
    SET trips.id_countries = ?, trips.id_periods = ?, trips.year = ?, trips.check = ?, trips.id_users = ?;`,
    [country, month, year, check, idUser],
    (err, results) => {

      if (err) {
        return res.status(500).send(`erreur lors de l\'ajout du voyage ${err}`);
      }
      return res.status(200).send('ok');
    });
}
);

module.exports = router