package com.course.catalog.web;

import com.course.catalog.model.ProductCatalog;
import com.course.catalog.model.ProductDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ProductListServlet - Lab 2 Step 2 & Activity 1.
 * Lists catalog products, with optional filtering by category.
 */
@WebServlet("/catalog/products")
public class ProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String category = req.getParameter("category"); // may be null
        List<ProductDTO> products = ProductCatalog.findAll();

        if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
            products = products.stream()
                    .filter(p -> p.getCategory().equalsIgnoreCase(category.trim()))
                    .toList();
        }

        req.setAttribute("products", products);
        req.setAttribute("selectedCategory", category != null ? category : "All");
        req.setAttribute("categories", ProductCatalog.getCategories());
        req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, resp);
    }
}
