function calculateSavings() {
    const monthlyContribution = parseFloat(document.getElementById("save").value);
    const interestRate = parseFloat(document.getElementById("rate").value);
    if (monthlyContribution <= 0 || interestRate < 0) {
        alert("Please enter valid values.");
        return;
    }
    const months = 12;
    const monthlyRate = interestRate / 100 / 12;
    let futureBalance = 0;
    for (let i = 0; i < months; i++) {
        futureBalance = (futureBalance + monthlyContribution) * (1 + monthlyRate);
    }
    document.getElementById("result").innerHTML =
        "₹" + futureBalance.toFixed(2);
}
document.getElementById("calculateBtn").addEventListener("click", calculateSavings);