# Jakarta EE Enterprise Application (Lab 1 & Lab 2)

**Course:** Companion to Chapter 1 & 2 &middot; Jakarta EE Fundamentals, IntelliJ Setup, Servlets, JSP & JSTL  
**Author:** Adem Hmila  
**Application Server:** WildFly 41.0.1.Final  
**Java Version:** JDK 27 (Target: Java 17 LTS)  
**Specification:** Jakarta EE 11  

---

## 📌 Architecture & Modules

### 🛒 Lab 2: Multi-Page E-Commerce Catalog with JSP & Filters
- **Model / DTO Pattern:**
  - `ProductDTO`: Data holder for catalog products (`id`, `name`, `category`, `price`).
  - `ProductCatalog`: In-memory data repository with real-time category aggregation.
- **Routing & Servlets:**
  - `ProductListServlet` (`/catalog/products`): Dynamic catalog listing with real-time category filtering.
  - `ProductDetailServlet` (`/catalog/product?id=X`): Single product view with validation.
  - `CartServlet` (`/cart`, `/cart/add`, `/cart/remove`): Session-based shopping cart leveraging the Post/Redirect/Get (PRG) pattern with individual item removal support.
  - `CheckoutServlet` (`/checkout`): Multi-field order placement form that invalidates/clears session cart upon confirmation.
- **Modular Presentation (JSP & JSTL):**
  - Protected under `/WEB-INF/views/` to enforce MVC separation.
  - Shared components: `header.jsp` (with dynamic cart item indicator badge) & `footer.jsp`.
  - Pages: `products.jsp`, `product-detail.jsp`, `cart.jsp`, `checkout.jsp`.
  - Modern, responsive styling with clean UI components.
- **Interceptors & Filters:**
  - `RequestLoggingFilter` (`/*`): Calculates request latency in milliseconds and raises warnings for slow requests (>50ms).
  - `AuthenticationFilter` (`/cart/*`): Security foundation filter for e-commerce paths.

### ⚡ Lab 1: Hello Enterprise App (Foundation)
- `HelloServlet` (`/hello`): Entry point servlet with lifecycle explanations.
- `GoodbyeServlet` (`/goodbye`): Extended servlet endpoint.
- `HelloResource` (`/api/hello-world`): JAX-RS REST endpoint.

---

## 🚀 Application Endpoints
Once deployed on WildFly (`standalone`):
- `http://localhost:8080/jakartaee-course/` — Portal Dashboard
- `http://localhost:8080/jakartaee-course/catalog/products` — Product Catalog
- `http://localhost:8080/jakartaee-course/catalog/products?category=Electronics` — Filtered Catalog
- `http://localhost:8080/jakartaee-course/catalog/product?id=1` — Product Detail Page
- `http://localhost:8080/jakartaee-course/cart` — Shopping Cart
- `http://localhost:8080/jakartaee-course/checkout` — Checkout Form
- `http://localhost:8080/jakartaee-course/hello` — Lab 1 Hello Servlet
- `http://localhost:8080/jakartaee-course/goodbye` — Lab 1 Goodbye Servlet

---

## 📄 Activity Reports
- **Lab 1 Report:** [LAB_REPORT_ACTIVITIES.md](LAB_REPORT_ACTIVITIES.md)
- **Lab 2 Report:** [LAB2_REPORT_ACTIVITIES.md](LAB2_REPORT_ACTIVITIES.md)
