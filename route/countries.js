const express = require("express");
const { connection } = require("../config/db");
const router = express.Router();

router.get("/", (req, res) => {
  // Connection to the database and selection of information
  connection.query(
    `SELECT pays.id AS id_pays, pays.name,  pays.nameFr, pays.flag
      FROM pays;`,
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in destination");
      } res.status(200).json(results);
    }
  );
});

// route to get all trippers by countries
router.get("/tripper", (req, res) => {

  // Connection to the database and selection of information
  connection.query(
    `SELECT pays.id AS id_pays, pays.name, count(*) as numOfVisited, pays.nameFr, pays.flag, pays.pictures
      FROM assoc_pays_periodes_users
        INNER JOIN pays on pays.id=assoc_pays_periodes_users.id_pays 
        INNER JOIN periodes on periodes.id=assoc_pays_periodes_users.id_periodes
      GROUP BY pays.id;`,
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in route for see the tripper");
      }
      res.json(results);
    }
  );
});

// route to get all trippers by countries for month
router.get("/tripper/periode/:id", (req, res) => {
  const { id } = req.params;
  // Connection to the database and selection of information
  connection.query(
    `SELECT pays.id AS id_pays, pays.name, count(*) as numOfVisited, pays.nameFr, pays.flag, pays.pictures
      FROM assoc_pays_periodes_users
        INNER JOIN pays on pays.id=assoc_pays_periodes_users.id_pays 
        INNER JOIN periodes on periodes.id=assoc_pays_periodes_users.id_periodes
      WHERE id_periodes=?
      GROUP BY pays.id;`, [id],
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in route for see the tripper");
      }
      res.json(results);
    }
  );
});

module.exports = router;