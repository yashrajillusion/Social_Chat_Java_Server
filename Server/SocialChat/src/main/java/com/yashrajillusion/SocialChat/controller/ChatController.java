package com.yashrajillusion.SocialChat.controller;

import com.yashrajillusion.SocialChat.controller.ResponseModel.CommonApiResponse;
import com.yashrajillusion.SocialChat.model.Chat;
import com.yashrajillusion.SocialChat.model.User;
import com.yashrajillusion.SocialChat.service.ChatService;
import com.yashrajillusion.SocialChat.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
public class ChatController {
    @Autowired
    private ChatService chatService;

    @Autowired
    private UserService userService;

    @GetMapping("/chat/{id}")
    public ResponseEntity<CommonApiResponse<Chat>> getChatById(@PathVariable("id") String id) throws Exception {
        Chat chat = chatService.findByChatId(UUID.fromString(id)).orElseThrow(()-> new Exception("Chat not found"));
        return new ResponseEntity<>(new CommonApiResponse<Chat>(
                200, "chat fetched successfully", chat
        ), HttpStatus.OK);
    }

    @GetMapping("/chats/user/{userId}")
    public ResponseEntity<CommonApiResponse<List<Chat>>> getAllChatsByUserId(@PathVariable("userId") String userId) throws Exception {
        return new ResponseEntity<>(new CommonApiResponse<List<Chat>>(
                200, "All chat fetched successfully", chatService.findAllChatsForUser(UUID.fromString(userId))
        ), HttpStatus.OK);
    }

    @PostMapping("/chat")
    public ResponseEntity<CommonApiResponse<Chat>> createChat(@RequestBody Chat chat) throws Exception {
        List<UUID> memberIds = new ArrayList<>();
        for (String memberId : chat.getMembersId()) {
            memberIds.add(UUID.fromString(memberId));
        }
        if(!chat.getIsGroupChat()){
            List<UUID> chatId = chatService.findChatIdByMembers(memberIds, (long) memberIds.size());
            if(!chatId.isEmpty()) {
                Chat chat_data = chatService.findByChatId(chatId.get(0)).orElseThrow(()-> new Exception("some thing went wrong"));
                return new ResponseEntity<>(new CommonApiResponse<Chat>(
                        200, "Chat fetched successfully", chat_data
                ), HttpStatus.OK);
            }
        }
        List<User> members = userService.findAllByUserIds(memberIds);
        chat.setMembers(members);
        Chat create_chat = chatService.createChat(chat);
        return new ResponseEntity<>(new CommonApiResponse<Chat>(
                201, "Chat created successfully", create_chat
        ), HttpStatus.CREATED);
    }

    @PutMapping("/chat/update/{id}")
    public ResponseEntity<CommonApiResponse<Chat>> renameChat(@PathVariable("id") String id, @RequestBody Chat chat) throws Exception {
        Chat chatData = chatService.findByChatId(UUID.fromString(id)).orElseThrow(()-> new Exception("Chat not found"));
        if(chat.getChatName() != null) chatData.setChatName(chat.getChatName());
        if(chat.getMembersId() != null){
            List<UUID> memberIds = new ArrayList<>();
            for (String memberId : chat.getMembersId()) {
                memberIds.add(UUID.fromString(memberId));
            }
            List<User> members = userService.findAllByUserIds(memberIds);
            chatData.setMembers(members);
        }
        return new ResponseEntity<>(new CommonApiResponse<Chat>(
                200, "Chat updated successfully", chatService.createChat(chatData)
        ), HttpStatus.OK);
    }
}
