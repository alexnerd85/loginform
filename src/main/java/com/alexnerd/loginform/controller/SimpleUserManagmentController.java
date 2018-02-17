/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alexnerd.loginform.controller;

import java.util.Optional;
import javax.sql.DataSource;
import org.jooq.DSLContext;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("user")
public class SimpleUserManagmentController {

    @Autowired
    private DataSource dataSource;

    @RequestMapping(value = "checklogin", method = RequestMethod.GET)
    public boolean userExists(@RequestParam("username") String username) {
        //return inMemoryUserDetailsManager.userExists(username);

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        DSLContext create = DSL.using(SQLDialect.HSQLDB);

        String sql = create.select(DSL.field("USERNAME"))
                .from(DSL.table("USERS"))
                .where(DSL.field("USERNAME").eq(DSL.inline(username))).getSQL();

        int i = jdbcTemplate.queryForList(sql).size();

        if (i > 0) {
            return true;
        }

        return false;
    }

    @RequestMapping(value = "add", method = RequestMethod.GET)
    public boolean add(@RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("wage") Optional<Double> wage) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        DSLContext create = DSL.using(SQLDialect.HSQLDB);
        String sql1 = create
                .insertInto(DSL.table("USERS"), DSL.field("USERNAME"),
                        DSL.field("PASSWORD"), DSL.field("WAGE"))
                .values(DSL.inline(username), DSL.inline(password), 
                        DSL.inline(wage.orElse(0.0))).getSQL();
        String sql2 = create
                .insertInto(DSL.table("USER_ROLES"), DSL.field("USERNAME"),
                        DSL.field("ROLE"))
                .values(DSL.inline(username), DSL.inline("ROLE_USER")).getSQL();

        int i = jdbcTemplate.update(sql1);
        int j = jdbcTemplate.update(sql2);

        if (i > 0 && j > 0) {
            return true;
        }
        return false;

    }
}
