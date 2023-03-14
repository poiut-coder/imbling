package com.imbling;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan(basePackages = { "com.imbling.entity" })
public class ImblingApplication {

	public static void main(String[] args) {
		SpringApplication.run(ImblingApplication.class, args);
	}

}
