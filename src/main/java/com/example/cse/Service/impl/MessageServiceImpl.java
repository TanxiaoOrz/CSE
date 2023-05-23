package com.example.cse.Service.impl;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.FavouriteMapper;
import com.example.cse.Mapper.MessageMapper;
import com.example.cse.Service.MessageService;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.Factory.MessageDtoFactory;
import com.example.cse.Utils.SearchUtils;
import com.example.cse.Vo.LatestMessages;
import com.example.cse.Vo.MessageIn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    MessageMapper messageMapper;
    @Autowired
    FavouriteMapper favouriteMapper;
    @Autowired
    MessageDtoFactory messageDtoFactory;


    @Override
    public MessageDto getMessage(Integer mid, UserDto userDto) throws WrongDataException {
        if (mid == null) {
            throw new WrongDataException("缺少mid");
        }
        Message message = messageMapper.getMessageByRule(mid,null,null).get(0);

        MessageDto messageDto = messageDtoFactory.getMessageDto(message);
        if (userDto == null) {
            messageDto.setIsFavourite(0);
        }else
            messageDto.setIsFavourite(favouriteMapper.getFavouriteMidByUid(userDto.getUid()).contains(messageDto.getMid())?1:0);
        return messageDto;
    }

    @Override
    public List<MessageDto> searchMessages(String search,String type) {
        List<String> adds = new ArrayList<>();
        List<String> minuses = new ArrayList<>();
        List<String> defaults = new ArrayList<>();
        SearchUtils.splitSearch(search,adds,minuses,defaults);

        List<Message> messages = messageMapper.searchMessage(defaults,adds,minuses,type);
        return messageDtoFactory.getMessageDtosOrderByRankScore(messages,null);
    }

    @Override
    @Transactional
    public Integer newMessage(MessageIn message) {
        Integer integer = messageMapper.newMessage(message);
        Integer mid = message.getMid();
        for (Integer i:message.getInformationClasses()) {
            messageMapper.newMessageRelationClass(mid,i);
        }
        for (Integer i:message.getLocations()) {
            messageMapper.newMessageRelationLocation(mid,i);
        }
        return integer;
    }

    @Override
    @Transactional
    public Integer updateMessage(MessageIn message) throws WrongDataException {
        Message oldMessage;
        try {
            oldMessage = messageMapper.getMessageByRule(message.getMid()==null?0:message.getMid(),null,null).get(0);
        }catch (IndexOutOfBoundsException e) {
            throw new WrongDataException("错误的编号");
        }
        Integer integer = 0;
        if (!message.checkUpdate(oldMessage)) {
            integer = messageMapper.updateMessage(message);
        }
        List<Integer> relations = message.getInformationClasses();
        if (relations != null) {
            List<Integer> old = messageMapper.getMessageRelationCid(message.getMid());
            ArrayList<Integer> delete = new ArrayList<>(old);
            delete.removeAll(relations);
            ArrayList<Integer> insert = new ArrayList<>(relations);
            insert.removeAll(old);
            for (Integer cid : delete) {
                integer += messageMapper.deleteMessageRelationClass(message.getMid(),cid);
            }
            for (Integer cid : insert) {
                integer += messageMapper.newMessageRelationClass(message.getMid(), cid);
            }
        }
        relations = message.getLocations();
        if (relations != null) {
            List<Integer> old = messageMapper.getMessageRelationLid(message.getMid());
            ArrayList<Integer> delete = new ArrayList<>(old);
            delete.removeAll(relations);
            ArrayList<Integer> insert = new ArrayList<>(relations);
            insert.removeAll(old);
            for (Integer cid : delete) {
                integer += messageMapper.deleteMessageRelationLocation(message.getMid(),cid);
            }
            for (Integer cid : insert) {
                integer += messageMapper.newMessageRelationLocation(message.getMid(), cid);
            }
        }

        return integer;
    }

    @Override
    public MessageDto getMessageOut(Integer mid) throws WrongDataException {
        if (mid == null) {
            throw new WrongDataException("缺少mid");
        }
        Message message = messageMapper.getMessageOut(mid);
        return messageDtoFactory.getMessageDto(message);
    }

    @Override
    public List<MessageDto> searchMessagesOut(String search) {
        List<String> adds = new ArrayList<>();
        List<String> minuses = new ArrayList<>();
        List<String> defaults = new ArrayList<>();
        SearchUtils.splitSearch(search,adds,minuses,defaults);

        List<Message> messages = messageMapper.searchMessageOut(defaults,adds,minuses);
        return messageDtoFactory.getMessageDtosOrderByRankScore(messages,null);
    }

    @Override
    @Transactional
    public Integer deleteMessage(Integer mid, boolean out) {
        if (out)
            return messageMapper.deleteMessageOut(mid);
        else
            return messageMapper.deleteMessage(mid);
    }

    @Override
    public LatestMessages getLastMessagesTypes() {
        LatestMessages latestMessages = new LatestMessages();
        latestMessages.setActivities(this.messageMapper.getLastMessageByType("活动"));
        latestMessages.setContests(this.messageMapper.getLastMessageByType("比赛"));
        latestMessages.setResources(this.messageMapper.getLastMessageByType("资源"));
        latestMessages.setSections(this.messageMapper.getLastMessageByType("部门"));
        return latestMessages;
    }
}
