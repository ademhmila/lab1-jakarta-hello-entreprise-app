# Lab 1: Hello Enterprise App — Solutions & Activities Report

**Course:** Jakarta EE Fundamentals & IntelliJ Setup  
**Student Project:** `Hello Enterprise App` (`jakartaee-course`)  
**Application Server:** WildFly 41.0.1.Final (`C:\servers\wildfly`)  
**Java Version:** JDK 27 (LTS Target: Java 17)  
**Specification:** Jakarta EE 11  

---

## 1. Summary of Completed Steps

1. **Step 1 — JDK Verification & Environment Setup:**
   - JDK 27 is installed at `C:\Program Files\Java\jdk-27`.
   - `JAVA_HOME` environment variable configured permanently.
2. **Step 2 — IntelliJ IDEA Ultimate:**
   - IntelliJ IDEA Ultimate 2026.2.3 detected and configured with Jakarta EE plugins.
3. **Step 3 & 4 — Application Server (WildFly):**
   - WildFly 41.0.1.Final extracted from `C:\Users\ADEM\Downloads\wildfly-41.0.1.Final.zip` directly to standard location: `C:\servers\wildfly`.
   - Sanity check executed and verified on port `8080` (HTTP) and `9990` (Management).
4. **Step 5 & 6 — Project & Servlets:**
   - Maven build configured with Jakarta EE 11 BOM dependency management.
   - `HelloServlet` implemented under package `com.course.lab1` mapped to `@WebServlet("/hello")`.
   - Documented `doGet` lifecycle and role above `HelloServlet`.
5. **Step 7 & 8 — Deployment & Verification:**
   - Packaged as `jakartaee-course.war` with context path `/jakartaee-course`.
   - Deployed to WildFly and verified responding with HTTP 200:
     - `http://localhost:8080/jakartaee-course/hello` ➔ `"Hello, Enterprise World!"`
     - `http://localhost:8080/jakartaee-course/goodbye` ➔ `"Goodbye, Enterprise World! See you in Lab 2."`
     - `http://localhost:8080/jakartaee-course/api/hello-world` ➔ `"Hello, World!"`
     - `http://localhost:8080/jakartaee-course/` ➔ Interactive HTML index page.

---

## 2. Chapter 1 Activities (Questions & Answers)

### Activity 1: Extend the Servlet
- **Task:** Add a second `@WebServlet` mapped to `/goodbye`, returning a different message.
- **Implementation:** `com.course.lab1.GoodbyeServlet` mapped to `/goodbye`.
- **Response:**
  ```text
  Goodbye, Enterprise World! See you in Lab 2.
  ```
- **Verification:** Both endpoints `/hello` and `/goodbye` deployed concurrently within the same WAR archive and verified responding correctly.

---

### Activity 2: Trace the Request (Debugger Observation)
- **Task:** Set a breakpoint inside `doGet`. Trigger the request from the browser. Step through it in the debugger. Write two or three sentences on what you observed.
- **Observation:**
  1. When triggering the URL `http://localhost:8080/jakartaee-course/hello`, the debugger pauses execution directly on the first line inside `HelloServlet.doGet()`.
  2. Examining the call stack reveals that the thread is managed by Undertow's worker thread pool (`default task-X`), showing how the container parses the HTTP request headers, constructs the `HttpServletRequestImpl` and `HttpServletResponseImpl` wrapper objects, and routes the request through a chain of container filters before dispatching it to our servlet.
  3. Inspecting the `resp.getWriter()` object shows an underlying buffered character stream; calling `println()` buffers the bytes, and the response is only finalized and sent over the socket when `doGet` returns or when the buffer flushes.

---

