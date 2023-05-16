package com.yashrajillusion.SocialChat.service;

import com.yashrajillusion.SocialChat.model.Chat;
import com.yashrajillusion.SocialChat.model.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ChatService {
    public Chat createChat(Chat chat) throws Exception;
    public Optional<Chat> findByChatId(UUID id) throws Exception;
    public List<User> findMembersByChatId(UUID id) throws Exception;
    public List<Chat> findAllChatsForUser(UUID userId) throws Exception;
    public List<UUID> findChatIdByMembers(List<UUID> id, Long membercount) throws Exception;

}
