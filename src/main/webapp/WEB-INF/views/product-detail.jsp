<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div style="margin-bottom: 16px;">
    <a href="${pageContext.request.contextPath}/catalog/products" class="nav-link" style="font-size: 13px;">
        &larr; Back to Catalog
    </a>
</div>

<div class="card" style="max-width: 650px; margin: 0 auto;">
    <span class="product-category">${product.category}</span>
    <h1 style="margin: 8px 0 16px 0; font-size: 26px;">${product.name}</h1>

    <div style="margin-bottom: 24px; padding: 16px; background: #f8fafc; border-radius: var(--radius);">
        <span style="font-size: 13px; color: var(--text-muted); display: block; margin-bottom: 4px;">Price</span>
        <span style="font-size: 28px; font-weight: 800; color: #0f172a;">
            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" />
        </span>
    </div>

    <p style="color: var(--text-muted); line-height: 1.6; margin-bottom: 24px;">
        High-grade enterprise product provided as part of the Jakarta EE 11 Lab 2 E-Commerce application.
        Ready for in-memory session ordering and upcoming JPA database persistence.
    </p>

    <!-- Add to Cart Form (Step 9) -->
    <form action="${pageContext.request.contextPath}/cart/add" method="POST">
        <input type="hidden" name="productId" value="${product.id}">
        <div style="display: flex; gap: 12px;">
            <button type="submit" class="btn btn-primary" style="padding: 12px 24px; font-size: 15px;">
                🛒 Add to Shopping Cart
            </button>
            <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn-secondary">
                Continue Shopping
            </a>
        </div>
    </form>
</div>

<jsp:include page="footer.jsp" />
