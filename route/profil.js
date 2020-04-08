const express = require("express");
const { connection } = require("../config/db");
const { cloudinary } = require("../config/conf")
const router = express.Router();
const passport = require("passport");
const multer = require('multer');
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
    `SELECT users.id AS user_id, users.name AS user_name, users.avatar, pays.name AS pays_name, pays.code, periodes.month AS periode_month, assoc_pays_periodes_users.year
      FROM assoc_pays_periodes_users
    INNER JOIN pays on pays.id = assoc_pays_periodes_users.id_pays
    INNER JOIN users on users.id = assoc_pays_periodes_users.id_users
    INNER JOIN periodes on periodes.id = assoc_pays_periodes_users.id_periodes
    WHERE users.id=?
    ORDER BY assoc_pays_periodes_users.year DESC`, [idUser],
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in destination");
      }
      const trip = {
        user_id: results[0].user_id,
        name: results[0].user_name,
        avatar: results[0].avatar,
        countries: []
      };

      results.map((code) => {
        trip.countries.push({
          code: code.code,
          pays_name: code.pays_name,
          periode_month: code.periode_month,
          year: code.year
        })
      })

      console.log(trip);
      res.status(200).send(trip);
    }
  );
});


const storage = multer.diskStorage({
  destination: './tmp/',
  filename(req, file, cb) {
    cb(
      null,
      `${file.fieldname}-${Date.now()}${path.extname(file.originalname)}`
    );
  }
});

const upload = multer({
  storage,
  limits: { fileSize: 10000000 },
  fileFilter(req, file, cb) {
    checkFileType(file, cb);
  }
});

router.post('/:idUser/avatar', upload.single('avatar'), (req, res) => {
  const { idUser } = req.params;
  const file = req.file.path;
  cloudinary.uploader.upload(
    file,
    {
      folder: 'avatar/',
      public_id: `avatar-${idUser}`,
      tags: 'avatar'
    },
    (err, image) => {
      if (err) {
        console.log(err);
      }
      const avatarUrl = image.url;
      connection.query(
        'UPDATE users SET avatar = ? WHERE idUser = ?;', [avatarUrl, id],
        (errUpdate, resUpdate) => {
          if (errUpdate) {
            res.status(500).send('erreur lors de l\'ajout de la photo de profil');
          }
          res.status(200).send('ok');
        });
    }
  );
});

router.post('/:idUser/country', (req, res) => {
  const { idUser } = req.params;
  const country = req.body;
  connection.query(
    'INSERT INTO assoc_pays_periodes_users SET id_pays = ?, id_periodes = ?,  year = ?,  id_users = ?;', [country, idUser],
    (err, results) => {
      if (err) {
        res.status(500).send('erreur lors de l\'ajout du voyage');
      }
      res.status(200).send('ok');
    });
  );
});


module.exports = router;