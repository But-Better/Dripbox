const {showPassword} = require("./PasswordHandler");

const password = document.getElementById("floatingPassword");

function animationOfImage() {
    const image = document.getElementById("mainImgId");
    const email = document.getElementById("floatingInput");

    const defaultSrc = image.src;

    email.addEventListener("focusin", () => {
        image.setAttribute("src", "https://c.tenor.com/pBrzvwLzbwoAAAAi/hacking-hack.gif");
    })

    document.addEventListener("focusout", () => {
        image.setAttribute("src", defaultSrc);
    })

    password.addEventListener("focusin", () => {
        image.setAttribute("src", "https://c.tenor.com/pBrzvwLzbwoAAAAi/hacking-hack.gif");
    });

}

function main() {
    const showSwitch = document.getElementById("ShowSwitch");

    animationOfImage();
    showPassword(showSwitch, password);
}


main();