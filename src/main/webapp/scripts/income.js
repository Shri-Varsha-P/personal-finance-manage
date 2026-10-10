function saveIncome() {
    const source = document.getElementById("source").value.trim();
    const amount = document.getElementById("amount").value;
    if (source === "") {
        alert("Please enter an income source.");
        return;
    }
    if (amount === "" || Number(amount) <= 0) {
        alert("Please enter a valid income amount.");
        return;
    }
    localStorage.setItem("incomeSource", source);
    localStorage.setItem("incomeAmount", amount);
    alert("Income saved successfully!");
    document.getElementById("source").value = "";
    document.getElementById("amount").value = "";
}
document.getElementById("saveIncomeBtn").addEventListener("click", saveIncome);