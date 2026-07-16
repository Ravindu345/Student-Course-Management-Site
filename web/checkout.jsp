<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Course" %>
<%@ page import="model.Cart" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Code Nexus - Checkout</title>
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
        .payment-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .payment-methods {
            margin-bottom: 20px;
        }
        .payment-details {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }
        .bank-details {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
        }
    </style>
</head>
<body>

    <!-- Navbar (Simplified for Checkout page) -->
    <nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
        <div class="container">
            <a class="navbar-brand" href="2ndpage.jsp">
                <img src="pics/atom2.png" alt="Atom Icon" height="30" class="d-inline-block align-text-top me-2">
                <span style="color: white;">Code Nexus</span>
            </a>
            <div class="collapse navbar-collapse" id="navbarNavCheckout">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">Back to Cart</a>
                    </li>
                    <li class="nav-item">
                         <a class="nav-link" href="2ndpage.jsp">Continue Shopping</a>
                     </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4 text-center">Order Summary</h2>

        <% 
            Cart cartObj = (Cart) session.getAttribute("cart");
            List<Course> cartItems = new ArrayList<>();
            double total = 0.0;

            if (cartObj != null) {
                cartItems = cartObj.getItems();
                for (Course item : cartItems) {
                    try {
                        total += item.getPrice();
                    } catch (NumberFormatException e) {
                        // Handle cases where price is not a valid number
                        System.err.println("Error parsing price for course: " + item.getCourseName() + ": " + e.getMessage());
                    }
                }
            }
        %>

        <% if (cartItems.isEmpty()) { %>
            <div class="alert alert-warning text-center" role="alert">
                Your cart is empty. Please add items before checking out. <a href="2ndpage.jsp" class="alert-link">Continue shopping</a>.
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
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="row mt-3">
                <div class="col-md-6 offset-md-6 text-end">
                    <h4>Total: $<%= String.format("%.2f", total) %></h4>
                </div>
            </div>

            <!-- Payment Options Section -->
            <div class="payment-section mt-4">
                <h4 class="mb-3">Select Payment Method</h4>
                <div class="payment-methods">
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="creditCard" checked>
                        <label class="form-check-label" for="creditCard">
                            <i class="fas fa-credit-card"></i> Credit Card
                        </label>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="paypal" value="paypal">
                        <label class="form-check-label" for="paypal">
                            <i class="fab fa-paypal"></i> PayPal
                        </label>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="bankTransfer">
                        <label class="form-check-label" for="bankTransfer">
                            <i class="fas fa-university"></i> Bank Transfer
                        </label>
                    </div>
                </div>

                <!-- Credit Card Details -->
                <div id="creditCardDetails" class="payment-details mt-3">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="cardNumber">Card Number</label>
                            <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="expiryDate">Expiry Date</label>
                            <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY" maxlength="5">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="cvv">CVV</label>
                            <input type="text" class="form-control" id="cvv" placeholder="123" maxlength="3">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="cardName">Name on Card</label>
                            <input type="text" class="form-control" id="cardName" placeholder="John Doe">
                        </div>
                    </div>
                </div>

                <!-- PayPal Details -->
                <div id="paypalDetails" class="payment-details mt-3" style="display: none;">
                    <p>You will be redirected to PayPal to complete your payment.</p>
                </div>

                <!-- Bank Transfer Details -->
                <div id="bankTransferDetails" class="payment-details mt-3" style="display: none;">
                    <p>Please use the following bank details for your transfer:</p>
                    <div class="bank-details">
                        <p><strong>Bank:</strong> Example Bank</p>
                        <p><strong>Account Name:</strong> Code Nexus</p>
                        <p><strong>Account Number:</strong> 1234567890</p>
                        <p><strong>Routing Number:</strong> 987654321</p>
                    </div>
                </div>
            </div>

            <div class="text-center mt-4">
                <form action="${pageContext.request.contextPath}/processCheckout" method="post" id="checkoutForm">
                    <input type="hidden" name="paymentMethod" id="selectedPaymentMethod" value="creditCard">
                    <!-- Credit Card Details -->
                    <input type="hidden" name="cardNumber" id="formCardNumber">
                    <input type="hidden" name="expiryDate" id="formExpiryDate">
                    <input type="hidden" name="cardName" id="formCardName">
                    <button type="submit" class="btn btn-success btn-lg" onclick="return validateAndSubmit()">
                        <i class="fas fa-check-circle"></i> Place Order
                    </button>
                </form>
            </div>

            <script>
                // Handle payment method selection
                document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
                    radio.addEventListener('change', function() {
                        // Hide all payment details
                        document.querySelectorAll('.payment-details').forEach(detail => {
                            detail.style.display = 'none';
                        });
                        
                        // Show selected payment details
                        const selectedMethod = this.value;
                        document.getElementById(selectedMethod + 'Details').style.display = 'block';
                        document.getElementById('selectedPaymentMethod').value = selectedMethod;
                    });
                });

                // Format card number with spaces
                document.getElementById('cardNumber').addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                    let formattedValue = '';
                    for(let i = 0; i < value.length; i++) {
                        if(i > 0 && i % 4 === 0) {
                            formattedValue += ' ';
                        }
                        formattedValue += value[i];
                    }
                    e.target.value = formattedValue;
                });

                // Format expiry date
                document.getElementById('expiryDate').addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                    if(value.length >= 2) {
                        value = value.substring(0,2) + '/' + value.substring(2);
                    }
                    e.target.value = value;
                });

                // Only allow numbers in CVV
                document.getElementById('cvv').addEventListener('input', function(e) {
                    e.target.value = e.target.value.replace(/[^0-9]/gi, '');
                });

                // Validate and submit form
                function validateAndSubmit() {
                    const paymentMethod = document.getElementById('selectedPaymentMethod').value;
                    
                    if (paymentMethod === 'creditCard') {
                        const cardNumber = document.getElementById('cardNumber').value.replace(/\s+/g, '');
                        const expiryDate = document.getElementById('expiryDate').value;
                        const cvv = document.getElementById('cvv').value;
                        const cardName = document.getElementById('cardName').value;

                        // Basic validation
                        if (cardNumber.length !== 16) {
                            alert('Please enter a valid 16-digit card number');
                            return false;
                        }
                        if (!expiryDate.match(/^\d{2}\/\d{2}$/)) {
                            alert('Please enter a valid expiry date (MM/YY)');
                            return false;
                        }
                        if (cvv.length !== 3) {
                            alert('Please enter a valid 3-digit CVV');
                            return false;
                        }
                        if (!cardName.trim()) {
                            alert('Please enter the name on card');
                            return false;
                        }

                        // Set form values
                        document.getElementById('formCardNumber').value = cardNumber;
                        document.getElementById('formExpiryDate').value = expiryDate;
                        document.getElementById('formCardName').value = cardName;
                    }

                    return true;
                }
            </script>

        <% } %>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 