<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Code Nexus - Order Success</title>
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
        .success-container {
            text-align: center;
            padding: 50px 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            margin-top: 50px;
        }
        .success-icon {
            color: #28a745;
            font-size: 80px;
            margin-bottom: 20px;
        }
        .btn-home {
            background: linear-gradient(135deg, #1a1a1a, #434343);
            color: white;
            padding: 10px 30px;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-container">
            <i class="fas fa-check-circle success-icon"></i>
            <h1 class="mb-4">Order Placed Successfully!</h1>
            <p class="lead mb-4">Thank you for your purchase. Your order has been recorded.</p>
            <p class="mb-4">You can find your order details in the orders.txt file.</p>
            <a href="2ndpage.jsp" class="btn btn-home">
                <i class="fas fa-home"></i> Return to Home
            </a>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 