# Easy Button for RubyMotion

A nice looking button in RubyMotion that extends the UIButton class and adds a couple properties for easy styling.

Just pass a single hex value to `backgroundColor` and get a nice gradient button with a shadow.

You can also more easily set the `font` and `title` for the button's label. Everything else works just like a UIButton!

# Install

I find it very easy to use Bundler to manage gems in RubyMotion.

Rakefile

```ruby
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Testing'
end
```

Gemfile

```ruby
source :rubygems

gem 'easy-button', :git => 'git://github.com/brianpattison/easy-button.git'
```

Run `bundle install`.

# Usage

```ruby
@button = EasyButton.alloc.initWithFrame([[10, 160], [300, 80]])
@button.backgroundColor = '#ff0000'
@button.font = UIFont.boldSystemFontOfSize(26)
@button.title = "That Was Easy!"
```

# Screenshot

![Easy Button Screenshot](http://www.brianpattison.com/images/easy-button.png)

# Thanks

Thanks to [@seanlilmateus](https://github.com/seanlilmateus) for the inspiration and a bunch of code from [CoolButton](https://github.com/seanlilmateus/CoolButton)!