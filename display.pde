public class Display {

    // private PShader backgroundAnimation;

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

    }
}