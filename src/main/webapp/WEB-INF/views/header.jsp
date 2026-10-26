<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise E-Commerce &middot; Lab 2</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --secondary: #64748b;
            --bg: #f8fafc;
            --surface: #ffffff;
            --text: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --success: #16a34a;
            --radius: 8px;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.07), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
        }
        * { box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg);
            color: var(--text);
            margin: 0;
            padding: 0;
            line-height: 1.5;
        }
        nav.navbar {
            background-color: var(--surface);
            border-bottom: 1px solid var(--border);
            padding: 0 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .nav-brand {
            font-size: 19px;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .nav-link {
            text-decoration: none;
            color: var(--text);
            font-weight: 500;
            font-size: 14px;
            transition: color 0.15s;
        }
        .nav-link:hover { color: var(--primary); }
        .badge {
            background-color: var(--primary);
            color: white;
            font-size: 11px;
            padding: 2px 7px;
            border-radius: 9999px;
            font-weight: 600;
            margin-left: 4px;
        }
        main.content-container {
            max-width: 1000px;
            margin: 32px auto;
            padding: 0 20px;
        }
        .card {
            background: var(--surface);
            border-radius: var(--radius);
            border: 1px solid var(--border);
            padding: 24px;
            box-shadow: var(--shadow);
            margin-bottom: 24px;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 9px 16px;
            font-size: 14px;
            font-weight: 500;
            border-radius: var(--radius);
            cursor: pointer;
            border: 1px solid transparent;
            text-decoration: none;
            transition: background-color 0.15s;
        }
        .btn-primary { background: var(--primary); color: white; }
        .btn-primary:hover { background: var(--primary-hover); }
        .btn-danger { background: #fee2e2; color: var(--danger); border-color: #fecaca; }
        .btn-danger:hover { background: #fecaca; }
        .btn-secondary { background: #f1f5f9; color: var(--text); border-color: var(--border); }
        .btn-secondary:hover { background: #e2e8f0; }
        .grid-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 20px;
            margin-top: 16px;
        }
        .product-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 18px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform 0.15s, box-shadow 0.15s;
        }
        .product-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.08);
        }
        .product-title {
            margin: 0 0 6px 0;
            font-size: 16px;
        }
        .product-title a {
            color: var(--text);
            text-decoration: none;
        }
        .product-title a:hover { color: var(--primary); }
        .product-category {
            font-size: 12px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 12px;
        }
        .product-price {
            font-size: 18px;
            font-weight: 700;
            color: #1e293b;
            margin: 0 0 16px 0;
        }
        .table-responsive { width: 100%; border-collapse: collapse; margin-top: 16px; }
        .table-responsive th, .table-responsive td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }
        .table-responsive th { background: #f8fafc; font-weight: 600; font-size: 13px; color: var(--text-muted); }
        .alert-success {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #065f46;
            padding: 16px;
            border-radius: var(--radius);
            margin-bottom: 20px;
        }
        .filter-bar {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            background: var(--surface);
            padding: 14px 18px;
            border-radius: var(--radius);
            border: 1px solid var(--border);
        }
        .filter-pill {
            padding: 6px 14px;
            border-radius: 9999px;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            background: #f1f5f9;
            color: var(--text-muted);
            transition: all 0.15s;
        }
        .filter-pill.active, .filter-pill:hover {
            background: var(--primary);
            color: white;
        }
        .form-group {
            margin-bottom: 16px;
        }
        .form-label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 6px;
        }
        .form-input {
            width: 100%;
            padding: 10px 14px;
            font-size: 14px;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            background: white;
        }
        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37,99,235,0.15);
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a class="nav-brand" href="${pageContext.request.contextPath}/catalog/products">
            🛍️ Enterprise Store
        </a>
        <ul class="nav-links">
            <li><a class="nav-link" href="${pageContext.request.contextPath}/catalog/products">Catalog</a></li>
            <li>
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                    Cart
                    <c:if test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
                        <span class="badge">${sessionScope.cart.size()}</span>
                    </c:if>
                </a>
            </li>
            <li><a class="nav-link" href="${pageContext.request.contextPath}/checkout">Checkout</a></li>
            <li><a class="nav-link" href="${pageContext.request.contextPath}/hello" style="color: var(--text-muted); font-size: 12px;">Lab 1 /hello</a></li>
        </ul>
    </nav>
    <main class="content-container">
