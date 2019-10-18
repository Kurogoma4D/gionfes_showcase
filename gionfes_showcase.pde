import http.requests.*;
import java.util.LinkedList;
import java.util.Collections;

String token;
SearchClient client;
Display display;
LinkedList<TweetTile> tweets;
boolean isUpdating = false;
boolean isKeyPressed = false;
ArrayList<String> images = new ArrayList<String>();
PFont font;

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
    display.setup();
}

void draw() {
    display.draw();

    if (isKeyPressed == true && isUpdating == false) {
        isUpdating = true;
        updateTweet();
    }
    if (tweets.size() != 0) {
        for (TweetTile tweet : tweets) {
            tweet.draw();
            g.removeCache(tweet.backgroundImage);
        }
        System.gc();
    }

    fill(255);
    text(str(frameRate), 18, pixelHeight - 30);
}

void updateTweet() {
    ArrayList<TweetData> list = client.request();

    for (int i = 0; i < list.size(); i++) {
        TweetData newTweet = list.get(i);
        if (tweets.size() < 5) {
            // if (newTweet.id == tweets.get(i).getData().id) break;
            tweets.offerFirst(new TweetTile(4-i, newTweet));
        } else {
            tweets.removeLast();
            tweets.offerFirst(new TweetTile(0, newTweet));
        }
    }

    images.clear();
    for (int j = 0; j < tweets.size(); j++) {
        TweetTile prev = tweets.get(j);
        tweets.set(j, new TweetTile(4-j, prev.getData()));
        String media = prev.getData().mediaUrl;
        if (media != "") {
            images.add(media);
        }
    }
    if (images.size() != 0) {
        Collections.shuffle(images);
        display.updateImage(images.get(0));
    }

    isUpdating = false;
}

void keyPressed() {
    isKeyPressed = true;
}

void keyReleased() {
    isKeyPressed = false;
}
