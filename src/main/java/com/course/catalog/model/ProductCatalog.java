package com.course.catalog.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * ProductCatalog - In-memory catalog provider for Lab 2.
 * Serves static sample product data prior to JPA integration in Lab 4.
 */
public class ProductCatalog {

    private static final List<ProductDTO> PRODUCTS = new ArrayList<>();

    static {
        PRODUCTS.add(new ProductDTO(1L, "Wireless Noise-Canceling Headphones", "Electronics", 149.99));
        PRODUCTS.add(new ProductDTO(2L, "Mechanical Gaming Keyboard", "Electronics", 89.99));
        PRODUCTS.add(new ProductDTO(3L, "Enterprise Java Microservices", "Books", 45.00));
        PRODUCTS.add(new ProductDTO(4L, "Designing Data-Intensive Applications", "Books", 52.50));
        PRODUCTS.add(new ProductDTO(5L, "Organic Cotton Developer Hoodie", "Clothing", 59.99));
        PRODUCTS.add(new ProductDTO(6L, "Ultra-Wide 4K Gaming Monitor", "Electronics", 399.00));
    }

    public static List<ProductDTO> findAll() {
        return Collections.unmodifiableList(PRODUCTS);
    }

    public static ProductDTO findById(Long id) {
        if (id == null) {
            return null;
        }
        return PRODUCTS.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public static List<String> getCategories() {
        return PRODUCTS.stream()
                .map(ProductDTO::getCategory)
                .distinct()
                .toList();
    }
}
