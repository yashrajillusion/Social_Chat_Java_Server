package com.yashrajillusion.SocialChat.service;

import com.yashrajillusion.SocialChat.model.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserService {
    public User register(User user) throws Exception;
    public String login(User user) throws  Exception;
    public List<User> getAllUsers();
    public List<User> findAllByUserIds(List<UUID> membersId) throws Exception;
    public Optional<User> findByUserId(UUID id) throws Exception;
    public User saveUser(User user) throws  Exception;
}
