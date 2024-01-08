package com.lithan.ac.springboot_car_portal_demo.daos;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lithan.ac.springboot_car_portal_demo.entities.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	
    User findByUserName(String name);
}
