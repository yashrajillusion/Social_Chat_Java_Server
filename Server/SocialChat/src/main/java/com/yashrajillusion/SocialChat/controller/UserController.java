package com.yashrajillusion.SocialChat.controller;

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

    @GetMapping("/user")
    public ResponseEntity<List<User>> getAllUser(){
        List<User> users = userService.getAllUsers();
        return new ResponseEntity<List<User>>(users, HttpStatus.OK);
    }

    @GetMapping("/user/{id}")
    public ResponseEntity<User> getUserById(@PathVariable("id") String id) throws Exception {
        User user = userService.findByUserId(UUID.fromString(id)).orElseThrow(()-> new Exception("User not exist"));
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    @PostMapping("/user")
    public ResponseEntity<User> createUser(@RequestBody User user) throws Exception {
        User new_user = userService.register(user);
        return new ResponseEntity<User>(new_user, HttpStatus.CREATED);
    }

    @PutMapping("/user/{id}")
    public ResponseEntity<User> updateUser(@PathVariable("id") String id, @RequestBody User user) throws Exception {
        User userData = userService.findByUserId(UUID.fromString(id)).orElseThrow(()-> new Exception("User not exist"));
        if(user.getFirstName() != null) userData.setFirstName(user.getFirstName());
        if(user.getLastName() != null) userData.setLastName(user.getLastName());
        if(user.getPhone() != null) userData.setPhone(user.getPhone());
        if(user.getAvatarUrl() != null) userData.setAvatarUrl(user.getAvatarUrl());
        if(user.getPassword() != null) userData.setPassword(user.getPassword());
        return new ResponseEntity<User>(userService.saveUser(userData), HttpStatus.OK);
    }

}
