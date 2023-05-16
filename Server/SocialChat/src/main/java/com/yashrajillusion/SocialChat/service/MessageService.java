package com.yashrajillusion.SocialChat.service;
import com.yashrajillusion.SocialChat.model.Message;

import java.util.List;
import java.util.UUID;

public interface MessageService {
    public Message createMessage(Message message) throws Exception;
    public List<Message> findMessageByChatId(UUID id) throws Exception;
}
