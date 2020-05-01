const { connection } = require("../config/db");
const axios = require('axios');
const accents = require('remove-accents');


function initDb() {
  return axios.get('https://restcountries.eu/rest/v2/all')
    .then((countries) => {
      connection.query(
        `SELECT coded from countries;`,

        (err, results) => {
          if (err) {
            console.log(`Error init db ${err}`);
          }
          results = JSON.parse(JSON.stringify(results)).map(result => result.code);
          return countries.data.map(country => {
            const name = accents.remove(country.name);
            const code = country.alpha3Code;
            const capital = accents.remove(country.capital);
            const region = accents.remove(country.region);
            const nameFr = country.translations.fr
            const flag = country.flag
            if (!results.includes(code)) {
              connection.query(
                `INSERT INTO countries(name, capitalCity, region, coded, nameFr, flag)
              Values(?);`, [[name, capital, region, code, nameFr, flag]]
              )
            }
          })
        })
    })
    .then(() => console.log("Init DB done")
    )


}
exports.initDb = initDb; 