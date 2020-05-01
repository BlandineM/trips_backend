const express = require("express");
const { connection } = require("../config/db");
const router = express.Router();

function sqlNameByType(type) {
  if (type === "plage") {
    return "1";
  } else {
    return "2";
  }
}

function sqlAdvised(advised) {
  if (advised === "advised") {
    return "1";
  } if (advised === "wrong") {
    return "0";
  }
}

// Route of all destinations
router.get("/:type/countries", (req, res) => {
  const { type } = req.params;
  const sqlName = sqlNameByType(type);
  // Connection to the database and selection of information
  connection.query(
    `SELECT countries.id AS id_country, countries.name, countries.capitalCity, countries.region, countries.nameFr, countries.flag, countries.pictures
      FROM assoc_countries_periods_types
        INNER JOIN countries on countries.id=assoc_countries_periods_types.id_countries 
        INNER JOIN periods on periods.id=assoc_countries_periods_types.id_periods
      WHERE id_types=?
      GROUP BY countries.id;`, [sqlName],
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in destination");
      } res.json(results);
    }
  );
});
// Route of all destinations for the chosen month
router.get("/:type/period/:id/advised/:advised", (req, res) => {
  const { type } = req.params;
  const { id } = req.params;
  const { advised } = req.params;
  const sqlName = sqlNameByType(type);
  const sqlType = sqlAdvised(advised)
  // Connection to the database and selection of information
  connection.query(
    `SELECT  countries.id AS id_countries, countries.name, periods.id AS id_month, periods.month,countries.capitalCity, countries.region, countries.nameFr, countries.flag, countries.pictures
      FROM assoc_countries_periods_types
        INNER JOIN countries ON countries.id=assoc_countries_periods_types.id_countries 
        INNER JOIN periods on periods.id=assoc_countries_periods_types.id_periods
      WHERE id_types=? AND id_periods=? AND is_ok=?;`, [sqlName, id, sqlType]
    ,
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in destination beaches for the chosen month");
      } res.json(results);
    }
  );
});

// //route to create a new countriy and link it at the user
// router.post("/:type/:id/newtrip", (req, res) => {
//   const type = req.params.type;
//   const id = req.params.id;
//   const newtrip = req.body;
//   const sqlName = sqlNameByType(type);
//   console.log(newtrip);

//   connection.query(
//     `INSERT INTO destinations (countries, mois_conseille_${sqlName})
//     values (?, ?); 
//     ;`,
//     [newtrip, id],
//     (err, results) => {
//       if (err) {
//         // If an error has occurred, then the user is informed of the error
//         res.status(500).send("Invalid trip registration");
//       } res.status(200).json(results);
//     }
//   );
// });

module.exports = router;
