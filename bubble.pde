public class Bubble {

    private int radius = 60;
    private PVector position;
    private PVector velocity;
    private PVector direction;
    private PVector center;
    private PVector colorRGB;
    private int lifeTime = 0;
    private int opacity = 180;
    public boolean isDead = false;
    private int maxLife;

    Bubble(int x, int y){
        position = new PVector(x, y);
        direction = getRandomDirection();
        velocity = direction;
        center = new PVector(pixelWidth/2, pixelHeight/2);
        radius = int(random(40, 80));
        colorRGB = new PVector(random(0.2, 0.9) * 255, random(0.2, 0.9) * 255, random(0.2, 0.9) * 255);
        maxLife = int(random(250, 800));
    }

    public void draw() {
        this.move();

        blendMode(ADD);
        fill(255, 0);
        stroke(colorRGB.x, colorRGB.y, colorRGB.z, opacity);
        ellipse(position.x, position.y, radius, radius);
        stroke(colorRGB.x, colorRGB.y, colorRGB.z, max(opacity - 40, 0));
        pushMatrix();
        translate(position.x, position.y);
        ellipse(-radius / 5, -radius / 5, radius / 4, radius / 4);
        popMatrix();

        lifeTime += 1;
        if (lifeTime > maxLife) {
            opacity -= 1;
            if (opacity < 1) {
                isDead = true;
            }
        }
    }

    public void move() {
        this.updateVelocity();
        position.add(velocity);
    }

    private void updateVelocity() {
        if (position.x < radius || position.x > pixelWidth - radius) {
            direction.set(-direction.x, direction.y);
            direction.rotate(random(-HALF_PI / 3, HALF_PI / 3));
            velocity = direction;
        }
        if (position.y < radius || position.y > pixelHeight - radius) {
            direction.set(direction.x, -direction.y);
            direction.rotate(random(-HALF_PI / 3, HALF_PI / 3));
            velocity = direction;
        }
    }

    private PVector getRandomDirection() {
        return PVector.fromAngle(random(0, TWO_PI)).mult(random(2.0, 4.5));
    }
}