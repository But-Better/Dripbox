//Check valid input from Password
const password = document.getElementById("floatingPassword");
const message = document.getElementById("message");

const letter = document.getElementById("letter");
const capital = document.getElementById("capital");
const number = document.getElementById("number");
const specialChar = document.getElementById("specialChar");
const length = document.getElementById("length");
const minLength = 10;

//https://www.w3schools.com/howto/howto_js_password_validation.asp
function validation() {
    //Show validation property
    password.onfocus = () => {
        message.style.display = "block";
    }

    //make validation invisible
    password.onblur = () => {
        message.style.display = "none";
    }

    //check input
    password.onkeyup = () => {
        const lowerCase = /[a-z]/g;
        const upperCase = /[A-Z]/g;
        const numberCase = /[0-9]/g;
        const specialCharacter = /[!@#$%^&*)(+=.<>{}\[\]:;'"|~`_\-]/g;

        //LowerCase
        if (password.value.match(lowerCase)) {
            letter.style.display = "none";
        } else {
            letter.style.display = "block";
        }

        //upperCase
        if(password.value.match(upperCase)){
            capital.style.display = "none";
        }else {
            capital.style.display = "block";
        }

        //number
        if(password.value.match(numberCase)){
            number.style.display = "none";
        }else {
            number.style.display = "block";
        }

        //specialCharacter
        if(password.value.match(specialCharacter)){
            specialChar.style.display = "none";
        }else {
            specialChar.style.display = "block";
        }

        if(password.value.length >= minLength){
            length.style.display = "none";
        }else {
            length.style.display = "block";
        }
    }
}

function showPassword(){
    const checkbox = document.getElementById("ShowSwitch");

    checkbox.onclick = ()=>{
        if(checkbox.checked){
            password.type = "text";
        }else {
            password.type = "password";
        }
    }
}

function main() {
    validation();
    showPassword();
}

main();