# Lab 2: Multi-Page E-Commerce Catalog with JSP & Filters — Solutions & Activities Report

**Course:** Companion to Chapter 2 &middot; Web Foundations — Servlets, JSP & JSTL  
**Project:** `Hello Enterprise App` (`jakartaee-course`)  
**Application Server:** WildFly 41.0.1.Final  
**Java Specification:** Jakarta EE 11  

---

## 1. Summary of Implemented Features

### Part A — Servlets & Routing
1. **Model & DTO:**
   - [ProductDTO.java](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/java/com/course/catalog/model/ProductDTO.java): Encapsulates `id`, `name`, `category`, and `price`.
   - [ProductCatalog.java](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/java/com/course/catalog/model/ProductCatalog.java): Static in-memory catalog holding sample products across Electronics, Books, and Clothing.
2. **Servlets:**
   - [ProductListServlet.java](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/java/com/course/catalog/web/ProductListServlet.java) (`@WebServlet("/catalog/products")`): Handles category filtering and forwards to `/WEB-INF/views/products.jsp`.
   - [ProductDetailServlet.java](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/java/com/course/catalog/web/ProductDetailServlet.java) (`@WebServlet("/catalog/product")`): Loads product by ID and forwards to `/WEB-INF/views/product-detail.jsp`.
   - [CartServlet.java](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/java/com/course/catalog/web/CartServlet.java) (`@WebServlet({"/cart", "/cart/add", "/cart/remove"})`): Session-based cart with Post/Redirect/Get pattern for both add and item removal.
   - [CheckoutServlet.java](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/java/com/course/catalog/web/CheckoutServlet.java) (`@WebServlet("/checkout")`): Manages checkout form submission, clears session cart, and presents order confirmation.

### Part B — JSP Views with JSTL
1. **JSTL Taglibs:** Integrated `jakarta.tags.core` (`c`) and `jakarta.tags.fmt` (`fmt`).
2. **Modular Architecture:**
   - [header.jsp](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/webapp/WEB-INF/views/header.jsp): Responsive navigation bar with dynamic cart item count indicator.
   - [footer.jsp](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/webapp/WEB-INF/views/footer.jsp): Common page wrapper.
   - [products.jsp](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/webapp/WEB-INF/views/products.jsp): Category-filtered grid with formatted currency.
   - [product-detail.jsp](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/webapp/WEB-INF/views/product-detail.jsp): Product details and Add-to-Cart form.
   - [cart.jsp](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/webapp/WEB-INF/views/cart.jsp): Cart overview with line-item deletion and subtotal calculation.
   - [checkout.jsp](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/webapp/WEB-INF/views/checkout.jsp): Customer details form and dynamic confirmation banner.

### Part C — Filters
1. [RequestLoggingFilter.java](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/java/com/course/catalog/filter/RequestLoggingFilter.java) (`@WebFilter("/*")`): Intercepts all requests and calculates execution duration in milliseconds.
2. [AuthenticationFilter.java](file:///C:/Users/ADEM/IdeaProjects/Hello%20Enterprise%20App/src/main/java/com/course/catalog/filter/AuthenticationFilter.java) (`@WebFilter("/cart/*")`): Foundation filter for protecting cart actions.

---

## 2. Chapter 2 Activities (Detailed Solutions)

### Activity 1: Add a Category Filter Dropdown / Links
- **Implementation:**
  - Extended `products.jsp` with interactive category filter links (`All`, `Electronics`, `Books`, `Clothing`).
  - `ProductListServlet` checks `req.getParameter("category")`; if provided, it filters the product stream using `.filter(p -> p.getCategory().equalsIgnoreCase(category))` before forwarding to `products.jsp`.
- **Result:**
  - Browsing `/catalog/products?category=Electronics` isolates only electronic devices.
  - Active category is visually highlighted.

---

### Activity 2: Add a "Remove from Cart" Action
- **Implementation:**
  - Registered `/cart/remove` inside `@WebServlet({"/cart", "/cart/add", "/cart/remove"})` in `CartServlet`.
  - Added a `<form action="${pageContext.request.contextPath}/cart/remove" method="POST">` with `productId` inside each cart row in `cart.jsp`.
  - The servlet locates the product in the session list, removes the single item instance via `Iterator.remove()`, updates the session attribute, and performs a `sendRedirect` back to `/cart`.
- **Result:**
  - Items can be individually removed from the session cart without unintended multi-removals.

---

### Activity 3: Time Your Filter (> 50ms Warning)
- **Implementation:**
  - In `RequestLoggingFilter`:
    ```java
    long duration = System.currentTimeMillis() - start;
    if (duration > 50L) {
        System.err.println("[SLOW REQUEST WARNING] " + req.getMethod() + " " + req.getRequestURI() + " — " + duration + "ms (Exceeded 50ms threshold!)");
    } else {
        System.out.println("[INFO] " + req.getMethod() + " " + req.getRequestURI() + " — " + duration + "ms");
    }
    ```
- **Observation:**
  - Normal in-memory catalog requests complete in ~1–8ms.
  - Artificially delayed requests trigger the `[SLOW REQUEST WARNING]` banner in the server console output, demonstrating how filters act as proactive performance interceptors across an entire web application.

---

### Activity 4: Trace a Full Request (Filter → Servlet → JSP)
- **Breakpoints:**
  1. `RequestLoggingFilter.doFilter()` line before `chain.doFilter()`.
  2. `ProductListServlet.doGet()`.
  3. `products.jsp` during scriptlet / tag evaluation.
  4. `RequestLoggingFilter.doFilter()` line after `chain.doFilter()`.
- **Observed Execution Order (3 Sentences):**
  1. The container first invokes `RequestLoggingFilter`, where request timestamping and pre-processing occurs before delegating control via `chain.doFilter()`.
  2. Next, the request reaches `ProductListServlet.doGet()`, which processes request parameters, queries the model (`ProductCatalog`), attaches data attributes (`req.setAttribute()`), and dispatches to the JSP view via `forward()`.
  3. Finally, control passes to the compiled `products.jsp` servlet to evaluate EL expressions and render HTML, after which the call stack unwinds back to `RequestLoggingFilter` to compute the total elapsed duration.

---

### Activity 5: Reflection (Why `/WEB-INF/views/*.jsp` Cannot Be Requested by URL)
- **Reflection:**
  > Files located under `/WEB-INF` are explicitly protected by the Servlet specification and cannot be directly accessed by client HTTP requests (attempting to do so yields an HTTP 404 error).
  > This is a **deliberate architectural design choice, not a bug**, enforcing the Model-View-Controller (MVC) pattern.
  > If clients could directly request JSPs, the page would execute without the backing Servlet having populated required request attributes (such as `${products}` or `${product}`), resulting in blank pages, `NullPointerException`s, or bypassed security filters. 
  > Requiring all traffic to pass through the front-facing Servlet first ensures that authentication, validation, and data retrieval are guaranteed to execute before the presentation layer renders.
