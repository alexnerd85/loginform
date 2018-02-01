/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alexnerd.loginform.controller;

import com.alexnerd.loginform.data.User;
import java.util.ArrayList;
import java.util.Optional;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("user")
public class SimpleSecurityController {
    
    @Autowired
    private DataSource dataSource;

    private final InMemoryUserDetailsManager inMemoryUserDetailsManager;

    @Autowired
    public SimpleSecurityController(InMemoryUserDetailsManager inMemoryUserDetailsManager) {
       this.inMemoryUserDetailsManager = inMemoryUserDetailsManager;
    }

    @RequestMapping(value = "checklogin", method = RequestMethod.GET)
    public boolean userExists(@RequestParam("username") String username ) {
        return inMemoryUserDetailsManager.userExists(username);
    }

    @RequestMapping(value="add", method = RequestMethod.GET)
    public boolean add(@RequestParam("username") String username,
                      @RequestParam("password") String password,
                      @RequestParam("wage") Optional<Double> wage) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        int i = jdbcTemplate.update(
                "INSERT INTO USER (USERNAME, PASSWORD, WAGE) VALUES('"+ username+"', '" + password +"', '"+ wage.orElse(0.0)+"');");
        if(i>0){
            inMemoryUserDetailsManager.createUser(new User(username, password, new ArrayList<GrantedAuthority>()));
            return true;
        }
        return false;
    }
}