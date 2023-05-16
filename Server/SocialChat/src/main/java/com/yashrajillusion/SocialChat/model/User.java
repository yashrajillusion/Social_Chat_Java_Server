package com.yashrajillusion.SocialChat.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "_user") //in postgress user table already exist it will create error
public class User {
    @Id
    @GeneratedValue
    private UUID id;

    private String firstName;
    private String lastName;
    private String phone;
    private String email;
    private String password;

    private String avatarUrl = "https://icon-library.com/images/anonymous-avatar-icon/anonymous-avatar-icon-25.jpg";

    @CreationTimestamp
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "sender")
    @JsonIgnore
    private Set<Message> message;

    @ManyToMany(mappedBy = "members")
    @JsonIgnore
    private Set<Chat> chats = new HashSet<>();
}
