//
//  HeavyRotationAppDelegate.m
//  HeavyRotation
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeavyRotationAppDelegate.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@implementation HeavyRotationAppDelegate

@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    HeavyViewController *viewController = [[HeavyViewController alloc] init];

    [window setRootViewController:viewController];
    [window makeKeyAndVisible];

    [[NSNotificationCenter defaultCenter]
        addObserver: self
           selector: @selector(notificationReceived:)
               name: nil
             object: nil];

    [[NSNotificationCenter defaultCenter]
        addObserver: self
           selector: @selector(orientationChanged:)
               name: UIDeviceOrientationDidChangeNotification
             object: [UIDevice currentDevice]];


    [viewController release];
    return YES;
}


// {{{2
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}
// }}}2

#pragma mark -
#pragma mark Notification Handling {{{1

- (void)notificationReceived:(NSNotification *)note
{
    DBG(note.name);
}

- (void)orientationChanged:(NSNotification *)note
{
    DBGS;
    NSLog(@"orientation -> %d", [[note object] orientation]);
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
