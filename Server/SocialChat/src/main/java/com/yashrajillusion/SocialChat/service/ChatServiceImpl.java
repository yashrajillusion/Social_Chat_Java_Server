package com.yashrajillusion.SocialChat.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.yashrajillusion.SocialChat.model.Chat;
import com.yashrajillusion.SocialChat.model.User;
import com.yashrajillusion.SocialChat.repository.ChatDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.lang.Object;

@Service
public class ChatServiceImpl implements ChatService {
    @Autowired
    private ChatDao chatDao;

    @Autowired
    private UserService userService;

    @Override
    public Chat createChat(Chat chat) throws Exception {
        return chatDao.save(chat);
    }
    @Override
    public Optional<Chat> findByChatId(UUID id) throws Exception {
        Optional<Chat> chat = chatDao.findChatById(id);
        if(chat.isEmpty()) throw new Exception("User doesn't exist "+ id);
        else return chat;
    }

    @Override
    public List<User> findMembersByChatId(UUID id) throws Exception {
        List<UUID> membersId = chatDao.findMemberIdsByChatId(id);
        return userService.findAllByUserIds(membersId);
    }

    @Override
    public List<Chat> findAllChatsForUser(UUID userId) throws Exception {
        return  chatDao.findAllChatsForUser(userId);
    }

    @Override
    public List<UUID> findChatIdByMembers(List<UUID> id, Long membercount) throws Exception {
        return chatDao.findChatIdByUserId(id, membercount);
    }
}
