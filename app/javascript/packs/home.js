//Check valid input from Password
const password = document.getElementById("floatingPassword");
const errorSmallLetters = "No small letters found";
const errorBigLetters = "No big Letters found";
const errorNoNumber = "No number found";
const errorNoSpecialChar = "No special characters found";
const errorMinLength = "Too small password"
const minlength = 10;

function callEvents() {
    password.addEventListener('focusin', (event) => {
        const value = scanInput(password.value);
        console.log(value);
        console.log(password.value)
    })
    password.addEventListener('focusout', (event) => {
        const value = scanInput(password.value);
        console.log(value);
        console.log(password.value);
    })
}

function scanInput(param) {

    if(param.length < minlength){
        return errorMinLength;
    }

    if (!param.match("^(?=.*[a-z])")) {
        return errorSmallLetters;
    }

    if (!param.match("(?=.*[A-Z])(?=.*\d)")) {
        return errorBigLetters;
    }

    if (!param.match("(?=.*[@$!%*?&])")) {
        return errorNoSpecialChar;
    }

    if (!param.match("^(?=.*[0-9]+)")) {
        return errorNoNumber;
    }

    return true;
}

callEvents();