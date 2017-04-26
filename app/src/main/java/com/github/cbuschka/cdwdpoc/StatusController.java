package com.github.cbuschka.cdwdpoc;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StatusController
{

	@RequestMapping(value = "/status", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<?> getStatus()
	{
		return new ResponseEntity<Object>("{\"message\":\"Ok.\"}", HttpStatus.OK);
	}
}
