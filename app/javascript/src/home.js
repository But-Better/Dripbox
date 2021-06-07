const {showPassword} = require("./PasswordHandler");


let gif = "/assets/home_page/hacking-hack.gif";
let password = document.getElementById("floatingPassword");

function animationOfImage() {
  const image = document.getElementById("mainImgId");
  const email = document.getElementById("floatingInput");

  const defaultSrc = image.src;

  email.addEventListener("focusin", () => {
    image.setAttribute("src", gif);
  })

  document.addEventListener("focusout", () => {
    image.setAttribute("src", defaultSrc);
  })

  password.addEventListener("focusin", () => {
    image.setAttribute("src", "https://c.tenor.com/pBrzvwLzbwoAAAAi/hacking-hack.gif");
  });

}

function moveImage() {
  const id = document.getElementById("mainImgId");
  const x = 0;
  document.addEventListener("mousemove", (e) => {
    id.setAttribute("transform", "translate3d(" + e.clientX + "," + e.clientY + "," + 0 + ")");
    id.style.position = 'absolute';
    id.style.left = e.clientX + "px";
    id.style.top = e.clientY + "px";
  });
}

function init() {
  password = document.getElementById("floatingPassword");
  password.value = "";
}

window.addEventListener("load", () => {
  init();
  const showSwitch = document.getElementById("ShowSwitch");
  animationOfImage();
  showPassword(showSwitch, password);
})
