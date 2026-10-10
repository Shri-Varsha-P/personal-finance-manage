function loadReport() {
    const source = localStorage.getItem("incomeSource");
    const amount = localStorage.getItem("incomeAmount");
    if (source === null || amount === null) {

        document.getElementById("incomeSourceCell").innerHTML = "No Data";
        document.getElementById("incomeAmountCell").innerHTML = "₹0";
        document.getElementById("remarksCell").innerHTML =
            "Please save income first.";

        return;
    }
    document.getElementById("incomeSourceCell").innerHTML = source;
    document.getElementById("incomeAmountCell").innerHTML = "₹" + amount;
    if (Number(amount) >= 50000) {

        document.getElementById("remarksCell").innerHTML =
            "Excellent Monthly Income";

    }
    else if (Number(amount) >= 20000) {

        document.getElementById("remarksCell").innerHTML =
            "Moderate Monthly Income";

    }
    else {

        document.getElementById("remarksCell").innerHTML =
            "Low Monthly Income";

    }
}
window.onload = loadReport;