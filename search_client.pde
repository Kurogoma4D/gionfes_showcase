import http.requests.*;
import java.util.LinkedList;

public class SearchClient {
    private String token;
    private final String query = "%23木更津高専文化祭+OR+%23gionsai2019";
     //private final String query = "ペイペイドーム";

    SearchClient(String token) {
        setToken(token);
    }

    public void setToken(String token) {
        this.token = token;
    }

    public LinkedList<TweetData> request(){
        LinkedList<TweetData> tweets = new LinkedList<TweetData>();
        GetRequest get = new GetRequest("https://api.twitter.com/1.1/search/tweets.json?q="+query+"+exclude:retweets");
        get.addHeader("Host","api.twitter.com");
        get.addHeader("Authorization","Bearer "+this.token);
        get.send();

        JSONObject response = parseJSONObject(get.getContent());
        JSONArray statuses = response.getJSONArray("statuses");
        
        int responseSize = min(statuses.size(), 10);
        for (int i = 0; i < responseSize; i++) {
            JSONObject tweet = statuses.getJSONObject(i);
            StringDict data = new StringDict();
            data.set("id", tweet.getString("id_str"));
            String text = tweet.getString("text")
                            .replaceAll("\n", " ")
                            .replaceFirst("https://t.*", "");
            //if (text.length() > 60) {
            //    text = text.substring(0, 60);
            //}
            data.set("text", text);
            JSONObject user = tweet.getJSONObject("user");
            data.set("name", user.getString("name"));
            data.set("screenName", user.getString("screen_name"));
            data.set("profileImageUrl", user.getString("profile_image_url_https"));
            JSONArray media = tweet.getJSONObject("entities").getJSONArray("media");
            if (media != null) {
                data.set("mediaUrl", media.getJSONObject(0).getString("media_url_https"));
            } else {
                data.set("mediaUrl", "");
            }

            tweets.add(new TweetData(data));
        }

        return tweets;
    }
}
