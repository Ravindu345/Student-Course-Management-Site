package Servlets;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Course;

@WebServlet("/processCheckout")
public class ProcessCheckoutServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("Processing checkout request");
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }


        String paymentMethod = request.getParameter("paymentMethod");
        System.out.println("Payment method: " + paymentMethod); // Debug log
        
        // Get payment details based on method
        String paymentDetails = "";
        if ("creditCard".equals(paymentMethod)) {
            String cardNumber = request.getParameter("cardNumber");
            String expiryDate = request.getParameter("expiryDate");
            String cardName = request.getParameter("cardName");
            // Mask card number for security
            String maskedCard = cardNumber.substring(0, 4) + " **** **** " + cardNumber.substring(cardNumber.length() - 4);
            paymentDetails = String.format("Card: %s, Expiry: %s, Name: %s", maskedCard, expiryDate, cardName);
        } else if ("paypal".equals(paymentMethod)) {
            paymentDetails = "PayPal Payment";
        } else if ("bankTransfer".equals(paymentMethod)) {
            paymentDetails = "Bank Transfer";
        }

        // Create payment record
        StringBuilder paymentRecord = new StringBuilder();
        paymentRecord.append("\n=== New Payment ===\n");
        paymentRecord.append("Date: ").append(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())).append("\n");
        paymentRecord.append("User ID: ").append(cart.getUserId()).append("\n");
        paymentRecord.append("Payment Method: ").append(paymentMethod).append("\n");
        paymentRecord.append("Payment Details: ").append(paymentDetails).append("\n");
        paymentRecord.append("Total Amount: $").append(String.format("%.2f", cart.getTotal())).append("\n");
        paymentRecord.append("Items:\n");
        
        for (Course item : cart.getItems()) {
            paymentRecord.append("- ").append(item.getCourseName())
                      .append(" ($").append(item.getPrice())
                      .append(") - ").append(item.getInstructor())
                      .append("\n");
        }
        paymentRecord.append("================\n");


        String desktopPath = System.getProperty("user.home") + "/Desktop/finalProject";
        String dataDir = desktopPath + "/web/data";
        String paymentsFile = dataDir + "/payments.txt";
        

        File dataDirectory = new File(dataDir);
        if (!dataDirectory.exists()) {
            dataDirectory.mkdirs();
        }


        try (FileWriter fw = new FileWriter(paymentsFile, true);
             PrintWriter writer = new PrintWriter(fw)) {
            writer.println(paymentRecord.toString());
            System.out.println("Payment details written to file successfully"); // Debug log
        }


        session.removeAttribute("cart");
        session.removeAttribute("cartCount");


        response.sendRedirect("orderSuccess.jsp");
    }
} 