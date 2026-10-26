package com.course.lab1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * HelloServlet - Entry point for Lab 1 (Step 6 & Step 9).
 *
 * [Explanation of doGet - Step 9.3]:
 * - What doGet does:
 *   doGet processes incoming HTTP GET requests received from web clients.
 *   It accesses the HttpServletResponse output stream (via resp.getWriter())
 *   and sends the textual response "Hello, Enterprise World!" back to the client.
 *
 * - When it runs:
 *   It is executed by the Servlet container (Undertow in WildFly) whenever an HTTP GET request
 *   targets the "/hello" URL pattern mapped by the @WebServlet annotation (e.g., http://localhost:8080/jakartaee-course/hello).
 */
@WebServlet(name = "helloServlet", urlPatterns = {"/hello"})
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/plain;charset=UTF-8");
        resp.getWriter().println("Hello, Enterprise World!");
    }
}
