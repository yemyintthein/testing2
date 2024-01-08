package com.lithan.ac.springboot_car_portal_demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.introspect.TypeResolutionContext.Empty;
import com.lithan.ac.springboot_car_portal_demo.entities.Car;
import com.lithan.ac.springboot_car_portal_demo.entities.CarBidding;
import com.lithan.ac.springboot_car_portal_demo.entities.User;
import com.lithan.ac.springboot_car_portal_demo.services.BidService;
import com.lithan.ac.springboot_car_portal_demo.services.CarService;
import com.lithan.ac.springboot_car_portal_demo.services.UserService;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Controller
public class CarController {

	private static final String UPLOAD_DIRECTORY = "/images";
	private static Logger logger = LoggerFactory.getLogger(CarController.class);

	@Autowired
	private CarService carService;

	@Autowired
	private BidService carbidService;

	@Autowired
	private UserService userService;

	@GetMapping("/")
	public String handleRootRequest(Model model) {
		return "redirect:cars";
	}

	// For Display all car
	@GetMapping("cars")
	public String viewCars(Model model) {
		List<Car> cars = carService.getAllCars();
		if (!CollectionUtils.isEmpty(cars)) {
			model.addAttribute("cars", cars);
		}
		return "view_cars";
	}

	// For display new car FORM
	@GetMapping("new_car")
	public String newUserForm(Map<String, Object> model) {
		System.out.println("To show add new car page");
		Car car = new Car();
		model.put("car", car);
		return "new_car";
	}

	// For saving new car
	@PostMapping("cars")
	public String saveCar(Car car, @RequestParam("file") MultipartFile  file, HttpSession session, Model model) throws Exception{

		System.out.println("get Car Name");
		// Get the file name & set the file name
		String carphotoname = file.getOriginalFilename();
		System.out.println("Car photo name is "+carphotoname);
		
		if(carphotoname != null && !carphotoname.trim().isEmpty()) {
		car.setCarphoto(carphotoname);

		// Upload Car Photo
		ServletContext context = session.getServletContext();
		String path = context.getRealPath(UPLOAD_DIRECTORY);
		String filename = file.getOriginalFilename();

		System.out.println(path + " " + filename);
		byte[] bytes = file.getBytes();
		BufferedOutputStream stream = new BufferedOutputStream(
				new FileOutputStream(new File(path + File.separator + filename)));
		stream.write(bytes);
		stream.flush();
		stream.close();

		System.out.println("File successfully saved!");
		// End Upload Car Photo
		}
		//end of file upload
		
		System.out.println("Save & Update new car");
		carService.saveCar(car);
		return "redirect:cars";
	}

	/* For Bidding */

	// To display car detail
	@GetMapping("car_detail")
	public ModelAndView viewCar(@RequestParam long id) {
		ModelAndView mav = new ModelAndView("car_detail");
		Car car = carService.get(id);
		mav.addObject("car", car);
		mav.addObject("bidinfo", carbidService.listBidInfo((car)));
		return mav;
	}

	// Save the bid price to car bidding table
	@PostMapping("car_detail")
	public String saveBit(@RequestParam(value = "id", required = false) Long id,
			@RequestParam("bitprice") String bitprice, Model model) {

		// To post the bid information into the database
		// Get User name
		String uname = "";
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			uname = ((UserDetails) principal).getUsername();

		} else {
			uname = principal.toString();
		}

		Long carid = id;

		Car car = carService.get(id);
		User user = userService.getUserByName(uname);

		Date cur_time = new Date();

		CarBidding carBitInfo = new CarBidding();
		carBitInfo.setBidderName(uname);
		carBitInfo.setBidderPrice(bitprice);

		carBitInfo.setCar(car);
		carBitInfo.setUser(user);

		carBitInfo.setBid_date_time(cur_time);

		logger.debug("Car Bidder Price:{}, Car ID: {}", carBitInfo.getBidderPrice(), carBitInfo.getId(),
				carBitInfo.getBidderName(), carBitInfo.getCar());

		CarBidding savedCar = carbidService.save(carBitInfo);

		model.addAttribute("car", car);
		model.addAttribute("bidinfo", carbidService.listBidInfo(car));

		return "car_detail";
	}
	/* End For Bidding */

	// To display update FORM with old data
	@GetMapping("edit")
	public String editCarForm(@RequestParam long id, Model model) {
		System.out.println("Update car controller method");
		Car car = carService.get(id);
		model.addAttribute("car", car);
		return "new_car";
	}

	// Delete process
	@GetMapping("delete")
	public String deleteCar(@RequestParam long id) {
		carService.delete(id);
		return "redirect:/cars";
	}

	@GetMapping("search")
	public ModelAndView search(@RequestParam String keyword) {
		List<Car> result = carService.search(keyword);
		ModelAndView mav = new ModelAndView("search_car_results");
		mav.addObject("keyword", keyword);
		mav.addObject("search_cars", result);
		return mav;
	}

}
