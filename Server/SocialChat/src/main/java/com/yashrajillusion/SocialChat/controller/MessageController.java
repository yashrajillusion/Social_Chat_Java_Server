package com.yashrajillusion.SocialChat.controller;

import com.yashrajillusion.SocialChat.controller.ResponseModel.CommonApiResponse;
import com.yashrajillusion.SocialChat.model.Chat;
import com.yashrajillusion.SocialChat.model.Message;
import com.yashrajillusion.SocialChat.model.User;
import com.yashrajillusion.SocialChat.service.ChatService;
import com.yashrajillusion.SocialChat.service.MessageService;
import com.yashrajillusion.SocialChat.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
public class MessageController {
    @Autowired
    private MessageService messageService;

    @Autowired
    private ChatService chatService;

    @Autowired
    private UserService userService;

    @PostMapping("/message")
    public ResponseEntity<CommonApiResponse<Message>> createChat(@RequestBody Message message) throws Exception {
        Chat chat = chatService.findByChatId(UUID.fromString(message.getChatId())).orElseThrow(()-> new Exception("Chat not found"));
        User user = userService.findByUserId(UUID.fromString(message.getSenderId())).orElseThrow(()-> new Exception("User not exist"));
        message.setChat(chat);
        message.setSender(user);
        Message message_data = messageService.createMessage(message);
        chat.setLastMessage(message_data);
        chatService.createChat(chat);
        return new ResponseEntity<>(new CommonApiResponse<>(
                201, "Message send successfully", message_data
        ), HttpStatus.CREATED);
    }

    @GetMapping("/message/{id}")
    public ResponseEntity<CommonApiResponse<List<Message>>> getAllMessageById(@PathVariable("id") String id) throws Exception {
        List<Message> message = messageService.findMessageByChatId(UUID.fromString(id));
        return new ResponseEntity<>(new CommonApiResponse<List<Message>>(
                200, "Get all Message fetched successfully", message
        ), HttpStatus.CREATED);
    }
}
