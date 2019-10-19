public class Display {

    private Bubble[] bubbles = new Bubble[MAX_PARTICLES];

    Display(){
        for (int i = 0; i < MAX_PARTICLES; i++) {
            bubbles[i] = new Bubble(pixelWidth/2, pixelHeight/2);
        }
    }

    public void draw() {
        fill(12);
        noStroke();
        rect(0, 0, pixelWidth, pixelHeight);

        for (int i = 0; i < MAX_PARTICLES; i++) {
            bubbles[i].draw();
            if (bubbles[i].isDead == true) {
                bubbles[i] = new Bubble(pixelWidth/2, pixelHeight/2);
            }
        }
    }
}