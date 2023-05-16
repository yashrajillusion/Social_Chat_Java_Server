package com.yashrajillusion.SocialChat.service;

import com.yashrajillusion.SocialChat.model.Message;
import com.yashrajillusion.SocialChat.repository.MessageDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class MessageServiceImpl implements  MessageService{
    @Autowired
    private MessageDao messageDao;
    @Override
    public Message createMessage(Message message) throws Exception {
        return messageDao.save(message);
    }

    @Override
    public List<Message> findMessageByChatId(UUID id) throws Exception {
        return messageDao.findAllByChatId(id);
    }
}
