<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jakarta EE Enterprise App &middot; Lab 1 &amp; Lab 2</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: #f8fafc;
            color: #0f172a;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }
        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08);
            max-width: 700px;
            width: 100%;
            padding: 32px;
            border: 1px solid #e2e8f0;
        }
        h1 { margin: 0 0 8px 0; font-size: 24px; }
        .subtitle { color: #64748b; font-size: 14px; margin-bottom: 24px; }
        .badge-success {
            display: inline-flex;
            align-items: center;
            background: #dcfce7;
            color: #166534;
            padding: 4px 12px;
            border-radius: 9999px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
        }
        .section-box {
            background: #f1f5f9;
            border-radius: 8px;
            padding: 18px;
            margin-bottom: 18px;
        }
        .section-title {
            font-size: 16px;
            font-weight: 700;
            margin: 0 0 10px 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .link-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        .btn-link {
            display: block;
            background: white;
            padding: 10px 14px;
            border-radius: 6px;
            border: 1px solid #cbd5e1;
            text-decoration: none;
            color: #2563eb;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.15s;
        }
        .btn-link:hover {
            border-color: #2563eb;
            background: #eff6ff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="badge-success">
            ● Jakarta EE 11 Enterprise Platform Active
        </div>
        <h1>Enterprise Application Portal</h1>
        <p class="subtitle">Multi-tier E-Commerce architecture running on WildFly 41</p>

        <!-- Lab 2 Section -->
        <div class="section-box" style="background: #eff6ff; border: 1px solid #bfdbfe;">
            <div class="section-title" style="color: #1d4ed8;">
                <span>🛒 Lab 2: Multi-Page E-Commerce Catalog</span>
                <span style="font-size: 12px; background: #2563eb; color: white; padding: 2px 8px; border-radius: 4px;">Active</span>
            </div>
            <p style="font-size: 13px; color: #475569; margin: 0 0 12px 0;">
                Servlets, JSP &amp; JSTL views, Session-based Cart, Filters, and MVC separation.
            </p>
            <div class="link-grid">
                <a class="btn-link" href="${pageContext.request.contextPath}/catalog/products">
                    📦 Product Catalog &rarr;
                </a>
                <a class="btn-link" href="${pageContext.request.contextPath}/cart">
                    🛒 Shopping Cart &rarr;
                </a>
                <a class="btn-link" href="${pageContext.request.contextPath}/checkout">
                    💳 Checkout Form &rarr;
                </a>
                <a class="btn-link" href="${pageContext.request.contextPath}/catalog/products?category=Electronics">
                    ⚡ Filter Electronics &rarr;
                </a>
            </div>
        </div>

        <!-- Lab 1 Section -->
        <div class="section-box">
            <div class="section-title">
                <span>⚡ Lab 1: Hello Enterprise App</span>
                <span style="font-size: 12px; color: #64748b;">Foundation</span>
            </div>
            <div class="link-grid">
                <a class="btn-link" href="${pageContext.request.contextPath}/hello">
                    /hello (HelloServlet)
                </a>
                <a class="btn-link" href="${pageContext.request.contextPath}/goodbye">
                    /goodbye (GoodbyeServlet)
                </a>
                <a class="btn-link" href="${pageContext.request.contextPath}/api/hello-world">
                    /api/hello-world (JAX-RS)
                </a>
            </div>
        </div>
    </div>
</body>
</html>
