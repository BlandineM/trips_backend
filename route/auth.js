const express = require("express");
const passport = require("passport");
const jwt = require("jsonwebtoken");
require("../passport-startegies");
const { jwtSecret } = require("../config/conf");
const { connection } = require("../config/db");
const router = express.Router();
const { UserService } = require("../services/user");
const UserModel = require("../models/user");

router.post("/signup", (req, res) => {
  const userDTO = req.body;
  const userService = new UserService(UserModel);
  return userService.signup(userDTO)
      .then(result => res.status(201).json(result))
      .catch((err => res.status(err.httpStatusCode).send(err.message)));
});

router.post("/login", (req, res) => {
  passport.authenticate(
    "local",
    { session: false },
    (errAuth, user, infoAuth) => {
      if (errAuth)
        return res.status(500).json({
          tldr: "Tech error!",
          details: errAuth,
          message: infoAuth
        });
      if (!user)
        return res.status(401).json({
          tldr: "Form error!",
          details: "Either mail or password is incorrect",
          message: infoAuth
        });
      connection.query(
        `SELECT id, name, login, avatar
         FROM users
         WHERE id=?`,
        [user.id],
        (err, results) => {
          if (err) {
            // Si une erreur est survenue, alors on informe l'utilisateur de l'erreur
            res.status(500).send("Error in info of user");
          } else {
            // Si tout s'est bien passé, on envoie le résultat de la requête SQL en tant que JSON.
            const token = jwt.sign(user, jwtSecret);
            user = results[0];
            return res.status(200).json({ user, token });
          }
        }
      );
    }
  )(req, res);
});

module.exports = router;