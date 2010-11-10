//
//  HomepwnerAppDelegate.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "HomepwnerAppDelegate.h"
#import "ItemsViewController.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@implementation HomepwnerAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application 
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBGS;

    // Create a ItemsViewController
    itemsViewController = [[ItemsViewController alloc] init];

    // create a UINavigationController
    UINavigationController *naviController = [[UINavigationController alloc]
        initWithRootViewController:itemsViewController];


    // Place ItemsViewController's table view in the window hierarchy
    [window setRootViewController:naviController];
    [window makeKeyAndVisible];
    [naviController release];

    return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
