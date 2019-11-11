public class Bubble {

    private int radius = 60;
    private PVector position;
    private PVector velocity;
    private PVector direction;
    private PVector center;
    private PVector colorRGB = new PVector(random(0.2, 0.9) * 255, random(0.2, 0.9) * 255, random(0.2, 0.9) * 255);
    private int lifeTime = 0;
    private int opacity;
    public boolean isDead = false;
    private int maxLife;
    private float rotateDirection;
    private boolean isBackground;

    Bubble(int x, int y, PVector fixedColor, int fixedOpacity, int fixedMaxLife, boolean isBackground){
        position = new PVector(x, y);
        direction = getRandomDirection();
        velocity = direction;
        center = new PVector(pixelWidth/2, pixelHeight/2);
        this.isBackground = isBackground;
        radius = isBackground ? int(random(120, 180)) : int(random(4, 8));
        colorRGB = (fixedColor != null) ? fixedColor : colorRGB;
        maxLife = (fixedMaxLife != 0) ? fixedMaxLife : int(random(250, 800));
        opacity = (fixedOpacity != 0) ? fixedOpacity : 180;
        rotateDirection = Math.signum(radius - 60);
    }

    public void draw() {
        this.move();

        noStroke();
        fill(colorRGB.x, colorRGB.y, colorRGB.z, opacity);
        ellipse(position.x, position.y, radius, radius);
        if (isBackground) {
            fill(255, max(opacity - 100, 0));
            pushMatrix();
            translate(position.x, position.y);
            ellipse(radius / 5 * cos(PI / 128 * lifeTime * rotateDirection),
                radius / 5 * sin(PI / 128 * lifeTime * rotateDirection),
                radius / 4,
                radius / 4);
            popMatrix();
        }

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

        if (isBackground) {
            float salt = (noise(lifeTime + colorRGB.x - colorRGB.y) - 0.5) * 0.4;
            velocity.set(direction.add(new PVector(salt, salt)));
        } else {
            velocity.set(direction.mult(0.94));            
        }
    }

    private PVector getRandomDirection() {
        return PVector.fromAngle(random(0, TWO_PI)).mult(random(2.0, 4.5));
    }

    public void addForce(float force) {
        if (force > 1.0) {
            PVector forceVector = new PVector(pixelWidth / 2, pixelHeight / 5).cross(position).normalize().mult(force);
            velocity.add(forceVector);
        } else {
            PVector forceVector = new PVector(pixelWidth / 2, pixelHeight / 5).cross(position).normalize().mult(2.5 - force);
            velocity.sub(forceVector);
        }
    }
}
