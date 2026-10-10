<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.xml.transform.*" %>
<%@ page import="javax.xml.transform.stream.*" %>
<%@ page import="javax.xml.transform.dom.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="javax.xml.xpath.*" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
    <title>XML Finance Manager</title>
    <style>
        body { background-color: #FFF5F7; font-family: 'Segoe UI', Arial, sans-serif; margin: 0; padding: 20px; }
        .dashboard { display: flex; gap: 20px; max-width: 1200px; margin: 0 auto; }
        .panel { background: #FFFFFF; padding: 20px; border-radius: 12px; box-shadow: 0 4px 15px rgba(255, 182, 193, 0.4); border: 1px solid #FFE4E1; flex: 1; }
        h2, h3 { color: #D14D72; margin-top: 0; text-align: center; }
        .form-group { margin-bottom: 12px; }
        .form-group label { display: block; color: #D14D72; margin-bottom: 4px; font-weight: 600; font-size: 14px; }
        .form-group input, .form-group select { width: 100%; padding: 8px; border: 1px solid #FFB6C1; border-radius: 6px; box-sizing: border-box; background-color: #FFF5F7; }
        .btn { width: 100%; padding: 10px; background-color: #FFB6C1; border: none; border-radius: 6px; color: white; font-weight: bold; cursor: pointer; transition: background 0.2s; }
        .btn:hover { background-color: #D14D72; }
        .results-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .results-table th, .results-table td { border: 1px solid #FFE4E1; padding: 10px; text-align: left; font-size: 13px; }
        .results-table th { background-color: #D14D72; color: white; }
    </style>
</head>
<body>

    <h2>XML Personal Finance Database Directory</h2>
    
    <div class="dashboard">
        <div class="panel">
            <h3>Add New Expense</h3>
            <form action="xmlBudget.jsp" method="POST">
                <input type="hidden" name="action" value="add" />
                <div class="form-group">
                    <label>Date:</label>
                    <input type="date" name="date" required />
                </div>
                <div class="form-group">
                    <label>Item Name:</label>
                    <input type="text" name="item" required />
                </div>
                <div class="form-group">
                    <label>Category:</label>
                    <select name="category">
                        <option value="Food">Food</option>
                        <option value="Utilities">Utilities</option>
                        <option value="Entertainment">Entertainment</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Payment Method:</label>
                    <select name="payment">
                        <option value="Cash">Cash</option>
                        <option value="Debit Card">Debit Card</option>
                        <option value="Credit Card">Credit Card</option>
                        <option value="UPI">UPI</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Amount ($):</label>
                    <input type="number" step="0.01" name="amount" required />
                </div>
                <button type="submit" class="btn">Save to XML DB</button>
            </form>
            
            <hr style="border: 0; border-top: 1px solid #FFE4E1; margin: 20px 0;" />
            
            <h3>XPath Conditional Filter</h3>
            <form action="xmlBudget.jsp" method="GET">
                <input type="hidden" name="action" value="search" />
                <div class="form-group">
                    <label>Find entries where Amount is greater than ($):</label>
                    <input type="number" step="0.01" name="threshold" value="${param.threshold != null ? param.threshold : '0.00'}" required />
                </div>
                <button type="submit" class="btn" style="background-color: #D14D72;">Run XPath Query</button>
            </form>
        </div>

        <div class="panel" style="flex: 1.8;">
            <h3>Database View Summary</h3>
            <%
                String xmlPath = application.getRealPath("/expenses.xml");
                String xslPath = application.getRealPath("/expenses.xsl");
                File xmlFile = new File(xmlPath);

                String action = request.getParameter("action");

                if ("add".equals(action)) {
                    String date = request.getParameter("date");
                    String item = request.getParameter("item");
                    String category = request.getParameter("category");
                    String payment = request.getParameter("payment");
                    String amount = request.getParameter("amount");

                    if (date != null && item != null && category != null && payment != null && amount != null) {
                        try {
                            DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
                            docFactory.setValidating(false);
                            DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
                            Document doc = docBuilder.parse(xmlFile);

                            Element newExpense = doc.createElement("expense");
                            
                            Element dateNode = doc.createElement("date");
                            dateNode.appendChild(doc.createTextNode(date));
                            Element itemNode = doc.createElement("item");
                            itemNode.appendChild(doc.createTextNode(item));
                            Element catNode = doc.createElement("category");
                            catNode.appendChild(doc.createTextNode(category));
                            Element payNode = doc.createElement("payment");
                            payNode.appendChild(doc.createTextNode(payment));
                            Element amtNode = doc.createElement("amount");
                            amtNode.appendChild(doc.createTextNode(amount));

                            newExpense.appendChild(dateNode);
                            newExpense.appendChild(itemNode);
                            newExpense.appendChild(catNode);
                            newExpense.appendChild(payNode);
                            newExpense.appendChild(amtNode);
                            doc.getDocumentElement().appendChild(newExpense);

                            TransformerFactory tf = TransformerFactory.newInstance();
                            Transformer t = tf.newTransformer();
                            DOMSource source = new DOMSource(doc);
                            StreamResult result = new StreamResult(xmlFile);
                            t.transform(source, result);

                            response.sendRedirect("xmlBudget.jsp");
                            return;
                        } catch (Exception e) {
                            out.println("<p style='color:red;'>DOM Write Error: " + e.getMessage() + "</p>");
                        }
                    }
                }

                if ("search".equals(action) && request.getParameter("threshold") != null && !request.getParameter("threshold").isEmpty()) {
                    String threshold = request.getParameter("threshold");
                    try {
                        DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
                        DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
                        Document doc = docBuilder.parse(xmlFile);

                        XPathFactory xpathFactory = XPathFactory.newInstance();
                        XPath xpath = xpathFactory.newXPath();
                        
                        String xpathExpr = "/expenseSystem/expense[amount > " + threshold + "]";
                        NodeList nodes = (NodeList) xpath.evaluate(xpathExpr, doc, XPathConstants.NODESET);

                        out.println("<p style='color:#D14D72; font-weight:bold;'>XPath filtered matching elements ("+ nodes.getLength() +"):</p>");
                        out.println("<table class='results-table'><tr><th>Date</th><th>Item</th><th>Category</th><th>Payment</th><th>Amount</th></tr>");
                        for (int i = 0; i < nodes.getLength(); i++) {
                            Node node = nodes.item(i);
                            if (node.getNodeType() == Node.ELEMENT_NODE) {
                                Element element = (Element) node;
                                String date = element.getElementsByTagName("date").item(0).getTextContent();
                                String item = element.getElementsByTagName("item").item(0).getTextContent();
                                String cat = element.getElementsByTagName("category").item(0).getTextContent();
                                String pay = element.getElementsByTagName("payment").item(0).getTextContent();
                                String amt = element.getElementsByTagName("amount").item(0).getTextContent();
                                out.println("<tr><td>" + date + "</td><td>" + item + "</td><td>" + cat + "</td><td>" + pay + "</td><td>$" + amt + "</td></tr>");
                            }
                        }
                        out.println("</table><br/><a href='xmlBudget.jsp' style='color:#D14D72; font-size:13px;'>Clear Query Filter</a>");
                    } catch (Exception e) {
                        out.println("<p style='color:red;'>XPath Execution Error: " + e.getMessage() + "</p>");
                    }
                } else {
					try {
					Source xmlSource = new StreamSource(xmlFile);
					Source xslSource = new StreamSource(new File(xslPath));
					TransformerFactory factory = TransformerFactory.newInstance();
					Transformer transformer = factory.newTransformer(xslSource);
					transformer.transform(xmlSource, new StreamResult(out));} catch (Exception e) {
						out.println("XSLT Transformation Error: " + e.getMessage() + "");
}}%>