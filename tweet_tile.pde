class TweetTile {
    private int index;
    private TweetData data;
    public float x;
    public float y;
    public float width;
    public float height;
    private float margin = 36;
    private float horizontalMargin = 120;
    private float base = 20;
    private Bubble[] bubbles = new Bubble[MAX_PARTICLES_TILE];

    TweetTile(int index, TweetData data) {
        this.data = data;
        this.index = index;
        //TODO: styling
        this.width = pixelWidth - this.horizontalMargin * 2;
        this.height = (pixelHeight - this.margin * 6) / 4.0;
        this.x = this.horizontalMargin;
        this.y = (this.height + this.margin) * index + this.margin;

        for (int i = 0; i < MAX_PARTICLES_TILE; i++) {
            bubbles[i] = generateBubble(i);
        }
    }

    public void draw() {
        blendMode(BLEND);
        fill(255, 120);
        noStroke();
        rect(this.x, this.y, this.width, this.height, 8);
        if (this.data.media != null) {
            imageMode(CORNER);
            this.data.media.resize(0, int(this.height));
            tint(255, 180);
            image(this.data.media, (this.width - this.data.media.width - 8 + this.x), this.y);
        }
        textFont(font, 18);
        fill(0);
        text(this.data.text, this.x + 16, this.y + this.height / 4 + 10, this.width - 22, this.height * 2 / 3);
        textSize(22);
        text(this.data.name, this.x + 16, this.y + 36);
        fill(40);
        float nameWidth = textWidth(this.data.name);
        textSize(18);
        text(" @"+this.data.screenName, nameWidth + this.x + 16, this.y + 34);

        for (int i = 0; i < MAX_PARTICLES_TILE; i++) {
            bubbles[i].draw();
            if (bubbles[i].isDead == true) {
                bubbles[i] = generateBubble(i);
            }
        }
    }

    public TweetData getData() {
        return this.data;
    }

    private Bubble generateBubble(int index) {
        int posX = int(random(this.x, this.x + this.width));
        int posY = int(random(this.y, this.y + this.height));
        switch (index % 4) {
            case 0: posX = int(this.x); break;
            case 1: posX = int(this.x + this.width); break;
            case 2: posY = int(this.y); break;
            case 3: posY = int(this.y + this.height); break;
        }
        return new Bubble(posX, posY, new PVector(255, 255, 255), 80, int(random(1, 5)), false);
    }

}