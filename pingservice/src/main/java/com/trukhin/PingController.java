package com.trukhin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PingController {

	private static final Logger logger = LoggerFactory.getLogger(PingController.class);

	@Autowired
	private PingService pingService;

	@GetMapping("/ping")
	public String ping() {
		return "pong";
	}

	@GetMapping("/pingPetClinic")
	public String pingPetClinic() {
		String result = pingService.pingPetClinic();
		logger.info("Result of pinging PetClinic: {}", result);
		return result;
	}
}
