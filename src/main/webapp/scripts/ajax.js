document.getElementById("phpBtn")
    .addEventListener("click", function () {

        fetch("http://localhost/finsmart/ajax-data.php")

            .then(response => response.json())

            .then(data => {

                document.getElementById("phpResult")
                    .innerHTML =
                    "Application: " + data.application +
                    "<br>Source: " + data.source +
                    "<br>Message: " + data.message +
                    "<br>Status: " + data.status;

            })

            .catch(error => {

                document.getElementById("phpResult")
                    .textContent =
                    "Unable to connect to PHP server.";

            });

    });


document.getElementById("xmlBtn")
    .addEventListener("click", function () {

        fetch("expenses.xml")

            .then(response => response.text())

            .then(xmlText => {

                const parser = new DOMParser();

                const xml =
                    parser.parseFromString(
                        xmlText,
                        "text/xml"
                    );

                const expenses =
                    xml.getElementsByTagName("expense");

                let html =
                    "<table border='1' cellpadding='8'>";

                html +=
                    "<tr>" +
                    "<th>Date</th>" +
                    "<th>Item</th>" +
                    "<th>Category</th>" +
                    "<th>Amount</th>" +
                    "</tr>";


                for (let i = 0;
                     i < expenses.length;
                     i++) {

                    const date =
                        expenses[i]
                        .getElementsByTagName("date")[0]
                        .textContent;

                    const item =
                        expenses[i]
                        .getElementsByTagName("item")[0]
                        .textContent;

                    const category =
                        expenses[i]
                        .getElementsByTagName("category")[0]
                        .textContent;

                    const amount =
                        expenses[i]
                        .getElementsByTagName("amount")[0]
                        .textContent;


                    html +=
                        "<tr>" +
                        "<td>" + date + "</td>" +
                        "<td>" + item + "</td>" +
                        "<td>" + category + "</td>" +
                        "<td>" + amount + "</td>" +
                        "</tr>";
                }

                html += "</table>";

                document.getElementById("xmlResult")
                    .innerHTML = html;

            })

            .catch(error => {

                document.getElementById("xmlResult")
                    .textContent =
                    "Unable to read expenses.xml.";

            });

    });


document.getElementById("servletBtn")
    .addEventListener("click", function () {

        fetch("ajaxData")

            .then(response => response.text())

            .then(data => {

                document.getElementById("servletResult")
                    .innerHTML =
                    data.replace(/\n/g, "<br>");

            })

            .catch(error => {

                document.getElementById("servletResult")
                    .textContent =
                    "Unable to connect to Servlet.";

            });

    });