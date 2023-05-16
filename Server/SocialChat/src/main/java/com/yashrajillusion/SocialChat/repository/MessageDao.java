package com.yashrajillusion.SocialChat.repository;


import com.yashrajillusion.SocialChat.model.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;
@Repository
public interface MessageDao extends JpaRepository<Message, Integer> {

    @Query(value = "SELECT * FROM message WHERE chat_id = :chatId", nativeQuery = true)
    List<Message> findAllByChatId(@Param("chatId") UUID chatId);

}
