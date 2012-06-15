describe EasyButton do
  before do
    @easyButton = EasyButton.alloc.initWithFrame([[0.0, 0.0], [10.0, 50.0]])
  end

  it "borderRadius should have a default value" do
    @easyButton.borderRadius.should.equal 10
  end
  
  it "font should have a default value" do
    @easyButton.font.should.equal UIFont.boldSystemFontOfSize(18)
  end
  
  it "titleLabel should have a default shadowColor" do
    @easyButton.titleLabel.shadowColor.should.equal UIColor.colorWithWhite(0, alpha:0.5);
  end
  
  it "titleLabel should have a default shadowOffset" do
    @easyButton.titleLabel.shadowOffset.should.equal CGSizeMake(0, -1)
  end
  
  it "titleLabel should have a default textColor" do
    @easyButton.titleLabel.textColor.should.equal UIColor.colorWithRed(1, green:1, blue:1, alpha:1)
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
  
  it "titleLabel textColor should change with textColor" do
    textColor = '#000'
    @easyButton.textColor = textColor
    @easyButton.titleLabel.textColor.should.equal UIColor.colorWithRed(0, green:0, blue:0, alpha:1)
  end
  
  it "should raise an error for bad textColor hex code" do
    lambda { @easyButton.textColor = '#ff00' }.should.raise(ArgumentError, 'Argument is not a valid hex code.')
  end
end
