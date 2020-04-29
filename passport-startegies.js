const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
const { Strategy: JWTStrategy, ExtractJwt } = require("passport-jwt");
const bcrypt = require("bcrypt");
const { jwtSecret } = require("./config/conf");
const { connection } = require("./config/db")

passport.use(
  new LocalStrategy(
    {
      usernameField: "login",
      passwordField: "password"
    },
    (login, password, done) => {
      connection.query(
        `SELECT id, name, avatar, login, password 
      FROM users
      WHERE login=?
      LIMIT 1`,
        login,
        (err, rows) => {
          if (err) return done(err, false, "Error while fetching user!");

          if (!rows[0]) return done(null, false, "User not found!");

          const { id, login } = rows[0];
          const user = { id, login };
          const isPasswordOK = bcrypt.compareSync(password, rows[0].password);

          if (!isPasswordOK) return done(null, false, "Wrong password!");

          return done(null, user);
        }
      );
    }
  )
);

passport.use(
  new JWTStrategy(
    {
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: jwtSecret
    },
    (jwtPayload, done) => {
      const user = jwtPayload;
      // find the user in db if needed. This functionality may be omitted if you store everything you'll need in JWT payload.
      return done(null, user);
    }
  )
);