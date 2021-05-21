//Check valid input from Password
import {MIN_LENGTH} from "./PasswordHandler";

const {showPassword} = require("./PasswordHandler");
const {validation} = require("./PasswordHandler");

function main() {
    const password = document.getElementById("floatingPassword");
    const message = document.getElementById("message");

    const letter = document.getElementById("letter");
    const capital = document.getElementById("capital");
    const number = document.getElementById("number");
    const specialChar = document.getElementById("specialChar");
    const length = document.getElementById("length");

    const showSwitch = document.getElementById("ShowSwitch");

    validation(password, message, letter, capital, number, specialChar, length, MIN_LENGTH)
    showPassword(showSwitch, password);
}

main();