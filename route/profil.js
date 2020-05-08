const express = require("express");
const { connection } = require("../config/db");
const { cloudinary } = require("../config/conf")
const router = express.Router();
const passport = require("passport");
require("../passport-startegies");

router.use((req, res, next) => {
  passport.authenticate("jwt", { session: false }, (error, user) => {
    if (error) return res.status(500).send(error, info);
    if (!user) return res.status(401).send("Unauthorized");
    req.idUser = user.id
    next();
  })(req, res);
});

router.get('/:idUser', (req, res) => {
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

router.get("/:idUser/countries", (req, res) => {
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



router.post('/:idUser/avatar', (req, res) => {
  if (req.files === null) {
    return res.status(400).json({ msg: 'No file uploaded' });
  }
  const idUser = req.idUser;
  const file = req.files.file;

  file.mv(`${__dirname}/../tmp/${file.name}`
    , err => {
      if (err) {
        console.error(err);
        return res.status(500).send(err);
      }
      cloudinary.uploader.upload(
        `${__dirname}/../tmp/${file.name}`,
        {
          folder: 'avatar/',
          public_id: `avatar-${idUser}`,
          tags: 'avatar'
        },
        (err, image) => {
          if (err) {
            console.log(err);
            return res.status(500).send(err);
          }
          const avatarUrl = image.url.replace('http', 'https');
          connection.query(
            'UPDATE users SET avatar = ? WHERE id = ?;', [avatarUrl, idUser],
            (errUpdate) => {
              if (errUpdate) {
                return res.status(500).send('erreur lors de l\'ajout de la photo de profil');
              }
              return res.json({ fileName: file.name, filePath: `/tmp/${file.name}` });
            });
        }
      )
    });
});

router.post('/:idUser/country', (req, res) => {
  const idUser = req.idUser;
  const { country, period, year, check } = req.body;
  connection.query(
    'INSERT INTO trips SET id_countries=?, id_periods=?, year=?, check=?, id_users=?;', [country, period, year, check, idUser],
    (err, results) => {
      if (err) {
        return res.status(500).send(`erreur lors de l\'ajout du voyage ${err}`);
      }
      return res.status(200).send('ok');
    });
}
);


module.exports = router