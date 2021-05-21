import {MIN_LENGTH} from "./PasswordHandler";

const {validation} = require("./PasswordHandler");

const password = document.getElementById("passwordId");
const passwordAgain = document.getElementById("passwordAgainId");

const alert = document.getElementById("Reg_Red_Alert")
const btn = document.getElementById("regBtn");

function checkPasswordAreEqual() {

    passwordAgain.onkeyup = () => {
        if (!(password.value === passwordAgain.value)) {
            alert.style.display = "block";
            alert.innerText = "Password isn't equal";
            btn.disabled = true;
        } else {
            alert.style.display = "None";
            btn.disabled = false;
        }
    }
}


function main() {
    const message = document.getElementById("message");

    const letter = document.getElementById("Reg_Red_Alert_Letter");
    const capital = document.getElementById("Reg_Red_Alert_capital");
    const number = document.getElementById("Reg_Red_Alert_number");
    const specialChar = document.getElementById("Reg_Red_Alert_specialChar");
    const length = document.getElementById("Reg_Red_Alert_length");

    //const showSwitch = document.getElementById("ShowSwitch");

    validation(password, message, letter, capital, number, specialChar, length, MIN_LENGTH)
    checkPasswordAreEqual();
}

main();