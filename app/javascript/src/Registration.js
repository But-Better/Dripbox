import {
    isEqual,
    isLengthCorrect,
    lowercaseRegex,
    numberRegex, showPassword,
    specialRegex,
    uppercaseRegex
} from "./PasswordHandler";

let password = document.getElementById("passwordId");
let passwordAgain = document.getElementById("passwordAgainId");

const plus = "M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z";
const minus = "M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM4.5 7.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7z";

const min_height = 1001;

function movePasswordRequirementHTML() {
    window.addEventListener("change", () => {
        const height = window.screen.height;
        const alert = document.getElementById("container-alert");
        if (height >= min_height) {
            alert.remove();
        }
    });
}

function validationHandler(id, value) {
    const svg = document.getElementById(id);

    if (value) {
        svg.style.fill = "#2ECC40";
        svg.setAttribute("d", plus);
    } else {
        svg.style.fill = "#FF4136";
        svg.setAttribute("d", minus);
    }
}

function passwordEquals() {
    let fun = () => {
        const btn = document.getElementById("regBtn")
        let result = isEqual(password.value, passwordAgain.value);
        if (result) {
            btn.removeAttribute("disabled");
        } else {
            btn.setAttribute("disabled", "true");
        }
    }

    passwordAgain.addEventListener("keyup", () => {
        fun();
    })

    password.addEventListener("keyup", () => {
        fun();
    })

}

function eventHandler(event) {
    if (event.type === 'keyup') {

    }
}

function events() {

    password.addEventListener("keyup", () => {
        validationHandler("lowercaseSVGPath", lowercaseRegex(password.value));
        validationHandler("uppercaseSVGPath", uppercaseRegex(password.value));
        validationHandler("numberSVGPath", numberRegex(password.value));
        validationHandler("specialCharSVGPath", specialRegex(password.value));
        validationHandler("lengthSVGPath", isLengthCorrect(password.value));
        validationHandler("equalSVGPath", isEqual(password.value, passwordAgain.value));
    });

    passwordAgain.addEventListener("keyup", () => {
        validationHandler("equalSVGPath", isEqual(password.value, passwordAgain.value));
    });
}

function init() {
    password = document.getElementById("passwordId");
    password.value = "";

    passwordAgain = document.getElementById("passwordAgainId");
    passwordAgain.value = "";
}

document.onreadystatechange = function () {
    if (document.readyState === "complete") {
        init();
        events();
        passwordEquals()
        showPassword(document.getElementById("Reg_ShowPassword"), password)
    }
}
