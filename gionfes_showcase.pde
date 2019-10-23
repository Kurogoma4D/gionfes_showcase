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
final int MAX_PARTICLES = 20;
final int MAX_PARTICLES_TILE = 120;
float floatTime = 0.0;

void setup() {
    // size(1280, 720);
    fullScreen(P2D, 1);
    smooth(2);
    OAuth auth = new OAuth();
    token = auth.getBearerToken();

    client = new SearchClient(token);
    display = new Display();
    tweets = new LinkedList<TweetTile>();
    font = createFont("IPAexGothic", 18, true);
    baseTime = millis();
    isUpdating = true;
    thread("requestTweet");
}

void draw() {
    fill(3, map(sin(floatTime), -1, 1, 15, 55), 68);
    noStroke();
    rect(0, 0, pixelWidth, pixelHeight);

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
    
    display.draw();

    fill(255);
    text(baseTime + "  " + now + "  " + frameRate, 18, pixelHeight - 24);

    floatTime += 0.01;
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

    if (tweets.size() != 0) {
        String latest = tweets.get(0).getData().id;
        if (latest != newTweets.get(0).getData().id) {
            display.addBubbleForce();
        }
    }

    tweets = newTweets;
    updateFlag = false;
}