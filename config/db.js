require("dotenv").config();
const mysql = require("mysql2");

const connection = mysql.createConnection({
  host: process.env.HOST || "totost", // adresse du serveur
  user: process.env.DBUSER || "toto", // le nom d'utilisateur
  password: process.env.PASSWORD || "t0t0", // le mot de passe
  database: process.env.DATABASE || "toto-DB" // le nom de la base de données
});
module.exports = { connection };
