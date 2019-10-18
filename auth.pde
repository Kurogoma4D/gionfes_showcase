import java.util.Base64;
import http.requests.*;

public class OAuth {
    private String consumer;
    private String consumerSecret;

    OAuth(){
        this.consumer = System.getenv("TW_GION_CONSUMER");
        this.consumerSecret = System.getenv("TW_GION_CONSUMER_SECRET");
    };

    public String getBearerToken() {
        String concated = consumer + ":" + consumerSecret;

        byte[] concatedBytes = concated.getBytes();
        String encoded = Base64.getEncoder().encodeToString(concatedBytes);

        PostRequest post = new PostRequest("https://api.twitter.com/oauth2/token");
        post.addHeader("Host","api.twitter.com");
        post.addHeader("Authorization","Basic "+encoded);
        post.addData("grant_type","client_credentials");
        post.send();

        JSONObject response = parseJSONObject(post.getContent());
        
        String token = null;
        try {
            token = response.getString("access_token");
            if (token == null) {
                throw new Exception("Failed to get access_token.");
            }
        } catch (Exception e) {
            println(e.getMessage());
            exit();
        }

        return token;
    }
}