package com.example.cse.Service;

import com.example.cse.Dto.UserDto;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.FavouriteOut;

public interface FavouriteService {

    FavouriteOut getFavouriteByUser(UserDto userDto);

    Integer deleteFavourite(UserDto userDto, Integer id, String type) throws NoDataException;

    Integer newFavourite(UserDto userDto, Integer id, String type) throws NoDataException;

}
