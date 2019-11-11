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

    TweetTile(int index, TweetData data) {
        this.data = data;
        this.index = index;
        this.width = pixelWidth - this.horizontalMargin * 2;
        this.height = (pixelHeight - this.margin * 6) / 11.0;
        this.x = this.horizontalMargin;
        this.y = (this.height + this.margin) * index + this.margin;
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
    }

    public TweetData getData() {
        return this.data;
    }

}
