import http.requests.*;
import java.util.LinkedList;
import java.util.Collections;

String token;
SearchClient client;
Display display;
LinkedList<TweetTile> tweets;
boolean isUpdating = false;
boolean isKeyPressed = false;
boolean updateFlag = false;
ArrayList<String> images = new ArrayList<String>();
LinkedList<TweetData> list = new LinkedList<TweetData>();
PFont font;
int baseTime = 0;

void setup() {
    // size(1280, 720);
    fullScreen(P2D, 2);
    smooth(2);
    OAuth auth = new OAuth();
    token = auth.getBearerToken();

    client = new SearchClient(token);
    display = new Display();
    tweets = new LinkedList<TweetTile>();
    font = createFont("IPAexGothic", 18, true);
    display.setup();
    baseTime = millis();
}

void draw() {
    display.draw();

    int now = millis();
    if (now - baseTime > 15000 && isUpdating == false) {
        baseTime = now;
        isUpdating = true;
        thread("requestTweet");
    }
    if (isUpdating == false && updateFlag == true) {
        updateTweet();
    }
    if (tweets.size() != 0) {
        for (TweetTile tweet : tweets) {
            tweet.draw();
        }
    }

    fill(255);
    text(baseTime + "  " + now + "  " + frameRate, 18, pixelHeight - 24);
}

void requestTweet() {
    list = client.request();
    isUpdating = false;
    updateFlag = true;
}

void updateTweet() {
    LinkedList<TweetTile> newTweets = new LinkedList<TweetTile>();

    for (int i = 0; i < list.size(); i++) {
        TweetData newTweet = list.get(i);
        newTweets.add(new TweetTile(i, newTweet));
    }

    tweets = newTweets;
    updateFlag = false;
}