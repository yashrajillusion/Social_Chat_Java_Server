package com.yashrajillusion.SocialChat.controller;

import com.yashrajillusion.SocialChat.controller.ResponseModel.CommonApiResponse;
import com.yashrajillusion.SocialChat.model.User;
import com.yashrajillusion.SocialChat.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping("/user/login")
    public ResponseEntity<CommonApiResponse<User>> login(@RequestBody User user) throws Exception{
        User current_user = userService.findByEmail(user.getEmail()).orElseThrow(()-> new Exception("Email not found"));
        if(!current_user.getPassword().equals(user.getPassword())) throw new Exception("Password is incorrect");
        return new ResponseEntity<>(new CommonApiResponse<User>(
                200, "Login Successful", current_user
        ), HttpStatus.OK);
    }

    @GetMapping("/user")
    public ResponseEntity<CommonApiResponse<List<User>>> getAllUser(){
        List<User> users = userService.getAllUsers();
        return new ResponseEntity<>(new CommonApiResponse<List<User>>(
                200, "get all user fetched successful", users
        ), HttpStatus.OK);
    }

    @GetMapping("/user/{id}")
    public ResponseEntity<CommonApiResponse<User>> getUserById(@PathVariable("id") String id) throws Exception {
        User user = userService.findByUserId(UUID.fromString(id)).orElseThrow(()-> new Exception("User not exist"));
        return new ResponseEntity<>( new CommonApiResponse<User>(
                200, "user by id fetched successful", user
        ), HttpStatus.OK);
    }

    @PostMapping("/user")
    public ResponseEntity<CommonApiResponse<User>> createUser(@RequestBody User user) throws Exception {
        User new_user = userService.register(user);
        return new ResponseEntity<>(new CommonApiResponse<User>(
                201, "User created successfully", new_user
        ), HttpStatus.CREATED);
    }

    @PutMapping("/user/{id}")
    public ResponseEntity<CommonApiResponse<User>> updateUser(@PathVariable("id") String id, @RequestBody User user) throws Exception {
        User userData = userService.findByUserId(UUID.fromString(id)).orElseThrow(()-> new Exception("User not exist"));
        if(user.getFirstName() != null) userData.setFirstName(user.getFirstName());
        if(user.getLastName() != null) userData.setLastName(user.getLastName());
        if(user.getPhone() != null) userData.setPhone(user.getPhone());
        if(user.getAvatarUrl() != null) userData.setAvatarUrl(user.getAvatarUrl());
        if(user.getPassword() != null) userData.setPassword(user.getPassword());
        return new ResponseEntity<>(new CommonApiResponse<User>(
                200, "User got updated", userService.saveUser(userData)
        ), HttpStatus.OK);
    }

}
