class TweetTile {
    private int index;
    private TweetData data;
    public float x;
    public float y;
    public float width;
    public float height;
    private float margin = 32;
    private float horizontalMargin = 240;
    private float base = 20;
    private Bubble[] bubbles = new Bubble[MAX_PARTICLES_TILE];

    TweetTile(int index, TweetData data) {
        this.data = data;
        this.index = index;
        //TODO: styling
        this.width = pixelWidth - this.horizontalMargin * 2;
        this.height = (pixelHeight - this.margin * 6) / 11.0;
        this.x = this.horizontalMargin;
        this.y = (this.height + this.margin) * index + this.margin;

        //for (int i = 0; i < MAX_PARTICLES_TILE; i++) {
        //    bubbles[i] = generateBubble(i);
        //}
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
        float aviSize = this.height - 32;
        if (this.data.profileImage != null) {
            imageMode(CORNER);
            globalCircleMaskImage.resize(this.data.profileImage.width, this.data.profileImage.height);
            this.data.profileImage.mask(globalCircleMaskImage);
            this.data.profileImage.resize(0, int(aviSize));
            image(this.data.profileImage, this.x + 16, this.y + 16);
        }
        textFont(font, 42);
        fill(40);
        text(this.data.text, this.x + 48 + aviSize, this.y + this.height / 5, this.width - 32 - aviSize, this.height * 2 / 3);
        //textSize(38);
        //text(this.data.name, this.x + 48 + aviSize, this.y + 48);
        //fill(60);
        //float nameWidth = textWidth(this.data.name);
        //textSize(28);
        //text(" @"+this.data.screenName, nameWidth + this.x + 60 + aviSize, this.y + 40);

        //for (int i = 0; i < MAX_PARTICLES_TILE; i++) {
        //    bubbles[i].draw();
        //    if (bubbles[i].isDead == true) {
        //        bubbles[i] = generateBubble(i);
        //    }
        //}
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
