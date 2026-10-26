<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
    <div>
        <h1 style="margin: 0; font-size: 24px;">Product Catalog</h1>
        <p style="margin: 4px 0 0 0; color: var(--text-muted); font-size: 14px;">Browse and filter products in real-time</p>
    </div>
</div>

<!-- Chapter 2 Activity 1: Category Filter Bar -->
<div class="filter-bar">
    <span style="font-size: 13px; font-weight: 600; color: var(--text-muted);">Filter by Category:</span>
    <a href="${pageContext.request.contextPath}/catalog/products" 
       class="filter-pill ${empty param.category || param.category == 'All' ? 'active' : ''}">
        All Products
    </a>
    <c:forEach var="cat" items="${categories}">
        <a href="${pageContext.request.contextPath}/catalog/products?category=${cat}" 
           class="filter-pill ${param.category == cat ? 'active' : ''}">
            ${cat}
        </a>
    </c:forEach>
</div>

<!-- Product Cards Grid -->
<div class="grid-cards">
    <c:forEach var="product" items="${products}">
        <div class="product-card">
            <div>
                <span class="product-category">${product.category}</span>
                <h3 class="product-title">
                    <a href="${pageContext.request.contextPath}/catalog/product?id=${product.id}">
                        ${product.name}
                    </a>
                </h3>
            </div>
            <div>
                <p class="product-price">
                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" />
                </p>
                <div style="display: flex; gap: 8px;">
                    <a href="${pageContext.request.contextPath}/catalog/product?id=${product.id}" class="btn btn-secondary" style="flex: 1;">
                        Details
                    </a>
                    <form action="${pageContext.request.contextPath}/cart/add" method="POST" style="margin: 0; flex: 1;">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" class="btn btn-primary" style="width: 100%;">
                            + Cart
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<jsp:include page="footer.jsp" />
