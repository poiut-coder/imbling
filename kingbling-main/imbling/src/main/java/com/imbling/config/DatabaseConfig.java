package com.imbling.config;

import javax.sql.DataSource;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration // -> servlet-context.xml 과 같은 설정파일 클래스로 구현
@PropertySource("classpath:/application.properties")
public class DatabaseConfig {
	
	@Bean
	@ConfigurationProperties(prefix = "spring.datasource.hikari")
	public HikariConfig hikariConfig() {
		
		HikariConfig config = new HikariConfig();
		
		return config;
	}
	
	@Bean // --> servlet-context.xml과 같은 설정 파일의 <bean에 해당
	public DataSource dataSource() {		
		HikariDataSource dataSource = new HikariDataSource(hikariConfig());
		
		return dataSource;
	}
	
	////////////////////////////////////////

	

}
















