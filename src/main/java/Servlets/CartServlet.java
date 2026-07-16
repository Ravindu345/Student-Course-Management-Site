package Servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Course;
import utils.CourseFileHandler;

@WebServlet("/cart/*")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Check if user is logged in
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getPathInfo();
        String userId = (String) session.getAttribute("userId");

        // Get or create cart
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart(userId);
            session.setAttribute("cart", cart);
        }

        if ("/add".equals(action)) {
            String courseName = request.getParameter("courseName");
            Course course = CourseFileHandler.getCourseByName(courseName);
            if (course != null) {
                cart.addItem(course);
                session.setAttribute("cartCount", cart.getItems().size());
            }
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        } else if ("/remove".equals(action)) {
            String courseName = request.getParameter("courseName");
            Course course = CourseFileHandler.getCourseByName(courseName);
            if (course != null) {
                cart.removeItem(course);
                session.setAttribute("cartCount", cart.getItems().size());
            }
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart((String) session.getAttribute("userId"));
            session.setAttribute("cart", cart);
        }

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
} 