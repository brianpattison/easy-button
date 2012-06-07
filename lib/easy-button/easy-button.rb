class EasyButton < UIButton
  attr_accessor :borderRadius, :font, :textColor, :title
  
  def initWithFrame(frame)
    if super
      buttonSetup
    end
    self
  end
  
  def initWithCoder(a_decoder)
    if super
      buttonSetup
    end
    self
  end
  
  def buttonSetup
    self.opaque = false
    self.backgroundColor = UIColor.clearColor
    self.backgroundColor = "#ff0000"
    self.borderRadius = 10
    self.font = UIFont.boldSystemFontOfSize(18)
    self.textColor = '#fff'
    titleLabel.shadowColor = UIColor.colorWithWhite(0, alpha:0.5);
    titleLabel.shadowOffset = [0, -1]
  end
  
  def backgroundColor=(value)
    if value.is_a? String
      rgb = rgbFromHex(value)
      @backGroundColorRed = rgb[0]
      @backGroundColorGreen = rgb[1]
      @backGroundColorBlue = rgb[2]
      @backgroundColorTop = UIColor.colorWithRed(@backGroundColorRed * 1.2, green:@backGroundColorGreen * 1.2, blue:@backGroundColorBlue * 1.2, alpha:1)
      @backgroundColorBottom = UIColor.colorWithRed(@backGroundColorRed * 0.7, green:@backGroundColorGreen * 0.7, blue:@backGroundColorBlue * 0.7, alpha:1)
    elsif value = UIColor.clearColor
      super
    else
      @backgroundColorStart = value
      @backgroundColorBottom = value
    end
    self.setNeedsDisplay
  end
  
  def borderRadius=(value)
    @borderRadius = value
    self.setNeedsDisplay
  end
  
  def textColor=(value)
    @textColor = value
    if value.is_a? String
      red, green, blue = rgbFromHex(value)
      titleLabel.textColor = UIColor.colorWithRed(red, green:green, blue:blue, alpha:1)
    else
      titleLabel.textColor = value
    end
  end
  
  def font=(value)
    @font = value
    titleLabel.setFont(@font)
  end
  
  def title=(value)
    @title = value
    self.setTitle(@title, forState:UIControlStateNormal)
  end
  
  def drawRect(rect)
    super
    context = UIGraphicsGetCurrentContext()
    
    if self.state == UIControlStateHighlighted && @backGroundColorRed && @backGroundColorGreen && @backGroundColorBlue
      backgroundColorTop = UIColor.colorWithRed(@backGroundColorRed * 0.8, green:@backGroundColorGreen * 0.8, blue:@backGroundColorBlue * 0.8, alpha:1).CGColor
    else
      backgroundColorTop = @backgroundColorTop.CGColor
    end
    backgroundColorBottom = @backgroundColorBottom.CGColor
    
    outerMargin = 5
    outerRect = CGRectInset(self.bounds, outerMargin, outerMargin)
    outerPath = createRoundedRectForRect(outerRect, @borderRadius)
    
    highlightRect = CGRectInset(outerRect, 2, 3)
    highlightPath = createRoundedRectForRect(highlightRect, @borderRadius - 1)
    
    # Draw Shadow When Not Pressed
    unless self.state == UIControlStateHighlighted
      CGContextSaveGState(context)
      CGContextSetFillColorWithColor(context, backgroundColorTop)
      CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3, UIColor.colorWithWhite(0, alpha:0.5).CGColor)
      CGContextAddPath(context, outerPath)
      CGContextFillPath(context)
      CGContextRestoreGState(context)
    end
    
    # Draw Button Gradient
    CGContextSaveGState(context)
    CGContextAddPath(context, outerPath)
    CGContextClip(context)
    drawLinearGradient(context, outerRect, backgroundColorTop, backgroundColorBottom)
    CGContextRestoreGState(context)
    
    # Draw Highlight or Inner Shadow
    CGContextSaveGState(context)
    if self.state == UIControlStateHighlighted
      CGContextSetLineWidth(context, 4)
      CGContextAddPath(context, outerPath)
      CGContextAddPath(context, highlightPath)
      CGContextEOClip(context)
      drawLinearGradient(context, outerRect, UIColor.colorWithWhite(0, alpha:0.12).CGColor, UIColor.colorWithWhite(0, alpha:0.03).CGColor)
    else
      CGContextSetLineWidth(context, 4)
      CGContextAddPath(context, outerPath)
      CGContextAddPath(context, highlightPath)
      CGContextEOClip(context)
      drawLinearGradient(context, outerRect, UIColor.colorWithWhite(1, alpha:0.2).CGColor, UIColor.colorWithWhite(1, alpha:0.02).CGColor)
    end
    CGContextRestoreGState(context)
    
    # Draw Button Border
    CGContextSaveGState(context)
    CGContextSetLineWidth(context, 1)
    CGContextSetStrokeColorWithColor(context, UIColor.colorWithWhite(0, alpha:0.3).CGColor)
    CGContextAddPath(context, outerPath)
    CGContextStrokePath(context)
    CGContextRestoreGState(context)
    
    # Move Title Label Down When Pressed
    if self.state == UIControlStateHighlighted
      titleLabel.transform = CGAffineTransformIdentity
      titleLabel.transform = CGAffineTransformMakeTranslation(0, 1)
    end
  end
  
  def drawLinearGradient(context, rect, start_color, end_color)
    color_space = CGColorSpaceCreateDeviceRGB()
    locations = Pointer.new(:float, 2)
    locations[1]  = 1.0
    
    colors = [start_color, end_color]
    
    gradient = CGGradientCreateWithColors(color_space, colors, locations)
    
    start_point = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect))
    end_point = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect))
    
    CGContextSaveGState(context)
    CGContextAddRect(context, rect)
    CGContextClip(context)
    CGContextDrawLinearGradient(context, gradient, start_point, end_point, 0)
    CGContextRestoreGState(context)    
  end
  
  def createRoundedRectForRect(rect, radius)
    path = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, CGRectGetMidX(rect), CGRectGetMinY(rect))
    CGPathAddArcToPoint(path, nil, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius)
    CGPathAddArcToPoint(path, nil, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius)
    CGPathAddArcToPoint(path, nil, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius)
    CGPathAddArcToPoint(path, nil, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius)
    CGPathCloseSubpath(path)    
    path
  end
  
  def rgbFromHex(hex)
    hex = hex.gsub(%r{[#;]}, '')
    case hex.size
    when 3
      hex.scan(%r{[0-9A-Fa-f]}).map { |el| (1.0 * (el * 2).to_i(16)) / 255 }
    when 6
      hex.scan(%r<[0-9A-Fa-f]{2}>).map { |el| (1.0 * el.to_i(16)) / 255 }
    else
      raise ArgumentError, 'Argument is not a valid hex code.'
    end
  end
  
  def hesitateUpdate
    self.setNeedsDisplay
  end
  
  def touchesBegan(touches, withEvent:the_event)
    super
    self.setNeedsDisplay
  end
  
  def touchesMoved(touches, withEvent:the_event)
    super
    self.setNeedsDisplay
  end
  
  def touchesCancelled(touches, withEvent:the_event)
    super
    self.setNeedsDisplay
    self.performSelector(:hesitateUpdate, withObject:nil, afterDelay:0.1)
  end
  
  def touchesEnded(touches, withEvent:the_event)
    super
    self.setNeedsDisplay
    self.performSelector(:hesitateUpdate, withObject:nil, afterDelay:0.1)
  end
end