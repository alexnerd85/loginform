
package com.alexnerd.loginform.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.DispatcherServlet;

public class WebAppInitializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext sc) throws ServletException {
        AnnotationConfigWebApplicationContext rootContext = 
                new AnnotationConfigWebApplicationContext();
        rootContext.register(WebConfig.class);
        
        rootContext.setServletContext(sc);
        
        DelegatingFilterProxy filter = new DelegatingFilterProxy("springSecurityFilterChain");
        
        DispatcherServlet dispatcherServlet = new DispatcherServlet(rootContext);
        
        ServletRegistration.Dynamic registration = 
                sc.addServlet("dispatcherServlet", dispatcherServlet);
        sc.addFilter("springSecurityFilterChain", filter).
                addMappingForUrlPatterns(null, false, "/*");
        
        registration.setLoadOnStartup(1);
        
        registration.addMapping("/");
    }
    
}