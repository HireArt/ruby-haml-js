# Ruby HAML-JS

Precompiles the HAML-JS templates into a function.

# Compatibility

This gem is compatible with Sprocket 2 and 3 only.

Due to changes in the transformer/processor interface of Sprockets 4, Tilt (this gem relies on the Tilt::Template class) can't work with Sprockets 4 as expected anymore.

Reference: [Tilt's issue.](https://github.com/rtomayko/tilt/issues/292#issuecomment-236549078)

# How to use

This can be used as a standalone template or as part of Rails 3.1 assets pipeline.

For example, if you have a file `app/assets/javascripts/templates/comment.jst.hamljs` with the following content:

```haml
.comment
  .author= author
  .text= text
```

Then it will be *compiled* on the server side into a plain JavaScript function.
It doesn't require you to do anything on the client side.
And the result will look like this:

```javascript
(function() {
  this.JST || (this.JST = {});
  this.JST["templates/comment"] = function (locals) { function html_escape(text) {
      return (text + "").
        replace(/&/g, "&amp;").
        replace(/</g, "&lt;").
        replace(/>/g, "&gt;").
        replace(/\"/g, "&quot;");
    }
  with(locals || {}) {
    try {
     var _$output="<div class=\"comment\"><div class=\"author\">" + 
  html_escape(author) + 
  "</div><div class=\"text\">" + 
  html_escape(text) + 
  "</div></div>";
   return _$output;  } catch (e) {
      return "\n<pre class='error'>" + html_escape(e.stack) + "</pre>\n";
    }
  }
  };
}).call(this);
```

Then you access that template like so:

```javascript
var commentView = JST['templates/comment'];
// ...
// Somewhere in your code later:
var html = commentView({author: 'Dima', text: 'Looks nice'});
```

# Installation

```ruby
# Gemfile
gem 'ruby-haml-js'
```

```bash
# Then install it
bundle
```

# Usage - with Rails 3.1 assets pipeline

1. Put your template unders `app/assets/javascripts` (or other path where Rails can find it).
2. Use the naming `my-template.jst.hamljs`.
3. Serve the template to browser by `require my-template` from `application.js` or link to it as `my-template.js`
4. Use the template from the JavaScript: `JST['my-template']({your: 'local', variables: 'go here'})`


# Configuration

## Custom HTML escape

You can change the escape function from the built-in, autogenerated to your own:

```ruby
# Set it somewhere, before generating the template.
# Good place can be a Rails initializer.
RubyHamlJs::Template.custom_escape = "App.escape_html"
```

This will use the given function and will not generate custom escape code inside each template.
But you need to make sure that the function is defined before using the templates in JavaScript.

## Custom haml.js

If you need a custom version of haml.js library you may specify it using the haml_path

```ruby
RubyHamlJs::Template.haml_path = "path/to/haml.js"
```

# Development

- Source hosted at [GitHub](https://github.com/dnagir/ruby-haml-js)
- Report issues and feature requests to [GitHub Issues](https://github.com/dnagir/ruby-haml-js/issues)

Pull requests are very welcome! But please write the specs.

To start, clone the repo and then:

```shell
bundle install
bundle exec rspec spec/
```
