<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Otakumate</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Georgia, serif !important;
            margin: 20px !important; /* Use !important to increase specificity */
        }

        table {
            font-family: Georgia, serif !important;
            font-size: 20px !important;
            width: 100%;
            border-collapse: collapse;
            background-color: #F2F2F2; /* Set your desired background color */
            margin-top: 20px; /* Optional: Add some space above the table */
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #7FBFB0; /* Set your desired header background color */
            color: white;
        }

        .form-fm, .hd-h1, .hd-h3 {
            font-family: Georgia, serif !important;
            padding-top: 20px !important;
            padding-left: 10px !important;
        }

        .col-md-1 {
            width: 150px;
        }

        .img {
            max-height: 200px;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<h1 class=hd-h1>Browse Products By Category and Search by Product Name:</h1>

<form class=form-fm method="get" action="listprod.jsp">
  <p align="left">
  <select size="1" name="categoryName">
  <option>All</option>
  <option>Mangas</option>
  <option>Video Games</option>
  <option>TCGs</option>
  <option>Figures</option>
  <input type="text" name="productName" size="50">
  </select><input type="submit" value="Submit"><input type="reset" value="Reset"></p> (Leave blank for all products)
</form>

<h3 class=hd-h3>All Products</h3>

<% 
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
    out.println("ClassNotFoundException: " +e);
}

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
{
    // Write query to retrieve all order summary records
    String sql = "SELECT product.productId, productName, productPrice, categoryId, productImageURL, SUM(quantity) AS totalOrderedQuantity " +
                 "FROM product LEFT JOIN orderproduct ON product.productId = orderproduct.productId " +
                 "GROUP BY product.productId, productName, productPrice, categoryId, productImageURL "+
                 "ORDER BY totalOrderedQuantity DESC, product.productId ASC";
            
    PreparedStatement pstmt = null;
    ResultSet rst = null;
    // Get product category to search for
    String categoryName = request.getParameter("categoryName");
    if (categoryName == null)
        categoryName = "All";
    int catId = 0;
    if (categoryName.equals("Mangas"))
        catId = 1;
    else if (categoryName.equals("Video Games"))
        catId = 2;
    else if (categoryName.equals("TCGs"))
        catId = 3;
    else if (categoryName.equals("Figures"))
        catId = 4;

    // Create a Hash Map for each Category and Category font color
    HashMap<Integer, String> category = new HashMap<>();
    category.put(1, "Mangas");
    category.put(2, "Video Games");
    category.put(3, "TCGs");
    category.put(4, "Figures");
    HashMap<Integer, String> catColor = new HashMap<>();
    catColor.put(1, "#2E96FF");
    catColor.put(2, "#FD632E");
    catColor.put(3, "#1166A7");
    catColor.put(4, "#A959FF");

    // Get product name to search for
    String name = request.getParameter("productName");

    boolean hasCatgry = catId != 0;
    boolean hasSearch = name != null && !name.equals("");

    // Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
    if (!hasCatgry && !hasSearch) {		// All and blank
        pstmt = con.prepareStatement(sql);
    } else if (hasCatgry && !hasSearch) {	// Category and blank
        sql = "SELECT product.productId, productName, productPrice, categoryId, productImageURL, SUM(quantity) AS totalOrderedQuantity " +
              "FROM product LEFT JOIN orderproduct ON product.productId = orderproduct.productId " +
              "WHERE categoryId = ? " +
              "GROUP BY product.productId, productName, productPrice, categoryId, productImageURL " +
              "ORDER BY totalOrderedQuantity DESC, product.productId ASC";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, catId);
    } else if (!hasCatgry && hasSearch) {	// All and search
        sql = "SELECT product.productId, productName, productPrice, categoryId, productImageURL, SUM(quantity) AS totalOrderedQuantity " +
              "FROM product LEFT JOIN orderproduct ON product.productId = orderproduct.productId " +
              "WHERE productName LIKE ? " +
              "GROUP BY product.productId, productName, productPrice, categoryId, productImageURL " +
              "ORDER BY totalOrderedQuantity DESC, product.productId ASC";
        name = "%" + name + "%";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, name);
    } else if (hasCatgry && hasSearch) {	// Category and search
        sql = "SELECT product.productId, productName, productPrice, categoryId, productImageURL, SUM(quantity) AS totalOrderedQuantity " +
              "FROM product LEFT JOIN orderproduct ON product.productId = orderproduct.productId " +
              "WHERE productName LIKE ? AND categoryId = ? " +
              "GROUP BY product.productId, productName, productPrice, categoryId, productImageURL " +
              "ORDER BY totalOrderedQuantity DESC, product.productId ASC";
        name = "%" + name + "%";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setInt(2, catId);
    } 
    rst = pstmt.executeQuery();
    
    // Print out the ResultSet
    out.println("<font face=Century Gothic size=3><table class=table border=1><tr><th class=col-md-1></th><th>Product Name</th><th>Product Image</th><th>Category</th><th>Price</th></tr>");
    while (rst.next()) {
        int productId = rst.getInt(1);
        String productName = rst.getString(2);
        double productPrice = rst.getDouble(3);
        int categoryId = rst.getInt(4);
        String productImageURL = rst.getString(5);
        // For each product create a link of the form
        out.println("<tr><td class='col-md-1' style='text-align: center;'><form action='addcart.jsp' method='GET'>");
        out.println("<input type='hidden' name='id' value='" + productId + "'>");
        out.println("<input type='hidden' name='name' value='" + java.net.URLEncoder.encode(productName, "UTF-8") + "'>");
        out.println("<input type='hidden' name='price' value='" + productPrice + "'>");
        out.println("<button type='submit' style='background-color: #638AB4; color: #FFFFFF;'>Add to Cart</button></form></td>");
        out.println("<td class=col-6><a href=product.jsp?id=" + productId + ">" + productName + "</a></td>");
        out.println("<td><img class='img' src=" + productImageURL + "></td>");
        out.println("<td><font color=" + catColor.get(categoryId) + ">" + category.get(categoryId) + "</font></td>");
        NumberFormat currFmt = NumberFormat.getCurrencyInstance();
        out.println("<td><font color=" + catColor.get(categoryId) + ">" + currFmt.format(productPrice) + "</font></td></tr>");
    }
    out.println("</table></font>");
    out.close();
    // Close connection
    con.close();
} catch (SQLException ex) {
    out.println("SQLException: " + ex);
}
%>

</body>
</html>