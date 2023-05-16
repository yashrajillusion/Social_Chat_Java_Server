package com.yashrajillusion.SocialChat.repository;

import com.yashrajillusion.SocialChat.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
@Repository
public interface UserDao extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);
    Optional<User> findUserById(UUID id);
    List<User> findAllByIdIn(List<UUID> members);

}