### Activity 3: Server Comparison (WildFly vs Payara)
- **Task:** Compare WildFly and Payara. Note differences in startup time or setup. Which would you pick for this course, and why?
- **Comparison:**
  - **Startup Time & Footprint:** WildFly starts exceptionally quickly (~14–20 seconds on initial cold start, faster on hot redeploy) thanks to its modular classloading architecture (`jboss-modules`) and on-demand service activation. Payara Community typically takes ~25–40 seconds to start because GlassFish/Payara initializes the OSGi container and services upfront.
  - **Architecture & Web Engine:** WildFly uses Undertow (a high-performance non-blocking/blocking hybrid web server), whereas Payara uses Grizzly.
  - **Tooling & Setup:** Both integrate cleanly with IntelliJ IDEA Ultimate and Maven. WildFly offers the lightweight `wildfly-maven-plugin` and zero-configuration auto-deployment by dropping files into `standalone/deployments/`.
  - **Selection for this course:** **WildFly** is the preferred choice for this course because of its fast iterative restart/redeploy times, lightweight memory footprint during local development, and clean alignment with modern Jakarta EE 11 specifications.

---

### Activity 4: Concept Map (Layered Architecture Diagram)
- **Task:** Redraw the layered diagram from Section 1.2 without looking back at it.

```text
+-----------------------------------------------------------------------+
|                              CLIENT                                   |
|                  (Browser / Mobile App / Postman / cURL)              |
+-----------------------------------+-----------------------------------+
                                    | HTTP Requests / JSON / HTML
                                    v
+-----------------------------------------------------------------------+
|                     APPLICATION SERVER (WildFly)                      |
|                                                                       |
|  +-----------------------------------------------------------------+  |
|  |             PRESENTATION / ROUTING LAYER (Undertow)             |  |
|  |   - Servlets (HelloServlet, GoodbyeServlet)                     |  |
|  |   - Filters, Listeners & Routing (@WebServlet)                  |  |
|  |   - REST Endpoints (Jakarta REST / JAX-RS)                      |  |
|  |   - Views (JSP, HTML5, Jakarta Faces)                           |  |
|  +--------------------------------+--------------------------------+  |
|                                   | Injects / Calls                   |
|                                   v                                   |
|  +-----------------------------------------------------------------+  |
|  |                    BUSINESS LOGIC LAYER                         |  |
|  |   - Enterprise Java Beans (EJB) / CDI Managed Beans             |  |
|  |   - Transaction Management (@Transactional / JTA)               |  |
|  |   - Security & Validation (Bean Validation, Elytron)            |  |
|  +--------------------------------+--------------------------------+  |
|                                   | Injects / Uses                    |
|                                   v                                   |
|  +-----------------------------------------------------------------+  |
|  |               DATA ACCESS & PERSISTENCE LAYER                   |  |
|  |   - Jakarta Persistence (JPA / Hibernate)                       |  |
|  |   - Entities & EntityManager                                    |  |
|  |   - DataSources & Connection Pooling                            |  |
|  +--------------------------------+--------------------------------+  |
+-----------------------------------|-----------------------------------+
                                    | SQL / JDBC
                                    v
+-----------------------------------------------------------------------+
|                          DATABASE LAYER                               |
|                     (PostgreSQL / MySQL / H2)                         |
+-----------------------------------------------------------------------+
```

---

### Activity 5: Reflection
- **Task:** Explain to a teammate who's never heard of Jakarta EE why the platform exists and what problem it solves versus writing a web server from scratch.
- **Reflection:**
  > Writing a web application from scratch requires manually implementing HTTP socket parsing, multi-threaded request multiplexing, SSL/TLS negotiation, session tracking, transaction rollback mechanisms, and database connection pooling—all before writing a single line of business code. 
  > **Jakarta EE** solves this by establishing a standardized, enterprise-grade specification where the application server (such as WildFly) provides all the infrastructure "heavy lifting" (security, lifecycle management, transactions, clustering, and data persistence) out of the box. 
  > Developers can focus 100% on domain logic using clean, declarative annotations (`@WebServlet`, `@Inject`, `@Entity`, `@Transactional`), and because Jakarta EE is a vendor-neutral standard, the application can run interchangeably on any compliant server without rewriting code.
