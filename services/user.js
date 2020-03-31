const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const { ErrorHandler } = require("../utils/ErrorHandler");
const { jwtSecret, saltRounds } = require("../config/conf");

class UserService {
    constructor(UserModel){
        this.UserModel = UserModel;
    }

    signup(user){
        return this.UserModel.getUserByLogin(user.login)
            .then(existUser => {
                if(existUser){
                    return Promise.reject(new ErrorHandler("Email already used", 409));
                }else {
                    const hash = bcrypt.hashSync(user.password, saltRounds);
                    user.password = hash;
                    return this.UserModel.createUser(user);
                }
            })
            .then(createdUserId => {
                const returnData = {
                    id: createdUserId,
                    login: user.login
                }
                const token = jwt.sign(returnData, jwtSecret);
                return Promise.resolve({ ...returnData, token });
            })
            .catch((err => {
                if(err instanceof ErrorHandler) {
                    return Promise.reject(err);
                } else {
                    return Promise.reject(new ErrorHandler("Error during account creation", 500));
                }
            }));
    }
}
module.exports = {UserService};