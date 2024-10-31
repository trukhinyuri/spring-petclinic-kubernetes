package com.trukhin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PingService {

	private static final Logger logger = LoggerFactory.getLogger(PingService.class);

	private static final String PETCLINIC_URL = "http://spring-petclinic:8080";

	public String pingPetClinic() {
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> responseEntity = restTemplate.getForEntity(PETCLINIC_URL, String.class);
            int statusCode = responseEntity.getStatusCode().value();
            logger.info("Pinged PetClinic successfully with status code: {}", statusCode);
			return "Pinged PetClinic successfully with status code: " + statusCode;
		} catch (Exception e) {
			logger.error("Failed to ping PetClinic: {}", e.getMessage());
			return "Failed to ping PetClinic: " + e.getMessage();
		}
	}

	@Scheduled(fixedRate = 1000) // Запускается каждые 1000 мс (1 секунда)
	public void scheduledPing() {
		logger.info(pingPetClinic());
	}
}
