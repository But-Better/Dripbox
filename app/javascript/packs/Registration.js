const password = document.getElementById("passwordId");
const passwordAgain = document.getElementById("passwordAgainId");

const alert = document.getElementById("Reg_Red_Alert")

function checkPasswordAreEqual(){
    passwordAgain.onkeyup =()=>{
        if(!(password.value === passwordAgain.value)){
            alert.style.display = "block";
            alert.innerText = "Password isn't equal";
        }else {
            alert.style.display = "None";
        }
    }
}


function main(){
 checkPasswordAreEqual();
}

main();