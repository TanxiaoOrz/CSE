package com.example.cse.Utils;

import org.springframework.util.StringUtils;

import java.util.List;

public class SearchUtils {

    public static void splitSearch(String search, List<String> adds,List<String> minuses,List<String> defaults) {
        if (StringUtils.hasText(search)) {
            String[] split = search.split(" ");
            for (String s:split) {
               if (s.startsWith("+")) {
                   adds.add(s);
                   continue;
               }
               if (s.startsWith("-")) {
                   minuses.add(s);
                   continue;
               }
               defaults.add(s);
            }
        }
    }
}
