package common;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;

import org.json.JSONArray;
import org.json.JSONObject;

public class AIClient {
	private static String API_KEY;
    private static String MODEL;
    private static int MAX_TOKENS;
    
    // 클래스 로드될 때 설정 파일 읽기
    static {
        try {
            Properties prop = new Properties();
            InputStream input = AIClient.class.getClassLoader()
                                    .getResourceAsStream("config.properties");
            
            if (input != null) {
                prop.load(input);
                API_KEY = prop.getProperty("openai.api.key");
                MODEL = prop.getProperty("ai.model", "gpt-3.5-turbo");
                MAX_TOKENS = Integer.parseInt(prop.getProperty("ai.max.tokens", "1000"));
                input.close();
                System.out.println("✅ API 설정 로드 완료!");
            } else {
                System.out.println("❌ config.properties 파일을 찾을 수 없습니다!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ 설정 파일 로드 오류!");
        }
    }
    
    public static String chat(String prompt) {
        
        // API 키 확인
        if (API_KEY == null || API_KEY.isEmpty()) {
            return "API 키가 설정되지 않았습니다.";
        }
        
        String result = "";
        String apiUrl = "https://api.openai.com/v1/chat/completions";
        
        try {
            // 1. 연결 설정
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
            conn.setDoOutput(true);
            
            // 2. 요청 JSON 만들기
            JSONObject requestBody = new JSONObject();
            requestBody.put("model", MODEL);
            requestBody.put("max_tokens", MAX_TOKENS);
            
            JSONArray messages = new JSONArray();
            JSONObject message = new JSONObject();
            message.put("role", "user");
            message.put("content", prompt);
            messages.put(message);
            requestBody.put("messages", messages);
            
            // 3. 요청 보내기
            OutputStream os = conn.getOutputStream();
            os.write(requestBody.toString().getBytes("utf-8"));
            os.close();
            
            // 4. 응답 받기
            int responseCode = conn.getResponseCode();
            System.out.println("API 응답 코드: " + responseCode);
            
            if (responseCode == 200) {
                BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "utf-8")
                );
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
                br.close();
                
                // 5. JSON에서 답변 추출
                JSONObject jsonResponse = new JSONObject(response.toString());
                result = jsonResponse
                    .getJSONArray("choices")
                    .getJSONObject(0)
                    .getJSONObject("message")
                    .getString("content");
                    
            } else {
                // 에러 응답
                BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getErrorStream(), "utf-8")
                );
                StringBuilder error = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    error.append(line);
                }
                br.close();
                System.out.println("API 에러: " + error.toString());
                result = "AI 호출 중 오류가 발생했습니다. (코드: " + responseCode + ")";
            }
            
            conn.disconnect();
            
        } catch (Exception e) {
            e.printStackTrace();
            result = "AI 연결 중 오류가 발생했습니다.";
        }
        
        return result;
    }
}

