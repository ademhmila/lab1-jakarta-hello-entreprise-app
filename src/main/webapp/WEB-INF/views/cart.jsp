<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<h1 style="margin: 0 0 20px 0; font-size: 24px;">Your Shopping Cart</h1>

<c:choose>
    <c:when test="${empty sessionScope.cart || sessionScope.cart.size() == 0}">
        <div class="card" style="text-align: center; padding: 48px 24px;">
            <p style="font-size: 18px; color: var(--text-muted); margin-bottom: 20px;">
                Your shopping cart is currently empty.
            </p>
            <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn-primary">
                Browse Catalog
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="card" style="padding: 0; overflow: hidden;">
            <table class="table-responsive">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Category</th>
                        <th style="text-align: right;">Price</th>
                        <th style="text-align: center; width: 120px;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${sessionScope.cart}">
                        <tr>
                            <td>
                                <strong>
                                    <a href="${pageContext.request.contextPath}/catalog/product?id=${item.id}" style="color: var(--text); text-decoration: none;">
                                        ${item.name}
                                    </a>
                                </strong>
                            </td>
                            <td><span class="product-category" style="margin: 0;">${item.category}</span></td>
                            <td style="text-align: right; font-weight: 600;">
                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="$" />
                            </td>
                            <td style="text-align: center;">
                                <!-- Chapter 2 Activity 2: Remove from Cart Form -->
                                <form action="${pageContext.request.contextPath}/cart/remove" method="POST" style="margin: 0;">
                                    <input type="hidden" name="productId" value="${item.id}">
                                    <input type="hidden" name="action" value="remove">
                                    <button type="submit" class="btn btn-danger" style="padding: 4px 10px; font-size: 12px;">
                                        Remove
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div style="padding: 20px 24px; background: #f8fafc; display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border);">
                <div>
                    <span style="font-size: 14px; color: var(--text-muted);">Total Items:</span>
                    <strong>${sessionScope.cart.size()}</strong>
                </div>
                <div style="display: flex; align-items: center; gap: 24px;">
                    <div>
                        <span style="font-size: 14px; color: var(--text-muted); margin-right: 8px;">Order Total:</span>
                        <span style="font-size: 22px; font-weight: 800; color: #0f172a;">
                            <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="$" />
                        </span>
                    </div>
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary" style="padding: 10px 22px;">
                        Proceed to Checkout &rarr;
                    </a>
                </div>
            </div>
        </div>

        <div>
            <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn-secondary">
                &larr; Continue Shopping
            </a>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="footer.jsp" />
