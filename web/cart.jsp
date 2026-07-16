<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Course" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Code Nexus - Cart</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(to right, #ffffff, #c0c0c0);
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            margin-bottom: 20px;
        }
        .gradient-bg {
            background: linear-gradient(135deg, #1a1a1a, #434343);
        }
        .footer {
            margin-top: auto;
            padding: 20px 0;
            text-align: center;
            background-color: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }
    </style>
</head>
<body>

    <!-- Navbar (Simplified for Cart page) -->
    <nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
        <div class="container">
            <a class="navbar-brand" href="2ndpage.jsp">
                <img src="pics/atom2.png" alt="Atom Icon" height="30" class="d-inline-block align-text-top me-2">
                <span style="color: white;">Code Nexus</span>
            </a>
            <div class="collapse navbar-collapse" id="navbarNavCart">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="2ndpage.jsp">Continue Shopping</a>
                    </li>
                    <% 
                        // Placeholder for user logo/dropdown if needed, or remove
                        // Object userObj = session.getAttribute("user");
                        // String userName = (userObj instanceof model.User) ? ((model.User) userObj).getName() : null;
                        // if (userName != null) { 
                    %>
                        <%-- User logo dropdown placeholder --%>
                    <%// } else { %>
                        <%-- Login/Register links placeholder --%>
                    <%// } %>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4 text-center">Shopping Cart</h2>

        <% 
            // Retrieve the Cart object from the session
            model.Cart cartObj = (model.Cart) session.getAttribute("cart");
            List<Course> cartItems = new ArrayList<>();

            if (cartObj != null) {
                // Get the list of items from the Cart object
                cartItems = cartObj.getItems();
            }
        %>

        <% if (cartItems.isEmpty()) { %>
            <div class="alert alert-info text-center" role="alert">
                Your cart is empty. <a href="2ndpage.jsp" class="alert-link">Continue shopping</a>.
            </div>
        <% } else { %>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Course Name</th>
                        <th scope="col">Instructor</th>
                        <th scope="col">Price</th>
                        <th scope="col">Duration</th>
                        <th scope="col">Category</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Course item : cartItems) { %>
                        <tr>
                            <td><%= item.getCourseName() %></td>
                            <td><%= item.getInstructor() %></td>
                            <td>$<%= item.getPrice() %></td>
                            <td><%= item.getDuration() %></td>
                            <td><%= item.getCategory() %></td>
                            <td>
                                <%-- Add Remove button linked to a RemoveFromCart servlet --%>
                                <form action="cart/remove" method="post" style="display:inline-block;">
                                    <input type="hidden" name="courseName" value="<%= item.getCourseName() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="fas fa-trash-alt"></i> Remove
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="text-end mt-4">
                <%-- Add a button to proceed to checkout --%>
                <a href="checkout.jsp" class="btn btn-success btn-lg">
                    <i class="fas fa-credit-card"></i> Proceed to Checkout
                </a>
            </div>

        <% } %>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 