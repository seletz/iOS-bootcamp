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

    NSURL *URL = [NSURL URLWithString: @"http://127.0.0.1:8080/plone"];
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: URL];
    XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];


    NSArray *params = [[NSArray alloc] initWithObjects:@"news/foo-news", nil];
    [request setMethod: @"get_object" withParameter:params];
    NSLog(@"Request body: %@", [request body]);
    [manager spawnConnectionWithXMLRPCRequest: request delegate: self];

    [window makeKeyAndVisible];

    [params release];
    [request release];
    return YES;
}

#pragma mark -
#pragma mark XMLRPCConnectionDelegate Methods {{{1

- (void)    request: (XMLRPCRequest *)request
 didReceiveResponse: (XMLRPCResponse *)response
{
    DBGS;

    id object = [response object];

    DBG(object);
}


- (void)    request:(XMLRPCRequest *)request
   didFailWithError: (NSError *)error;
{
    DBGS;
}

- (BOOL)request: (XMLRPCRequest *)request canAuthenticateAgainstProtectionSpace: (NSURLProtectionSpace *)protectionSpace
{
    DBGS;
    return NO;
}

- (void)request: (XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    DBGS;
}

- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    DBGS;
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
