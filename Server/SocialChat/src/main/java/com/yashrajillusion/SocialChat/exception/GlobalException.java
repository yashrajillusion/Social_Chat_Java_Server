package com.yashrajillusion.SocialChat.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.time.LocalDateTime;

@ControllerAdvice
public class GlobalException {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<CommonErrorResponse> otherExceptionHandler(Exception se, WebRequest req){
        CommonErrorResponse err = new CommonErrorResponse();
        err.setTimeStamp(LocalDateTime.now());
        err.setMessage(se.getMessage());
        err.setDetails(req.getDescription(false));
        err.setStatus("400");

        return new ResponseEntity<CommonErrorResponse>(err, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
