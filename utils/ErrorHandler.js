class ErrorHandler extends Error {
    constructor(message, httpStatusCode = 500) {
        // Pass remaining arguments (including vendor specific ones) to parent constructor
        super();

        // Maintains proper stack trace for where our error was thrown (only available on V8)
        if (Error.captureStackTrace) {
            Error.captureStackTrace(this, ErrorHandler );
        }

        this.message = message;
        this.httpStatusCode = httpStatusCode;
        this.date = new Date();
    }
}
module.exports = {ErrorHandler};
