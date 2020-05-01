const express = require("express");
const { connection } = require("../config/db");
const router = express.Router();

router.get("/", (req, res) => {
  // Connection to the database and selection of information
  connection.query(
    `SELECT countries.id AS id_countries, countries.name,  countries.nameFr, countries.flag
      FROM countries;`,
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
    `SELECT countries.id AS id_countries, countries.name, count(*) as numOfVisited, countries.nameFr, countries.flag, countries.pictures
      FROM assoc_countries_periods_users
        INNER JOIN countries on countries.id=assoc_countries_periods_users.id_countries 
        INNER JOIN periods on periods.id=assoc_countries_periods_users.id_periods
      GROUP BY countries.id;`,
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
    `SELECT countries.id AS id_countries, countries.name, count(*) as numOfVisited, countries.nameFr, countries.flag, countries.pictures
      FROM assoc_countries_periods_users
        INNER JOIN countries on countries.id=assoc_countries_periods_users.id_countries 
        INNER JOIN periods on periods.id=assoc_countries_periods_users.id_periods
      WHERE id_periods=?
      GROUP BY countries.id;`, [id],
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