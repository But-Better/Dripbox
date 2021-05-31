export const MIN_LENGTH = 10;


/**
 * Change type "password" to "text"
 * @param checkbox = switch btn
 * @param password = password input
 */
export function showPassword(checkbox, password) {
    checkbox.onclick = () => {
        if (checkbox.checked) {
            password.type = "text";
        } else {
            password.type = "password";
        }
    }
}

/**
 * Has value a lowercase
 * @param value
 * @returns {boolean}
 */
export function lowercaseRegex(value) {
    const lowerCase = /[a-z]/g;
    return !!value.match(lowerCase);
}

/**
 * Has value a uppercase
 * @param value
 * @returns {boolean}
 */
export function uppercaseRegex(value) {
    const lowerCase = /[A-Z]/g;
    return !!value.match(lowerCase);
}

/**
 * Has value a number
 * @param value
 * @returns {boolean}
 */
export function numberRegex(value) {
    const numberCase = /[0-9]/g;
    return !!value.match(numberCase);
}

/**
 * Has value a special char
 * @param value
 * @returns {boolean}
 */
export function specialRegex(value) {
    const specialCharacter = /[!@#$%^&*)(+=.<>{}\[\]:;'"|~`_\-]/g;
    return !!value.match(specialCharacter);
}

/**
 * Is value a equal b
 * @param a
 * @param b
 * @returns {boolean} is a or b length == 0 return false | else check is a and b equal
 */
export function isEqual(a, b){
    if(a.length === 0 || b.length === 0 ){
        return false;
    }

    return a === b;
}

/**
 * Is length bigger than or equal MIN_LENGTH
 * @param value
 * @returns {boolean}
 */
export function isLengthCorrect(value){
    return value.length >= MIN_LENGTH;
}
