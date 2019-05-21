

# TweetsFelt iOS Swift App

### Requirements
- [x] Xcode Version 10.1 (10B61) or above
- [x] Swift 4.2
- [x] iOS Version 12.0 or above 
- [x] CocoaPods
- [x] **[cocoapods-keys](https://github.com/orta/cocoapods-keys)**
- [x] Twitter Consumer API Keys, and Consumer API Secret generated for your Approved Twitter App
- [x] Google API Key and also enabled service for Natural Language

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
## Don't try to open the project yet. You need to install following CocoaPods Plugin first.

### Use CocoaPod Keys
Another tool you might have to install is CocoaPod Keys. This CocoaPod plugin is used to securely store the secret keys and various other API keys within mac OS Keychain tool and separate it from the Source code and version control. You can read about it more in following [Cocoapods-keys GitHub](https://github.com/orta/cocoapods-keys) project page.

#### Install it using following command. You may want to use `sudo` sometimes.
```ruby
   gem install cocoapods-keys
```

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

#### Then hit the CocoaPod installation
```ruby
   pod install
```
Then you should be prompt with following to enter the relevant keys and secrets for Twitter API and Google Natural Language API
```ruby
CocoaPods-Keys has detected a keys mismatch for your setup.
What is the key for TwitterConsumerAPIKey
> TWITTER_CONSUMER_API_KEY

Saved TwitterConsumerAPIKey to TweetsFelt.
What is the key for TwitterConsumerAPISecret
> TWITTER_CONSUMER_API_SECRET

Saved TwitterConsumerAPISecret to TweetsFelt.
What is the key for GoogleWebAPIKey
> GOOGLE_API_KEY
```
### Note:
    - **Until you enter these values you won't be able to install the CocoaPods and also project wont be built!**
    - **Everytime you update the Podfile with adding sensitive keys as it's been done above, you would have to hit Pod install to get them integrated within your app.**

### Xcode Project General changes
 - Change the Team to your own Team

## Project Architecture and Related details

Specifics                 | Details
--------------------------|------------------------------------------------------------------------
Architecture - MVC        | For this sort of a simple application, MVC is more than enough. |
Networking - Alamofire    | Check following list of files: <br/>- `Network\NetworkProtocol.swift` <br/>- `Network\NetworkClient.swift` <br/>- `Services\TwitterAPIService.swift`<br/>-  `Services\GoogleNaturalLangAPIService.swift`
| Models                  | All the models used for the app reside within this folder. Almost all the models which are consumed by the Network Services are extending `Mappable` class from `ObjectMapper` library. You can find more details about it by visiting [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper) GitHub Project.
| Views                   | Storyboards and all the other Nib files are included within this folder
| Controllers             | You can find them on its folder `Controller`
|App Preferences          | Used a simple Singleton class to keep the `NSUserDefaults` managed.
|Authentication           | For Twitter web API, to fetch the Twitter timeline for a given screen-name it uses Bearer Token. In order to get the Bearer Token we need two more needs which is identical for our Twitter App, which are Consumer API Key and the Secret Key. <br/> Then for Google Natural Language we need to have that service enabled in Google Cloud console and have a valid Google API Key. Non of these keys are stored within the project sourcecode. 


#### Note:
    - If you found anything wrong which I have done or may be a bug or any improvements suggestion, please help me to improve this codebase.
    - You can always add up your valuable utility methods to this class which is related to the purpose of this library.
    - Don't forget to check out the Demo project simple implementation to get some more ideas.


## License
```sh
Copyright (c) 2018 Randika Vishman
