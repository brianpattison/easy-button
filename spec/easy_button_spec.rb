describe EasyButton do
  before do
    @easyButton = EasyButton.alloc.initWithFrame([[0.0, 0.0], [10.0, 50.0]])
  end

  it "backgroundColor should be transparent" do
    @easyButton.backgroundColor.should.equal UIColor.clearColor
  end
  
  it "font should have a default value" do
    @easyButton.font.should.equal UIFont.boldSystemFontOfSize(18)
  end
  
  it "titleLabel should have a shadowColor" do
    @easyButton.titleLabel.shadowColor.should.equal UIColor.colorWithWhite(0, alpha:0.5);
  end
  
  it "titleLabel should have a shadowOffset" do
    @easyButton.titleLabel.shadowOffset.should.equal CGSizeMake(0, -1)
  end
  
  it "titleLabel text should change with title" do
    title = 'That Was Easy!'
    @easyButton.title = title
    @easyButton.titleLabel.text.should.equal title
  end
  
  it "titleLabel font should change with font" do
    font = UIFont.boldSystemFontOfSize(10)
    @easyButton.font = font
    @easyButton.titleLabel.font.should.equal font
  end
end
