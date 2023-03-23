package com.example.cse.Service;

import com.example.cse.Utils.Exception.WrongDataException;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface FileService {

    String upload(MultipartFile multipartFile) throws WrongDataException, IOException;

}
