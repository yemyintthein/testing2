package com.lithan.ac.springboot_car_portal_demo;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import com.lithan.ac.springboot_car_portal_demo.daos.CarRepository;
import com.lithan.ac.springboot_car_portal_demo.entities.Car;
import com.lithan.ac.springboot_car_portal_demo.services.CarService;

@SpringBootTest
class SpringbootCarPortalDemoApplicationTests {

	@Test
	void contextLoads() {
	}
	
	@Mock
	private CarRepository car_repo;
	
	private CarService car_service;
	
	@BeforeEach
	void setup() {
		this.car_service=new CarService(this.car_repo);
		
	}
	
	//Unit Testing for car Service
	@Test
	void TestGetAllCar() {
		car_service.getAllCars();
		verify(car_repo).findAll();
	}
	
	
	@Test
	void TestGetAllCar_count() {
		List<Car> listcars=car_service.getAllCars();
		int cars=listcars.size();
		System.out.println("Car count is "+cars);
		assertEquals(1, cars);
		
	}
	
	
	
	
	
	


}
