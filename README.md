# This application contains a utility class that will load a config file at a specified path
# and create a hash based on key value pairs found within the file
# class definition is at lib/config_file_transform.rb

# The default delimeter will be '=', but an alternate may be specified on initialization

# NOTE:
  * if multiple values are specified for the same key, the last value assigned will override the previous values
  * lines starting with '#' will be ignored as comments
  * lines which do not match the key delimeter value pattern will be ignored as erroneous
  * lines which contain multiple delimeters will split on the first delimeter found
  * if the file is not readable or contains no valid key / value pairs, an empty hash will be returned

* run from localhost
rails s
open http://localhost:3000 in your browser
TODO:  Add file picker in home/index view and pass file path to ConfigFileTransform

* run from curl
rails s
curl http://localhost:3000/home/index.json?file_path=some_file_path
TODO:  Add JSON response format and return the resulting hash as JSON

* run from rails console
rails c
ConfigFileTransform.new(some_file_path).to_hash

* run specs (at spec/lib/config_file_transform_spec.rb)
rspec
