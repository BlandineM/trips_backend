require("dotenv").config();
const cloudinary = require('cloudinary').v2;

const jwtSecret = process.env.JWT_SECRET || "jwt_please_change";
const saltRounds = parseInt(process.env.SALT_ROUNDS) || "20"; // nombre de hachage du mot de passe

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_NAME || 'toto',
  api_key: process.env.CLOUDINARY_API_KEY || 'totoApiKey',
  api_secret: process.env.CLOUDINARY_API_SECRET || 'totoApiKeySecret'
});

module.exports = { cloudinary, jwtSecret, saltRounds };
