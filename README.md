
# TweetsFelt iOS Swift App

### Requirements
- [x] Xcode Version 10.1 (10B61) or above
- [x] Swift 4.2
- [x] CocoaPods
- [x] **[cocoapods-keys](https://github.com/orta/cocoapods-keys)**

## Features

* Fetches Twitter timeline for given user screen name
	* Uses Twitter API - https://developer.twitter.com
* Analyze the sentiment of the Tweets when taps on timeline
	* Uses Google Natural Language API - https://cloud.google.com/natural-language
* Settings for fetching Twitter timeline

## Setup Guide
### Use CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
### Use CocoaPod Keys
Another tool you might have to install is CocoaPod Keys. This CocoaPod plugin is used to securely store the secret keys and various other API keys within mac OS Keychain tool and separate it from the Source code and version control. You can read about it more in following [Cocoapods-keys GitHub](https://github.com/orta/cocoapods-keys) project page.

Following Keys have been defined within the Podfile:
```ruby
plugin 'cocoapods-keys', {
  :project => "TweetsFelt",
  :keys => [
     "TwitterConsumerAPIKey",
     "TwitterConsumerAPISecret",
     "GoogleWebAPIKey"
  ]}
``` 

#### Note:
    - If you found anything wrong which I have done or may be a bug or any improvements suggestion, please help me to improve this codebase.
    - You can always add up your valuable utility methods to this class which is related to the purpose of this library.
    - Don't forget to check out the Demo project simple implementation to get some more ideas.


## License
```sh
Copyright (c) 2018 Randika Vishman