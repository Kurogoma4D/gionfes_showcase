class TweetTile {
    private int index;
    private TweetData data;
    public float x;
    public float y;
    public float width;
    public float height;
    private float margin = 36;
    private float horizontalMargin = 150;
    public PImage backgroundImage = null;
    private float base = 20;

    TweetTile(int index, TweetData data) {
        this.data = data;
        this.index = index;
        //TODO: styling
        this.width = pixelWidth - this.horizontalMargin * 2;
        this.height = (pixelHeight - this.margin * 6) / 5.0;
        this.x = this.horizontalMargin;
        this.y = (this.height + this.margin) * index + this.margin;
        if (data.mediaUrl != "") {
            this.backgroundImage = loadImage(data.mediaUrl);
        }
    }

    public void draw() {
        fill(255, 200);
        noStroke();
        rect(this.x, this.y, this.width, this.height, 8);
        if (this.backgroundImage != null) {
            imageMode(CORNER);
            this.backgroundImage.resize(0, int(this.height));
            tint(255, 180);
            image(this.backgroundImage, (this.width - this.backgroundImage.width - 8 + this.x), this.y);
        }
        textFont(font, 18);
        fill(0);
        text(this.data.text, this.x + 16, this.y + this.height / 3 + 12, this.width - 16, this.height);
        textSize(22);
        text(this.data.name, this.x + 16, this.y + 36);
        fill(120);
        float nameWidth = textWidth(this.data.name);
        textSize(18);
        text(" @"+this.data.screenName, nameWidth + this.x + 16, this.y + 34);
    }

    public TweetData getData() {
        return this.data;
    }

}