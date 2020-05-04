const { connection } = require("../config/db");
const axios = require('axios');
const accents = require('remove-accents');


function initDb() {
  return axios.get('https://restcountries.eu/rest/v2/all')
    .then((countries) => {
      connection.query(
        `SELECT code from countries;`,
        (err, results) => {
          if (err) {
            console.log(`Error init db ${err}`);
          }
          results = JSON.parse(JSON.stringify(results)).map(result => result.code);
          countries.data.map(country => {
            const name = accents.remove(country.name);
            const code = country.alpha3Code;
            const capital = accents.remove(country.capital);
            const region = accents.remove(country.region);
            const nameFr = country.translations.fr
            const flag = country.flag

            if (!results.includes(code)) {
              connection.query(
                `INSERT INTO countries(name, capitalCity, region, code, nameFr, flag)
              Values(?);`, [[name, capital, region, code, nameFr, flag]]
              )
            }
          })
        })
    })
    .then(() => {
      connection.query(
        `SELECT id_countries
        FROM assoc_countries_periods
        GROUP BY id_countries`,
        (err, results) => {
          if (err) {
            console.log(`Error init db ${err}`);
          }
          countriesTemp = JSON.parse(JSON.stringify(results))
          countriesTemp = countriesTemp.map(country => {
            return country.id_countries
          })
          connection.query(
            `SELECT id, code FROM countries;`,
            (err, results) => {
              if (err) {
                console.log(`Error init db ${err}`);
              }
              countries = JSON.parse(JSON.stringify(results));
              countries.map((country) => {
                if (!countriesTemp.includes(country.id)) {

                  const promiseTemperature = axios.get(`http://climatedataapi.worldbank.org/climateweb/rest/v1/country/mavg/cccma_cgcm3_1/b1/tas/2020/2039/${country.code}`);
                  const promisePrecipitation = axios.get(`http://climatedataapi.worldbank.org/climateweb/rest/v1/country/mavg/cccma_cgcm3_1/b1/pr/2020/2039/${country.code}`);
                  Promise.all([promiseTemperature, promisePrecipitation])
                    .then(([temperatures, précipitations]) => {
                      resultatTemperatures = temperatures.data[0].monthVals
                      resultatPrecipitations = précipitations.data[0].monthVals

                      if (resultatTemperatures && resultatPrecipitations) {
                        resultatTemperatures.map((temperature, i) => {
                          let tempDecimal = parseFloat(temperature).toFixed(2)
                          connection.query(
                            `INSERT INTO assoc_countries_periods (id_countries, id_periods, temperature) 
                          VALUES (?);`, [[country.id, (i + 1), tempDecimal]]
                          )
                        })
                        resultatPrecipitations.map((precipitation, i) => {
                          let precDecimal = parseFloat(precipitation).toFixed(2)
                          connection.query(
                            `UPDATE assoc_countries_periods 
                            SET precipitation = ? 
                          WHERE id_countries = ? and id_periods = ?;`, [precDecimal, country.id, (i + 1)]
                          )
                        })
                      }
                    })
                }
              })
            })
        })
    })
    .then(() => console.log("Init DB done"))


}

exports.initDb = initDb; 