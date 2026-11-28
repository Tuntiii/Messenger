package messenger.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Message {
    private int id;
    private int senderId;
    private String senderName;
    private Integer roomId;
    private Integer receiverId;
    private String text;
    private LocalDateTime sentAt;

    public Message(int id, int senderId, String senderName, Integer roomId, Integer receiverId, String text, LocalDateTime sentAt) {
        this.id = id;
        this.senderId = senderId;
        this.senderName = senderName;
        this.roomId = roomId;
        this.receiverId = receiverId;
        this.text = text;
        this.sentAt = sentAt;
    }

    public int getId() {
        return id;
    }

    public int getSenderId() {
        return senderId;
    }

    public String getSenderName() {
        return senderName;
    }

    public Integer getRoomId() {
        return roomId;
    }

    public Integer getReceiverId() {
        return receiverId;
    }

    public String getText() {
        return text;
    }

    public LocalDateTime getSentAt() {
        return sentAt;
    }

    public boolean isPrivate(){
        return receiverId!=null;
    }

    public String format(){
        return "[" + sentAt.format(DateTimeFormatter.ofPattern("HH:mm")) + "]" + senderName + ": " + text;
    }
}

