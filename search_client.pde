import http.requests.*;

public class SearchClient {
    private String token;
    private final String query = "血液クレンジング";
    // private final String query = "%23gion";

    SearchClient(String token) {
        setToken(token);
    }

    public void setToken(String token) {
        this.token = token;
    }

    public ArrayList<TweetData> request(){
        ArrayList<TweetData> tweets = new ArrayList<TweetData>();
        GetRequest get = new GetRequest("https://api.twitter.com/1.1/search/tweets.json?q="+query);
        get.addHeader("Host","api.twitter.com");
        get.addHeader("Authorization","Bearer "+this.token);
        get.send();

        JSONObject response = parseJSONObject(get.getContent());
        JSONArray statuses = response.getJSONArray("statuses");
        
        // get 5 tweets from upper
        for (int i = 0; i < statuses.size(); i++) {
            if (i >= 5) break;
            JSONObject tweet = statuses.getJSONObject(i);
            StringDict data = new StringDict();
            data.set("id", tweet.getString("id_str"));
            String text = tweet.getString("text")
                            .replaceAll("\n", "")
                            .replaceFirst("https://t.*", "");
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

        for (TweetData o : tweets) {
            println(o.id);
        }
        println("\n");

        return tweets;
    }
}