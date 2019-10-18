public class Display {

    // private PShader backgroundAnimation;
    private PImage backgroundImage = null;

    Display(){}

    public void setup() {
        // this.backgroundAnimation = loadShader("base.frag");
    }

    public void draw() {
        // this.backgroundAnimation.set("time", millis() / 1000.0);
        // this.backgroundAnimation.set("resolution", (float)pixelWidth, (float)pixelHeight);
        // shader(this.backgroundAnimation);
        fill(20);
        rect(0, 0, pixelWidth, pixelHeight);
        if (this.backgroundImage != null) {
            tint(255, 60);
            this.backgroundImage.resize(int(pixelWidth), 0);
            image(this.backgroundImage, 0, 0);
            filter(BLUR, 4);
        }
    }

    public void updateImage(String newImageUrl) {
        this.backgroundImage = null;
        g.removeCache(this.backgroundImage);
        this.backgroundImage = loadImage(newImageUrl);
    }
}