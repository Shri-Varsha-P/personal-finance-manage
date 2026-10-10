const limitInput = document.getElementById("limit");
const budgetStatus = document.getElementById("budgetStatus");
function updateBudget() {
    const limit = parseFloat(limitInput.value);
    if (isNaN(limit) || limit < 0) {
        budgetStatus.innerHTML = "Please enter a valid amount.";
        budgetStatus.style.color = "red";
        return;
    }
    if (limit < 5000) {

        budgetStatus.innerHTML =
            "Budget Status: Low Budget (₹" + limit.toFixed(2) + ")";
        budgetStatus.style.color = "red";

    }
    else if (limit <= 20000) {

        budgetStatus.innerHTML =
            "Budget Status: Moderate Budget (₹" + limit.toFixed(2) + ")";
        budgetStatus.style.color = "orange";

    }
    else {

        budgetStatus.innerHTML =
            "Budget Status: Excellent Budget (₹" + limit.toFixed(2) + ")";
        budgetStatus.style.color = "lightgreen";

    }

}
limitInput.addEventListener("input", updateBudget);
updateBudget();