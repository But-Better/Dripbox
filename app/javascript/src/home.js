const {showPassword} = require("./PasswordHandler");


let password = document.getElementById("floatingPassword");

function animationOfImage() {
  const image = document.getElementById("mainImgId");
  const email = document.getElementById("floatingInput");

  const defaultSrc = image.src;
  const gif = document.getElementById("hiddenGif");

  email.addEventListener("focusin", () => {
    image.setAttribute("src", gif.src);
  })

  document.addEventListener("focusout", () => {
    image.setAttribute("src", defaultSrc);
  })

  password.addEventListener("focusin", () => {
    image.setAttribute("src", gif.src);
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

window.addEventListener("DOMContentLoaded", () => {
  init();
  const showSwitch = document.getElementById("ShowSwitch");
  animationOfImage();
  showPassword(showSwitch, password);
})
