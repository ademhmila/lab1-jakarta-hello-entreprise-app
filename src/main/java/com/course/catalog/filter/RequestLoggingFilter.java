package com.course.catalog.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * RequestLoggingFilter - Lab 2 Step 10 & Activity 3.
 * Intercepts all requests, measures execution time, logs URL and duration,
 * and prints a warning if request latency exceeds 50ms.
 */
@WebFilter("/*")
public class RequestLoggingFilter implements Filter {

    private static final long SLOW_REQUEST_THRESHOLD_MS = 50L;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        long start = System.currentTimeMillis();
        HttpServletRequest req = (HttpServletRequest) request;

        try {
            chain.doFilter(request, response);
        } finally {
            long duration = System.currentTimeMillis() - start;
            String logMessage = req.getMethod() + " " + req.getRequestURI() + " — " + duration + "ms";

            // Activity 3: Flag requests taking longer than 50ms
            if (duration > SLOW_REQUEST_THRESHOLD_MS) {
                System.err.println("[SLOW REQUEST WARNING] " + logMessage + " (Exceeded " + SLOW_REQUEST_THRESHOLD_MS + "ms threshold!)");
            } else {
                System.out.println("[INFO] " + logMessage);
            }
        }
    }
}
