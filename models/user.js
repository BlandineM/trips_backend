const { connection } = require("../config/db");

function getUserByLogin(login){
    return connection.promise().query(`SELECT id, name, avatar, login FROM users WHERE login = ? LIMIT 1`, [login])
        .then( ([rows]) => {
            if(rows.length > 0){
                return Promise.resolve(JSON.parse(JSON.stringify(rows))[0]);
            }
            return Promise.resolve(null);
        })
        .catch((err => Promise.reject(err)));
}

function createUser(user){
    return connection.promise().query(`INSERT INTO users SET ? `, [user])
        .then(result => {
            return Promise.resolve(JSON.parse(JSON.stringify(result))[0].insertId);
        })
        .catch((err => Promise.reject(err)));
}


module.exports = {getUserByLogin, createUser};
