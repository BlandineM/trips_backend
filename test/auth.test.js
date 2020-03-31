const { describe }  = require("mocha");
const  sinon   = require("sinon");
const { expect } = require('chai');
const { UserService } = require("../services/user");

describe('User service', () => {
    const userModel = {
        getUserByLogin: () => {},
        createUser: () => {},
    };

    const userService = new UserService(userModel);
    describe('signup', () => {
        afterEach(() => {
            // Restore the default sandbox here
            sinon.restore();
        });

        it('When user signup with new email, should be ok', () => {
            //Arrange
            const signupUser = {login:"monLogin", password:"monPassword"}
            const DBStubGet = sinon.stub(userModel, "getUserByLogin")
                .returns(Promise.resolve(null));
            const DBStubCreate = sinon.stub(userModel, "createUser")
                .returns(Promise.resolve(1));

            //Act
            return userService.signup(signupUser)
                .then(signupData => {
                    //Assert
                    expect(signupData).to.have.property('id');
                    expect(signupData).to.have.property('login');
                    expect(signupData).to.have.property('token');
                    expect(signupData.id).to.equal(1);
                    expect(signupData.login).to.equal("monLogin");
                 })
        });
        it('When user signup with already exist email, should be return 409', () => {
            //Arrange
            const signupUser = {login:"monLogin", password:"monPassword"}
            const DBStubGet = sinon.stub(userModel, "getUserByLogin")
                .returns(Promise.resolve({login:"monLogin"}));

            //Act
            return userService.signup(signupUser)
                .catch(signupDataError => {
                    //Assert
                    expect(signupDataError).to.have.property('message');
                    expect(signupDataError).to.have.property('httpStatusCode');
                    expect(signupDataError.message).to.equal("Email already used");
                    expect(signupDataError.httpStatusCode).to.equal(409);
                })
                .then(signupData => {
                    expect(signupData).to.be.undefined
                })
        });
    });
});
