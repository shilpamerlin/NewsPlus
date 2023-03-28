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

**Features should have added if got more time**
1. Implemented news details screen of each feed
2. Added more tilter option other than type with separate sections for each filter type
3. Added location along with date when diaplaying the feed
4. Create separate sections for 


