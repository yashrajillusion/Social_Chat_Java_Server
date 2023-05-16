package com.yashrajillusion.SocialChat.repository;

import com.yashrajillusion.SocialChat.model.Chat;
import com.yashrajillusion.SocialChat.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ChatDao extends JpaRepository<Chat, Integer> {
    List<User> findByIdIn(List<UUID> members);
    Optional<Chat> findChatById(UUID id);
    @Query(value = "SELECT mc.user_id FROM member_chat mc WHERE mc.chat_id = :chatId", nativeQuery = true)
    List<UUID> findMemberIdsByChatId(@Param("chatId") UUID chatId);

    @Query(value = "SELECT chat_id FROM member_chat WHERE user_id IN :userIds GROUP BY chat_id HAVING COUNT(DISTINCT user_id) = :userCount", nativeQuery = true)
    List<UUID> findChatIdByUserId(@Param("userIds") List<UUID> id1, @Param("userCount") Long userCount);

    @Query("SELECT c FROM Chat c JOIN c.members m WHERE m.id = :userId")
    List<Chat> findAllChatsForUser(@Param("userId") UUID userId);

}
