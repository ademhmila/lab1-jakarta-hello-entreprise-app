package com.course.catalog.web;

import com.course.catalog.model.ProductCatalog;
import com.course.catalog.model.ProductDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * CartServlet - Lab 2 Step 4 & Activity 2.
 * Handles viewing the cart (GET /cart), adding items (POST /cart/add),
 * and removing items (POST /cart/remove).
 */
@WebServlet({"/cart", "/cart/add", "/cart/remove"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        List<ProductDTO> cart = (List<ProductDTO>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        double total = cart.stream().mapToDouble(ProductDTO::getPrice).sum();
        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String servletPath = req.getServletPath();
        String actionParam = req.getParameter("action");
        String productIdParam = req.getParameter("productId");

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        List<ProductDTO> cart = (List<ProductDTO>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        if (productIdParam != null && !productIdParam.trim().isEmpty()) {
            try {
                Long productId = Long.valueOf(productIdParam);

                // Handle removal (Activity 2)
                if ("/cart/remove".equals(servletPath) || "remove".equalsIgnoreCase(actionParam)) {
                    Iterator<ProductDTO> iterator = cart.iterator();
                    while (iterator.hasNext()) {
                        ProductDTO p = iterator.next();
                        if (p.getId().equals(productId)) {
                            iterator.remove();
                            break; // Remove single item instance
                        }
                    }
                } else {
                    // Default: Add item to cart (Step 4)
                    ProductDTO product = ProductCatalog.findById(productId);
                    if (product != null) {
                        cart.add(product);
                    }
                }
            } catch (NumberFormatException ignored) {
            }
        }

        session.setAttribute("cart", cart);
        // Post/Redirect/Get pattern prevents duplicate submissions on refresh
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
