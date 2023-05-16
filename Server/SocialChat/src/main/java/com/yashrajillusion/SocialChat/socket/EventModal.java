package com.yashrajillusion.SocialChat.socket;
import lombok.Data;

import java.awt.*;

@Data
    public class EventModal {
        private Object message;
        private String room;

        public EventModal() {
        }

        public EventModal(String message) {
            this.message = message;
        }
    }