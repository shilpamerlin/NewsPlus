# NewsPlus
An app shows latest news feed

- **Swift**: 5
- **Architecture**: MVVM
- **Dependencies**: None
- **Unit Testing**: Wrote test cases to test API response, filter feeds and retreive data from cache 

## PreRequisties
**XCode**: 14.2

### HomeScreen

- Loads data from API
- Added activity indicator to show content loading
- TableView to list feed in Home screen
- **Image caching** to load feed images
- **Displyed custom alert** to notify the app is being used offline
-  **Cahe support - Stored feed data to UserDefaults** in order to work the app in offline mode

#### Filter Screen

- Filter the feed based on type

#### iPad Support

- Added Collectionview to list feed in if the target device is an iPad

## Screenshots


<img width="346" alt="Screen Shot 2023-03-24 at 6 12 59 PM" src="https://user-images.githubusercontent.com/30163040/228371581-a956b1f9-3352-4b4f-8b7d-3ae589c63b42.png">                <img width="549" alt="Screen Shot 2023-03-24 at 6 13 39 PM" src="https://user-images.githubusercontent.com/30163040/228371605-b8acb428-b41a-4488-8e1a-8a158c9a96a3.png">

