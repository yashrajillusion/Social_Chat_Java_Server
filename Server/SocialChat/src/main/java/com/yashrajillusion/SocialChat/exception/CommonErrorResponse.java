package com.yashrajillusion.SocialChat.exception;

import java.time.LocalDateTime;

public class CommonErrorResponse {
    private int status;
    private String message;
    private String details;
    private LocalDateTime timeStamp;

    public  CommonErrorResponse(){}

    public CommonErrorResponse(int status, String message, String details, LocalDateTime timeStamp) {
        super();
        this.status = status;
        this.message = message;
        this.details = details;
        this.timeStamp = timeStamp;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public LocalDateTime getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(LocalDateTime timeStamp) {
        this.timeStamp = timeStamp;
    }
}
