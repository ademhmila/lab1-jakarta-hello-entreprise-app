package com.course.catalog.web;

import com.course.catalog.model.ProductDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * CheckoutServlet - Lab 2 Step 5.
 * Handles checkout form rendering and submission, clearing the session cart upon completion.
 */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        List<ProductDTO> cart = (List<ProductDTO>) session.getAttribute("cart");
        double total = (cart != null) ? cart.stream().mapToDouble(ProductDTO::getPrice).sum() : 0.0;
        req.setAttribute("checkoutTotal", total);
        req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        List<ProductDTO> cart = (List<ProductDTO>) session.getAttribute("cart");
        int itemCount = (cart != null) ? cart.size() : 0;
        double orderTotal = (cart != null) ? cart.stream().mapToDouble(ProductDTO::getPrice).sum() : 0.0;

        // Order persistence logic arrives in Chapter 3 (EJB service layer) / Chapter 4 (JPA).
        // Clear cart from session on successful checkout:
        session.removeAttribute("cart");

        req.setAttribute("confirmationName", name);
        req.setAttribute("confirmationEmail", email);
        req.setAttribute("confirmationAddress", address);
        req.setAttribute("orderItemCount", itemCount);
        req.setAttribute("orderTotal", orderTotal);

        req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
    }
}
