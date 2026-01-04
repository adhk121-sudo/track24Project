package common;

import java.io.*;
import java.net.*;
import org.json.*;

public class AIClient {
	private static final String API_KEY = "sk-xxxxxxxxxxxxxxxx";
    private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    
    public static String chat(String prompt) {
        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
            conn.setDoOutput(true);
            
            // 요청 JSON
            String jsonBody = String.format("""
                {
                    "model": "gpt-3.5-turbo",
                    "messages": [{"role": "user", "content": "%s"}],
                    "max_tokens": 1000
                }
                """, escapeJson(prompt));
            
            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonBody.getBytes("utf-8"));
            }
            
            // 응답 받기
            if (conn.getResponseCode() == 200) {
                BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "utf-8")
                );
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
                br.close();
                
                JSONObject json = new JSONObject(sb.toString());
                return json.getJSONArray("choices")
                           .getJSONObject(0)
                           .getJSONObject("message")
                           .getString("content");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "AI 응답을 받지 못했습니다.";
    }
    
    // JSON 특수문자 이스케이프
    private static String escapeJson(String text) {
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r");
    }
}
