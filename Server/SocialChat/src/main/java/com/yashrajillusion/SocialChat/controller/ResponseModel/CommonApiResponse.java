package com.yashrajillusion.SocialChat.controller.ResponseModel;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommonApiResponse<T> {
    private int statusCode;
    private String message;
    private T data;
}
