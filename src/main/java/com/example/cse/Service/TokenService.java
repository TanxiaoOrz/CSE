package com.example.cse.Service;

import com.example.cse.Entity.UserClass.User;

public interface TokenService {

    String newTokenByUser(User user);

    String getUserByToken(String Token);

    String getManagerByToken(String Token);


}
