document.addEventListener("DOMContentLoaded", function () {

    /*
     * Automatically remove dashboard/auth alerts
     * after a few seconds.
     */
    const alerts = document.querySelectorAll(
        ".alert, .dashboard-alert"
    );

    alerts.forEach(function (alert) {

        setTimeout(function () {

            alert.style.opacity = "0";

            alert.style.transition = "opacity 0.5s ease";

            setTimeout(function () {

                if (alert.parentNode) {
                    alert.parentNode.removeChild(alert);
                }

            }, 500);

        }, 5000);

    });


    /*
     * Add simple hover behavior to book cards.
     */
    const bookCards =
        document.querySelectorAll(".book-card");

    bookCards.forEach(function (card) {

        card.addEventListener("mouseenter", function () {
            card.style.transform = "translateY(-4px)";
            card.style.transition = "transform 0.2s ease";
        });

        card.addEventListener("mouseleave", function () {
            card.style.transform = "translateY(0)";
        });

    });

});


/*
 * Registration validation.
 */
function validateRegistration() {

    const fullName =
        document.getElementById("fullName");

    const email =
        document.getElementById("email");

    const password =
        document.getElementById("password");

    const confirmPassword =
        document.getElementById("confirmPassword");


    if (!fullName ||
        !email ||
        !password ||
        !confirmPassword) {

        return true;
    }


    if (fullName.value.trim().length < 2) {

        alert(
            "Please enter a valid full name."
        );

        fullName.focus();

        return false;
    }


    if (password.value.length < 6) {

        alert(
            "Password must contain at least 6 characters."
        );

        password.focus();

        return false;
    }


    if (password.value !== confirmPassword.value) {

        alert(
            "Passwords do not match."
        );

        confirmPassword.focus();

        return false;
    }


    return true;
}


/*
 * Confirm deleting a book.
 */
function confirmDeleteBook() {

    return confirm(
        "Are you sure you want to delete this book?"
    );
}


/*
 * Confirm returning a book.
 */
function confirmReturn() {

    return confirm(
        "Are you sure you want to return this book?"
    );
}