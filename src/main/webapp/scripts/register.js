function generateRegNumber() {

    const regNum = Math.floor(100000 + Math.random() * 900000);

    document.getElementById('regNumber').textContent = regNum;

    return regNum;

}

function saveCookies(name, email, password, regNumber) {

    // Cookie Storage

    document.cookie = `name=${encodeURIComponent(name)}; path=/; max-age=86400;`;

    document.cookie = `email=${encodeURIComponent(email)}; path=/; max-age=86400;`;

    document.cookie = `password=${encodeURIComponent(password)}; path=/; max-age=86400;`;

    document.cookie = `regNumber=${regNumber}; path=/; max-age=86400;`;

    localStorage.setItem('name', name);

    localStorage.setItem('email', email);

    localStorage.setItem('regNumber', regNumber);

}

function getCookie(name) {

    const cookies = document.cookie.split(';');

    for (let cookie of cookies) {

        const [cookieName, cookieValue] = cookie.trim().split('=');

        if (cookieName === name) {

            return decodeURIComponent(cookieValue);

        }

    }

    return localStorage.getItem(name);

}

function clearCookies() {

    document.cookie = "name=; path=/; max-age=0;";

    document.cookie = "email=; path=/; max-age=0;";

    document.cookie = "password=; path=/; max-age=0;";

    document.cookie = "regNumber=; path=/; max-age=0;";

    localStorage.removeItem('name');

    localStorage.removeItem('email');

    localStorage.removeItem('regNumber');

}

function displayStoredDetails() {

    const name = getCookie('name');

    const email = getCookie('email');

    const regNumber = getCookie('regNumber');

    const container = document.getElementById('detailsContent');

    const section = document.getElementById('storedDetails');

    if (name && email && regNumber) {

        container.innerHTML = `

            <p><strong>Name:</strong> ${name}</p>

            <p><strong>Email:</strong> ${email}</p>

            <p><strong>Registration Number:</strong> ${regNumber}</p>

        `;

        section.style.display = 'block';

    } else {

        section.style.display = 'none';

    }

}

window.onload = () => {

    displayStoredDetails();

    if (getCookie('name')) {

        document.getElementById('registerForm').style.display = 'none';

    }

};

document.getElementById('generateBtn').addEventListener('click', () => {

    generateRegNumber();

});

document.getElementById('registerForm').addEventListener('submit', function(e) {

    e.preventDefault();

    const name = document.getElementById('name').value.trim();

    const email = document.getElementById('email').value.trim();

    const password = document.getElementById('password').value;

    const confirmPassword = document.getElementById('confirmPassword').value;

    const regNumber = document.getElementById('regNumber').textContent;

    const existingName = getCookie('name');

    if (!/^[A-Za-z ]+$/.test(name)) {

        alert("Name should contain only letters and spaces.");

        return;

    }

    if (existingName) {

        alert(`Already registered as ${existingName}`);

        return;

    }

    if (name.length < 5 || email.length < 5 || password.length < 5) {

        alert('Please fill all fields with at least 5 characters.');

        return;

    }

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailPattern.test(email)) {

        alert("Please enter a valid email address.");

        return;

    }

    const strongPasswordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&_]).{5,}$/;

    if (!strongPasswordPattern.test(password)) {

        alert('Password must contain at least one letter, one number, and one special character (e.g., @, $, !, %, *, #, ?, &, _).');

        return;

    }

    if (password !== confirmPassword) {

        alert('Passwords do not match.');

        return;

    }

    if (regNumber === 'Not generated') {

        alert('Please generate a registration number.');

        return;

    }

    if (!confirm('Do you want to proceed with registration?')) {

        return;

    }

    const formData = new FormData();

    formData.append("name", name);

    formData.append("email", email);

    formData.append("password", password);

    formData.append("regNumber", regNumber);

    showMessage(
        "Validating registration using AJAX and PHP...",
        true
    );

    fetch(
        "http://localhost/finsmart/register.php",
        {
            method: "POST",
            body: formData
        }
    )

    .then(response => response.json())

    .then(data => {

        if (data.success) {

            showMessage(
                data.message,
                true
            );

            saveCookies(
                data.name,
                data.email,
                password,
                data.regNumber
            );

            alert('Registration successful!');

            displayStoredDetails();

            document.getElementById('registerForm').reset();

            document.getElementById('regNumber').textContent = 'Not generated';

            document.getElementById('registerForm').style.display = 'none';

        } else {

            showMessage(
                data.message,
                false
            );

        }

    })

    .catch(error => {

        console.error(error);

        showMessage(
            "Unable to connect to PHP server. Start Apache in XAMPP.",
            false
        );

    });

});

function showMessage(message, success) {

    const messageBox =
        document.getElementById("ajaxMessage");

    messageBox.textContent = message;

    messageBox.style.color =
        success ? "green" : "red";

    messageBox.style.fontWeight =
        "bold";

}

document.getElementById('clearDataBtn').addEventListener('click', () => {

    if (confirm('Are you sure you want to clear your registration data?')) {

        clearCookies();

        alert('Registration data cleared! Reloading page...');

        window.location.reload();

    }

});