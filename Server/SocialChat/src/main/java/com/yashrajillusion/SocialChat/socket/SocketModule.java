package com.yashrajillusion.SocialChat.socket;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.listener.ConnectListener;
import com.corundumstudio.socketio.listener.DataListener;
import com.corundumstudio.socketio.listener.DisconnectListener;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Slf4j
@Component
public class SocketModule {
    private final SocketIOServer server;
    public SocketModule(SocketIOServer server){
        this.server = server;
        server.addConnectListener(onConnected());
        server.addDisconnectListener(onDisconnected());
        server.addEventListener("user_room", EventModal.class, onChatReceived());
        server.addEventListener("create_message", EventModal.class, onCreateMessage());
    }
    private DataListener<EventModal> onCreateMessage() {
        return (senderClient, data, ackSender) -> {
            Object messages = data.getMessage();
            if(messages instanceof Map<?,?>){
                try{
                    Map<String, Object> map = (Map<String, Object>) messages;
                    List<Map<String, Object>> value = (List<Map<String, Object>>) map.get("members");
                    Map<String, Object> senderMap = (Map<String, Object>) map.get("sender");
                    String senderId = (String) senderMap.get("id");
                    for(Map<String, Object> user : value){
                        String  roomId = (String) user.get("id");
                        if(!roomId.equals(senderId)){
                            server.getRoomOperations(roomId).sendEvent("new_message", data);
                        }
                    }
                }catch (NullPointerException np){
                    log.info(np.toString());
                }
            }
        };
    }
    private DataListener<EventModal> onChatReceived() {
        return (senderClient, data, ackSender) -> {
            senderClient.joinRoom(data.getRoom());
        };
    }
    private ConnectListener onConnected() {
        return (client) -> {
            log.info("Socket ID[{}] Connected to socket");
        };

    }
    private DisconnectListener onDisconnected() {
        return client -> {
            log.info("Client[{}] - Disconnected from socket", client.getSessionId().toString());
        };
    }

}
