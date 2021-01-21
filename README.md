# SSUtilitiesiOS

This is just a holder for all the small things that I have.

## App lifecycle observer
There are 2 types of lifecycle here: app delegate (UIKit) and scene phase (Swift UI). Scene phase at this point still cannot replace all the callback from app delegate, so you might want to reconsider using it. To make the observers work, you need to do one of these two: <br/>
* If you want to use AppDelegate, your AppDelegate class has to extend `SSAppDelegate`
* If you use scene phase, you will need to call `adaptToAppEventEmitter` on your view (if you remove the view with this on, you'll have to call it again on the new view). If you want to listen to app did launch, you'll also need to do the first option and then set it with `@UIApplicationDelegateAdaptor`.

**Note:** if you use SwiftUI lifecycle with `@UIApplicationDelegateAdaptor`, there is a bug that AppDelegate's methods after `appDidLaunchWithOptions` will not get called, so you'll have to use scene phase in complement.

### How to observe app lifecycle events.
You can have multiple observers, just implement `SSAppEventObserver` with neccessary methods.<br/>
If your observer has appDidLaunch method, you'll have to use AppDelegate either as the main life cycle or `@UIApplicationDelegateAdaptor`, and in your main bundle, you'll need to create a plist file named `AppEventObservers.plist`, in this file, make the root an Array and add the class name of each observer to that array.</br/>
Other than that, you can just register/unregister observer directly by calling `SSAppEventManager.shared.registerObserver` or `SSAppEventManager.shared.unregisterObserver`.

## Timer
The default `Timer` doesn't work with backgrounding, so I wrote this class. The usage is similar to `Timer` but will work with backgrounding.

## Other stuff
I also some other little things in here, you can explore if you want.
