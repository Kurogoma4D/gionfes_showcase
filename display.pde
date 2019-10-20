public class Display {

    private Bubble[] bubbles = new Bubble[MAX_PARTICLES];
    private float force = 0.0;

    Display(){
        for (int i = 0; i < MAX_PARTICLES; i++) {
            bubbles[i] = new Bubble(pixelWidth/2, pixelHeight/2, null, 180, 0, true);
        }
    }

    public void draw() {
        for (int i = 0; i < MAX_PARTICLES; i++) {
            if (force > 0.0) {
                bubbles[i].addForce(force);
            }
            bubbles[i].draw();
            if (bubbles[i].isDead == true) {
                bubbles[i] = new Bubble(pixelWidth/2, pixelHeight/2, null, 180, 0, true);
            }
        }

        if (force > 0.0) {
            force -= 0.1;
            if (force < 0.1) force = 0.0;
        }
    }

    public void addBubbleForce() {
        force = 2.0;
    }
}