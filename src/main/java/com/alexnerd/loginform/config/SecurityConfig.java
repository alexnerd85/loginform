package com.alexnerd.loginform.config;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@EnableWebSecurity
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private DataSource dataSource;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/resources/**", "/registration", "/checklogin", "/user/**").permitAll()
                .anyRequest().authenticated()
                .and().formLogin().loginPage("/login").failureUrl("/login?error")
                .usernameParameter("username").passwordParameter("password")
                .permitAll()
                .and().logout().logoutUrl("/logout").logoutSuccessUrl("/login?logout")
                .invalidateHttpSession(true).deleteCookies("JSESSIONID")
                .permitAll()
                .and()
                .sessionManagement().sessionFixation().changeSessionId()
                .and().csrf();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        //auth.userDetailsService(inMemoryUserDetailsManager());

        auth.jdbcAuthentication().dataSource(dataSource)
                .usersByUsernameQuery(
                        "select username,password, enabled from users where username=?")
                .authoritiesByUsernameQuery(
                        "select username, role from user_roles where username=?");

    }

}
