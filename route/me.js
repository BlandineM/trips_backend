const express = require("express");
const router = express.Router();
const passport = require("passport");
const moment = require("moment");
const { cloudinary } = require("../config/conf")
const { connection } = require("../config/db");
require("../passport-startegies");

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
    `SELECT countries.flag, countries.pictures, countries.name AS country_name, countries.code, periods.month AS month, trips.id, trips.year, trips.check
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

function isCountryCheck(month, year) {
    return moment().set({'year': year, 'month': month}).isSameOrBefore(moment());
};

router.post('/trip', (req, res) => {
  const idUser = req.idUser;
  const { country, month, year, description } = req.body;
  const check = isCountryCheck(month, year);
  return connection.promise().query(
    `INSERT INTO trips 
    SET trips.id_countries = ?, trips.id_periods = ?, trips.year = ?, trips.check = ?, trips.id_users = ?, trips.description = ?;`,
    [country, month, year, check, idUser, description])
    .then(result => {
      return Promise.resolve(JSON.parse(JSON.stringify(result))[0].insertId)
    })
    .then(tripId => {
      const file = req.files.file;
      if (req.files === null) {
        return res.status(400).json({ msg: 'No file uploaded' });
      }
      file.mv(`${__dirname}/../tmp/${file.name}`
        , err => {
          if (err) {
            console.error(err, "err1");
            return res.status(500).send(err);
          }
          cloudinary.uploader.upload(
            `${__dirname}/../tmp/${file.name}`,
            {
              folder: 'trips/',
              public_id: `${tripId}`,
              tags: 'trips'
            },
            (err, image) => {
              if (err) {
                console.log(err, "err2");
                return res.status(500).send(err);
              }
              const tripUrl = image.url;
              connection.query(
                `UPDATE trips SET trips.picture = ? WHERE id = ?;`,
                [tripUrl, tripId],
                (err, results) => {
                  console.log(results);
                  if (err) {
                    return res.status(500).send(`erreur lors de l\'ajout du voyage ${err}`);
                  }
                  return res.status(200).send('ok');
                });
            }
          )
        });
    });
  });

router.delete('/trip/:id', (req, res) => {
  const { id } = req.params;
  connection.query(
    `DELETE From trips 
    WHERE trips.id = ?;`,
    [id],
    (err, results) => {

      if (err) {
        return res.status(500).send(`erreur lors de la suppresion du voyage ${err}`);
      }
      return res.status(200).send('ok');
    });
}
);

router.put('/trip/:id', (req, res) => {
  const idUser = req.idUser;
  const { id } = req.params
  const { country, month, year } = req.body;
  const check = isCountryCheck(month, year);
  connection.query(
    `UPDATE trips 
    SET trips.id_countries = ?, trips.id_periods = ?, trips.year = ?, trips.check = ?, trips.id_users = ?
    Where trips.id = ? ;`,
    [country, month, year, check, idUser, id],
    (err, results) => {

      if (err) {
        return res.status(500).send(`erreur lors de la modification du voyage ${err}`);
      }
      return res.status(200).send('ok');
    });
}
);

module.exports = router