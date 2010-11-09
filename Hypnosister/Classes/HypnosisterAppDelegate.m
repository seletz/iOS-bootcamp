//
//  HypnosisterAppDelegate.m
//  Hypnosister
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "HypnosisterAppDelegate.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@implementation HypnosisterAppDelegate

#pragma mark -
#pragma mark properties {{{1

@synthesize window;
//@synthesize hypnoView;


#pragma mark -
#pragma mark Application lifecycle {{{1

- (BOOL)                 application:(UIApplication *)application
       didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBGS;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:window.bounds];
    [scrollView setContentSize:CGSizeMake(1024, 1024)];

    UIView *view = [[HypnosisView alloc] initWithFrame:CGRectMake(0, 0, 1024, 1024)];
    [view setBackgroundColor: [UIColor clearColor]];

    // Build view hierarchy
    [scrollView addSubview:view];
    [window addSubview:scrollView];

    [window makeKeyAndVisible];

    return YES;
}


// UIApplication Delegate {{{2
//
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
#pragma mark Memory management {{{1

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


#pragma mark - }}}1
#pragma mark EOF

@end

// vim: set ts=4 sw=4 expandtab tw=78 : 
