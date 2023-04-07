package com.example.cse.Service.impl;

import com.example.cse.Service.FileService;
import com.example.cse.Utils.Exception.WrongDataException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

@Service
public class FileServiceImpl implements FileService  {

    String absolutePath;
    String url;

    public FileServiceImpl(@Value("${server.port}")String port) throws FileNotFoundException, UnknownHostException {
        absolutePath = System.getProperty("user.dir")+"/static/img";
        File dir = new File(absolutePath);
        System.out.println(absolutePath);
        if(!dir.exists()){
            dir.mkdirs();
        }
        InetAddress localHost = InetAddress.getLocalHost();
        String hostAddress = localHost.getHostAddress();
        url = "http://" + hostAddress + ":" + port+"/static/img/";

    }

    @Override
    public String upload(MultipartFile multipartFile) throws WrongDataException, IOException {

        File file = new File(absolutePath,multipartFile.getOriginalFilename());
        if (file.exists())
            throw new WrongDataException("该文件名已存在");
        else {
            //file.mkdir();
            file.createNewFile();
            multipartFile.transferTo(file);
        }
        return url + multipartFile.getOriginalFilename();
    }

}
