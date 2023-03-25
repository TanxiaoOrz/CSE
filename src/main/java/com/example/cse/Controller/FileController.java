package com.example.cse.Controller;

import com.example.cse.Service.impl.FileServiceImpl;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController("/cse/File")
@Api(tags = "文件的上传接口")
@CrossOrigin
public class FileController {

    @Autowired
    FileServiceImpl fileService;

    @PostMapping(value = "/Manager/upload")
    @ApiOperation(value = "图片或图片上传", notes = "图片或图片上传")
    // 此处的@RequestParam中的file名应与前端upload组件中的name的值保持一致
    public Vo<String> upload(@RequestPart("file") MultipartFile multipartFile) throws WrongDataException, IOException {
        return new Vo<>(fileService.upload(multipartFile));
    }

}
