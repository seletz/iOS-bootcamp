//
//  TestPloneXMLRPCAppDelegate.m
//  TestPloneXMLRPC
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "TestPloneXMLRPCAppDelegate.h"



#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@implementation TestPloneXMLRPCAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle {{{1

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBGS;

    PloneController *ploneController = [[PloneController alloc] init];

    [ploneController setDelegate: self];

    [ploneController fetchObject:@"news/foo-news"];
    [ploneController fetchObject:@"news/foo-news"];

    [window makeKeyAndVisible];
    return YES;
}

#pragma mark -
#pragma mark PloneControllerDelegate Methods {{{1

- (void)didReceiveObject:(PloneContentModel *)object forPath:(NSString *)path
{
    DBG(object);
    DBG(path);

    NSLog(@"object: retaincount=%d", [object retainCount]);
    NSLog(@"path: retaincount=%d", [path retainCount]);
}

- (void)didFailWithError:(NSError *)error
{
    DBG(error);
}

#pragma mark -
#pragma mark Application lifecycle {{{1

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


@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
