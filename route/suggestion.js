const express = require("express");
const { connection } = require("../config/db");
const router = express.Router();

router.get("/:idUser", (req, res) => {
  const { idUser } = req.params;
  // Connection to the database and selection of information
  connection.promise().query(
    `SELECT trips.id_countries, trips.id_periods, assoc_countries_periods.temperature,assoc_countries_periods.precipitation
      FROM trips 
    INNER JOIN assoc_countries_periods on assoc_countries_periods.id_countries = trips.id_countries and assoc_countries_periods.id_periods = trips.id_periods
    WHERE trips.id_users=? AND trips.check = 1;`, [idUser])
    .then(([results]) => {
      let temperaturePromise = [];
      const countriesCheck = JSON.parse(JSON.stringify(results));
      countriesCheck.forEach((country) => {
        temperaturePromise.push(connection.promise().query(
          `SELECT assoc_countries_periods.id_countries, assoc_countries_periods.id_periods, assoc_countries_periods.temperature, assoc_countries_periods.precipitation, countries.nameFr
            FROM voyage_2.assoc_countries_periods 
          INNER JOIN countries on countries.id=assoc_countries_periods.id_countries
          WHERE temperature between (?- 0.12) and (? + 0.12) and precipitation between(?-0.12) and (?+0.12);`, [country.temperature, country.temperature, country.precipitation, country.precipitation]))
      })
      return Promise.all(temperaturePromise)
    })
    .then(resultsCountriesSuggest => {
      let arrayResultsCountriesSuggest = []
      resultsCountriesSuggest.forEach(([i]) => {
        const resultsCountrySuggest = JSON.parse(JSON.stringify(i))
        arrayResultsCountriesSuggest.push(...resultsCountrySuggest)
      })
      function removeDuplicates(array, key) {
        return array.reduce((accumulator, element) => {
          if (!accumulator.find(el => el[key] === element[key])) {
            accumulator.push(element);
          }
          return accumulator;
        }, []);
      }
      res.status(200).json(removeDuplicates(arrayResultsCountriesSuggest, 'id_countries', 'id_periods'))
    }
    )
    .catch(err => res.status(500).send(`Error in suggestion ${err}`))

})


module.exports = router