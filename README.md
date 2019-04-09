
 # JojoCore Framework (iOS)

See I know you are a very smart developer, and there is no doubt about. In some many cases in our experience that we had to re-write the network layer, data layer and every other layer in a specific project. Where we need to duplicate this based abstracted layers to a new project. The worst part is even when you try to amend changes in the previous project and duplicate the changes in everywhere you using the based codes. It’s crazy and time-consuming, you know. We should have a better way of going through things than making our life as crazy as hell. We had to find best alternates to resolve such issues and conflictions, by using some frameworks out there like [Alamofire](https://github.com/Alamofire/Alamofire) [Moya](https://moya.github.io/), all another database, and logger layers as well. I had gone through this road and looking back on my codes and architectures. It’s awesome, but looking at it over and over again. I noticed we can make this perfect that will smooth the way we write code professionally, and also how our junior developers can emulate decisions making in writing codes.  
  
< IMAGE HERE COMPARING BEFORE AND NOW >

So basically JojoCore abstracts development based project ( Network Layer, Environmental, Logger, Data layers, Performance, and Extensions ). It should be simple, intuitive and comprehensive enough that common things are easy.

Some awesome features of JojoCore:  
- Setting up Environment for the different environmental stack (QA, Development,  Production, etc...).  
- In-built network layer.  
- You can inject any DB drivers to the project as you wish.  
- There is a cache helper class.  
- Comes with extensional class properties and methods  
- Lets you define a clear usage of different endpoints with associated enum values.  
- Logger should be done in debug mode, not on production.

## Plist File Configuration <ConfigurationName.plist>

1. Environments 
```xml
This is where you setup the environmental domain for different stacks
e.g

<key>Environments</key>
<dict>
  <key>Development</key>
  <string>http://www.development.io/v2/</string>
  <key>QA</key>
  <string>http://www.qa.io/v2/</string>
</dict>

From above you can reference the environment in (3. Servers).
```
2.  Request Headers
```xml
<key>Headers</key>
<dict>
	 <key>HeaderServer1</key>
	 <dict>
	 <dict/>
<dict/>

From above you can reference the request header in (3. Servers).
```
3.  Servers
```xml
<key>Servers</key>
<dict>
	<key>Server1</key>
	<dict>
		<key>header</key>
		<string>HeaderServer1</string>
		<key>environment</key>
		<string>QA</string>
	</dict>
</dict>

From above you can reference the servers in (4. Modules).
```
4.  Modules
```xml
<key>Modules</key>
<dict>
	<key>Profile</key>
	<dict>
		<key>environmentServer</key>
		<string>Server1</string>
		<key>endpoints</key>
		<dict>
			<key>profileAuthentication</key>
			<dict>
				<key>mock</key>
				<string>/login</string>
				<key>http</key>
				<string>POST</string>
				<key>live</key>
				<string>/login</string>
			</dict>
			<key>profileRegistration</key>
			<dict>
				<key>mock</key>
				<string>/signup</string>
				<key>http</key>
				<string>POST</string>
				<key>live</key>
				<string>/signup</string>
			</dict>
		</dict>
	</dict>
</dict>

At this point is where you setup your modules e.g Registration & Authentication (Profile Module), etc..
```

## Installation

> Note : JojoCore  requires Swift 4.1 (and [Xcode][Swift] 9.3).

### CocoaPods

[CocoaPods][] is a dependency manager for Cocoa projects. To install
JojoCore with CocoaPods:

 1. Make sure CocoaPods is [installed][CocoaPods Installation].

    ```sh
    # Using the default Ruby install will require you to use sudo when
    # installing and updating gems.
    [sudo] gem install cocoapods
    ```

 2. Update your Podfile to include the following:

    ```ruby
    use_frameworks!

    target 'YourAppTargetName' do
        pod 'JojoCore', '~> 0.0.9'
    end
    ```

 3. Run `pod install --repo-update`.

## Usage

1.  AppDelegate setup
```swift
import JojoCore

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
// Override point for customization after application launch.
Module.plistName = "<Configuraion Plist File Name>"
return  true
}
```

2. Module Service Implementation
- Create Module Types :
The module types should be the same as the one in module's key name (4. Modules) Plist File Configuration <ConfigurationName.plist>
```swift
	enum ModuleType : String{
	     case Profile
	}
```
   - Create Endpoint Types : 
   While the endpoints cases should be the same as the one in endpoints' key names  (4. Modules) Plist File Configuration <ConfigurationName.plist>
```swift
	enum EndpointType : String{
	     case profileAuthentication
	     case profileRegistration
	}
```
- Create Service
```swift
class ModuleService {
  let remote = Remote.init()

  func profileAuthentication(_ request: JSON) {
    
       let response = { (response: Response) in
			switch response {
				case .error(let message):
				Logger.log(.i, messages: message)
				case .success(let json):
				Logger.log(.i, messages: "\(json)")
			}
		}
		
        let module: IModule = ModuleExcutor.execute(ModuleType.Profile.rawValue, endPoint: EndpointType.profileAuthentication.rawValue)!
        let builder = RemoteBuilder.init(module: module,request: request, response: response)
        remote.execute(builder)
  }

  func profileRegistration(_ request: JSON) {
        let response = { (response: Response) in
			switch response {
				case .error(let message):
				Logger.log(.i, messages: message)
				case .success(let json):
				Logger.log(.i, messages: "\(json)")
			}
		}
		
        let module: IModule = ModuleExcutor.execute(ModuleType.Profile.rawValue, endPoint: EndpointType.profileRegistration.rawValue)!
        let builder = RemoteBuilder.init(module: module,request: request, response: response)
        remote.execute(builder)
  }
}
```

3. Local DB Setup
   



[CocoaPods]: https://cocoapods.org
[CocoaPods Installation]: https://guides.cocoapods.org/using/getting-started.html#getting-started
[Swift]: https://swift.org/
