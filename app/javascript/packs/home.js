
const {showPassword} = require("./PasswordHandler");

function main() {
    const password = document.getElementById("floatingPassword");
    const showSwitch = document.getElementById("ShowSwitch");

    showPassword(showSwitch, password);
}

main();