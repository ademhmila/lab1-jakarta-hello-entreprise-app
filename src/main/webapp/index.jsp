<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lab 1: Hello Enterprise App</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }
        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            max-width: 650px;
            width: 100%;
            padding: 32px;
            border: 1px solid #e2e8f0;
        }
        h1 {
            color: #0f172a;
            font-size: 24px;
            margin-top: 0;
            margin-bottom: 8px;
        }
        .subtitle {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 24px;
        }
        .status-badge {
            display: inline-flex;
            align-items: center;
            background: #dcfce7;
            color: #166534;
            padding: 4px 12px;
            border-radius: 9999px;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 20px;
        }
        .status-dot {
            width: 8px;
            height: 8px;
            background: #22c55e;
            border-radius: 50%;
            margin-right: 6px;
        }
        .endpoint-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .endpoint-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 16px;
            background: #f1f5f9;
            border-radius: 8px;
            margin-bottom: 12px;
            transition: background 0.2s;
        }
        .endpoint-item:hover {
            background: #e2e8f0;
        }
        .endpoint-link {
            font-family: monospace;
            font-size: 15px;
            font-weight: 600;
            color: #2563eb;
            text-decoration: none;
        }
        .endpoint-link:hover {
            text-decoration: underline;
        }
        .endpoint-desc {
            font-size: 12px;
            color: #64748b;
            background: #ffffff;
            padding: 4px 8px;
            border-radius: 4px;
            border: 1px solid #cbd5e1;
        }
        .meta-info {
            margin-top: 24px;
            padding-top: 16px;
            border-top: 1px solid #e2e8f0;
            font-size: 13px;
            color: #64748b;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="status-badge">
            <span class="status-dot"></span> Jakarta EE 11 Running on WildFly 41
        </div>
        <h1>Lab 1: Hello Enterprise App</h1>
        <p class="subtitle">Companion to Chapter 1 &middot; Jakarta EE Fundamentals &amp; IntelliJ Setup</p>

        <h3>Verified Servlets &amp; Endpoints</h3>
        <ul class="endpoint-list">
            <li class="endpoint-item">
                <a class="endpoint-link" href="hello">/hello</a>
                <span class="endpoint-desc">Step 6: HelloServlet</span>
            </li>
            <li class="endpoint-item">
                <a class="endpoint-link" href="goodbye">/goodbye</a>
                <span class="endpoint-desc">Activity 1: GoodbyeServlet</span>
            </li>
            <li class="endpoint-item">
                <a class="endpoint-link" href="api/hello-world">/api/hello-world</a>
                <span class="endpoint-desc">JAX-RS REST Endpoint</span>
            </li>
        </ul>

        <div class="meta-info">
            <strong>Server:</strong> WildFly 41.0.1.Final (Local: <code>C:\servers\wildfly</code>)<br>
            <strong>JDK:</strong> OpenJDK 27 &middot; <strong>Spec:</strong> Jakarta EE 11
        </div>
    </div>
</body>
</html>
