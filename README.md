# Coding Exercise
iOS Engineer Candidate Code Exercise

### Building the Targets

- This project uses CocoaPods.
- After cloning the project from GitHub, run "pod install" in the project directory.
- Launch the project in Xcode 9 by opening the "CodingExercise.xcworkspace".
- There are two targets that you can build "SimpsonsViewer" and "WireViewer"
- If you need to install CocoaPods, you can look here https://guides.cocoapods.org/using/getting-started.html


### Development Motivations
- After reading the project overview, it became readily apparent that the only differences between the apps where the REST URLs, titles, project settings. That’s when I made the decision to make 2 Targets (“SimpsonsViewer” and “WireViewer”). That way you can easily swap the settings like the Bundle Identifier and share the same code files between the projects. If you look in the file “Constants.swift”, I actually swap out the definitions of a few key Constants based on Swift Active Compilation Conditions that are defined in each target (and left it open ended if you want to do more). “Constants.swift” is the only file in the project that does this to a keep conditionalization to minimum and in a contained place. All of the source / resource files in both apps are shared. The other bonus of separate targets is that you can have an altered storyboard or redefinition of classes per app by just including / excluding files based on the target.
- I also identified that most of the apps’ behavior closely resembled the base Master / Detail App template provided by Xcode. Always being a believer in “if it’s already there, use it”, this seemed like the logical choice. Now, it gets us mostly there with a few exceptions, like the pop out in portrait mode on the iPad. But, I felt those could be worked through if need be, and it’s about 90% there. (Also, it makes the display code dead simple. KISS).
- the JSON processing code was simple enough that a DataTask and the default Apple JSON Serialization was enough to get the job done. I felt a open source library for that would have been overkill. Now, I chose SDWebImage for loading the images because I’ve used it for years in projects that needed image loading and caching. SDWebImage is quick, reliable, and simple to use. CocoaPods is used to incorporate the open source libs.