<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
        <head>
            <style>
                body { background-color: #FFF5F7; font-family: 'Segoe UI', Arial, sans-serif; margin: 0; padding: 10px; }
                table { width: 100%; border-collapse: separate; border-spacing: 0; background-color: #FFFFFF; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(255, 182, 193, 0.2); }
                th, td { padding: 12px 15px; text-align: left; }
                th { background-color: #FFB6C1; color: #FFFFFF; font-weight: bold; font-size: 14px; }
                tr { border-bottom: 1px solid #FFE4E1; }
                tr:nth-child(even) { background-color: #FFF0F5; }
                td { color: #555555; font-size: 13px; border-bottom: 1px solid #FFE4E1; }
            </style>
        </head>
        <body>
            <table>
                <tr>
                    <th>Date</th>
                    <th>Item Name</th>
                    <th>Category</th>
                    <th>Payment Method</th>
                    <th>Amount ($)</th>
                </tr>
                <xsl:for-each select="expenseSystem/expense">
                <tr>
                    <td><xsl:value-of select="date"/></td>
                    <td><xsl:value-of select="item"/></td>
                    <td><xsl:value-of select="category"/></td>
                    <td><xsl:value-of select="payment"/></td>
                    <td><xsl:value-of select="amount"/></td>
                </tr>
                </xsl:for-each>
            </table>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
