public class TweetData {
    public String id;
    public String text;
    public String name;
    public String screenName;
    public PImage profileImage;
    public PImage media;

    TweetData(StringDict props){
        id = props.get("id");
        text = props.get("text");
        name = props.get("name");
        screenName = props.get("screenName");
        String mediaUrl = props.get("mediaUrl");
        String profileUrl = props.get("profileImageUrl");
        if (!mediaUrl.equals("")) {
            media = loadImage(mediaUrl);
        }
        if (!profileUrl.equals("")) {
            profileImage = loadImage(profileUrl);
        }
    }
}