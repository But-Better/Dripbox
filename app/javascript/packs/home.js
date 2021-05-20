require("PasswordHandler");

//Check valid input from Password
const password = document.getElementById("floatingPassword");
const message = document.getElementById("message");

const letter = document.getElementById("letter");
const capital = document.getElementById("capital");
const number = document.getElementById("number");
const specialChar = document.getElementById("specialChar");
const length = document.getElementById("length");
const minLength = 10;
const showSwitch = document.getElementById("ShowSwitch");

function main() {
    validation(password, message, letter, capital, number, specialChar, length, minLength)
    showPassword(showSwitch);
}

main();