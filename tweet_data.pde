public class TweetData {
    public String id;
    public String text;
    public String name;
    public String screenName;
    public String profileImageUrl;
    public String mediaUrl;

    TweetData(StringDict props){
        id = props.get("id");
        text = props.get("text");
        name = props.get("name");
        screenName = props.get("screenName");
        profileImageUrl = props.get("profileImageUrl");
        mediaUrl = props.get("mediaUrl");
    }
}