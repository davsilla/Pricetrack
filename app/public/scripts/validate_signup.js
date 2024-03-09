function validate_password(event) {
	let password = document.getElementById("userPassword").value;
	let password_confirm = document.getElementById("userPasswordConfirm").value;

	if (password === password_confirm) {
		return true;
	}

	alert("Passwords do not match.");
	event.preventDefault();
	return false;
}

let form = document.getElementById("signupForm");
form.addEventListener("submit", validate_password, false);
