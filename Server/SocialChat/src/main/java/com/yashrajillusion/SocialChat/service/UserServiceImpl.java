package com.yashrajillusion.SocialChat.service;

import com.yashrajillusion.SocialChat.model.User;
import com.yashrajillusion.SocialChat.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;

    @Override
    public User register(User user) throws Exception {
        Optional<User> emailExist = userDao.findByEmail(user.getEmail());
        if(emailExist.isPresent()){
            throw new Exception("Email already exist");
        }
        return userDao.save(user);
    }

    @Override
    public String login(User user) throws Exception {
        return null;
    }

    @Override
    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    @Override
    public List<User> findAllByUserIds(List<UUID> membersId) throws Exception {
        return userDao.findAllByIdIn(membersId);
    }

    @Override
    public Optional<User> findByUserId(UUID id) throws Exception {
        Optional<User> user = userDao.findUserById(id);
        if(user.isEmpty()) throw new Exception("User doesn't exist "+ id);
        else return user;
    }

    @Override
    public User saveUser(User user) {
        return userDao.save(user);
    }
}
