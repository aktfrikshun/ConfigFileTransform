This application contains a utility class that will load a config file at a specified path
and create a hash based on key value pairs found within the file

I chose to include this utility class within a Rais Application to allow for the possibility of demonstrating the functionality from a file picker UI or via curl if that ended up being a future requirement.

If I had to implement this feature for the intended purpose of parsing config files in a fashion that could be shared across the orginazation, I would have probably chosen to make it available as a ruby gem.

The utility class definition is at lib/config_file_transform.rb

The default delimeter will be '=', but an alternate may be specified on initialization

NOTE:
  * if multiple values are specified for the same key, the last value assigned will override the previous values
  * lines starting with '#' will be ignored as comments
  * lines which do not match the key delimeter value pattern will be ignored as erroneous
  * lines which contain multiple delimeters will split on the first delimeter found
  * if the file is not readable or contains no valid key / value pairs, an empty hash will be returned

# run from localhost ( Not yet implemented )
  * rails s
  * open http://localhost:3000 in your browser
  * TODO:  Add file picker in home/index view and pass file path to ConfigFileTransform

# run from curl ( Not yet implemented )
  * rails s
  * curl http://localhost:3000/home/index.json?file_path=some_file_path
  * TODO:  Add JSON response format and return the resulting hash as JSON

# run from rails console
  * rails c
  * ConfigFileTransform.new(some_file_path).to_hash

# run specs (at spec/lib/config_file_transform_spec.rb)
  * rspec
  
# additional features to be considered
  * add support for additional value types if required ( Date, DateTime, etc )
  * add localization support so keys and values can be expressed in other languages and charsets
  * add detailed error messages on invalid config file formats to be returned in result hash
  * load config key/values to env to make them available to application
  * persist and version config key/values and auto restart deployed applications on change
