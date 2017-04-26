package com.github.cbuschka.cdwdpoc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@EnableAutoConfiguration
@Configuration
@ComponentScan
public class WebappMain extends SpringBootServletInitializer
{
	public static void main(String[] args)
	{
		SpringApplication app = new SpringApplication(WebappMain.class);
		app.run(args);
	}
}
