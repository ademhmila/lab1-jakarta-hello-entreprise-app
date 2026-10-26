<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<h1 style="margin: 0 0 20px 0; font-size: 24px;">Order Checkout</h1>

<!-- Confirmation Alert (Step 9) -->
<c:if test="${not empty confirmationName}">
    <div class="alert-success">
        <h3 style="margin: 0 0 8px 0; font-size: 18px;">🎉 Order Placed Successfully!</h3>
        <p style="margin: 0 0 8px 0;">
            Thank you, <strong>${confirmationName}</strong>! Your order of <strong>${orderItemCount} item(s)</strong>
            totaling <strong><fmt:formatNumber value="${orderTotal}" type="currency" currencySymbol="$" /></strong> has been processed.
        </p>
        <p style="margin: 0; font-size: 13px;">
            A confirmation receipt will be sent to <strong>${confirmationEmail}</strong>. Shipping address: <strong>${confirmationAddress}</strong>.
            (Cart has been reset).
        </p>
        <div style="margin-top: 16px;">
            <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn-primary">
                Return to Catalog
            </a>
        </div>
    </div>
</c:if>

<c:if test="${empty confirmationName}">
    <div style="display: grid; grid-template-columns: 1fr 340px; gap: 24px;">
        <div class="card">
            <h2 style="margin: 0 0 16px 0; font-size: 18px;">Shipping &amp; Billing Details</h2>
            <form action="${pageContext.request.contextPath}/checkout" method="POST">
                <div class="form-group">
                    <label class="form-label" for="name">Full Name</label>
                    <input class="form-input" type="text" id="name" name="name" placeholder="John Doe" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input class="form-input" type="email" id="email" name="email" placeholder="john.doe@example.com" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="address">Delivery Address</label>
                    <input class="form-input" type="text" id="address" name="address" placeholder="123 Enterprise Avenue, Tech City" required>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 12px; font-size: 15px; margin-top: 8px;">
                    Confirm &amp; Place Order
                </button>
            </form>
        </div>

        <div class="card" style="height: fit-content;">
            <h2 style="margin: 0 0 16px 0; font-size: 18px;">Order Summary</h2>
            <c:choose>
                <c:when test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
                    <ul style="list-style: none; padding: 0; margin: 0 0 16px 0;">
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <li style="display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 13px;">
                                <span>${item.name}</span>
                                <strong><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="$" /></strong>
                            </li>
                        </c:forEach>
                    </ul>
                    <div style="border-top: 1px solid var(--border); padding-top: 12px; display: flex; justify-content: space-between; font-size: 16px;">
                        <strong>Total:</strong>
                        <strong style="color: var(--primary);">
                            <fmt:formatNumber value="${checkoutTotal}" type="currency" currencySymbol="$" />
                        </strong>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="color: var(--text-muted); font-size: 14px; margin: 0;">Your cart is empty.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</c:if>

<jsp:include page="footer.jsp" />
