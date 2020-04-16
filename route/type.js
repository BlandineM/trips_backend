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
router.get("/type/:type/countries", (req, res) => {
  const { type } = req.params;
  const sqlName = sqlNameByType(type);
  // Connection to the database and selection of information
  connection.query(
    `SELECT pays.id AS id_pays, pays.name, pays.capital, pays.region, pays.nameFr, pays.flag, pays.pictures
      FROM assoc_pays_periodes_types
        INNER JOIN pays on pays.id=assoc_pays_periodes_types.id_pays 
        INNER JOIN periodes on periodes.id=assoc_pays_periodes_types.id_periodes
      WHERE id_type=?
      GROUP BY pays.id;`, [sqlName],
    (err, results) => {
      if (err) {
        // If an error has occurred, then the user is informed of the error
        res.status(500).send("Error in destination");
      } res.json(results);
    }
  );
});
// Route of all destinations for the chosen month
router.get("/type/:type/periode/:id/advised/:advised", (req, res) => {
  const { type } = req.params;
  const { id } = req.params;
  const { advised } = req.params;
  const sqlName = sqlNameByType(type);
  const sqlType = sqlAdvised(advised)
  // Connection to the database and selection of information
  connection.query(
    `SELECT  pays.id AS id_pays, pays.name, periodes.id AS id_month, periodes.month,pays.capital, pays.region, pays.nameFr, pays.flag, pays.pictures
      FROM assoc_pays_periodes_types
        INNER JOIN pays ON pays.id=assoc_pays_periodes_types.id_pays 
        INNER JOIN periodes on periodes.id=assoc_pays_periodes_types.id_periodes
      WHERE id_type=? AND id_periodes=? AND is_ok=?;`, [sqlName, id, sqlType]
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
// router.post("/type/:type/:id/newtrip", (req, res) => {
//   const type = req.params.type;
//   const id = req.params.id;
//   const newtrip = req.body;
//   const sqlName = sqlNameByType(type);
//   console.log(newtrip);

//   connection.query(
//     `INSERT INTO destinations (pays, mois_conseille_${sqlName})
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

router.get("/countries", (req, res) => {
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

// Route who saw
router.get("/countries/tripper", (req, res) => {

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

module.exports = router;
