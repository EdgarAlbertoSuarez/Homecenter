package com.siiv.springboot.app.cliente;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@EnableEurekaClient
@SpringBootApplication
public class SpringbootServicioClienteApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringbootServicioClienteApplication.class, args);
	}

}
