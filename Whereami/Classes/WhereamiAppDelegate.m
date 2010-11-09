//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Stephan Eletzhofer on 08.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "WhereamiAppDelegate.h"

@implementation WhereamiAppDelegate

#pragma mark -
#pragma mark properties {{{1

@synthesize window;

@synthesize textField;
@synthesize activityIndicator;
@synthesize distanceSlider;
@synthesize mapView;

#pragma mark -
#pragma mark Application lifecycle {{{1

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBGS;

    // safeguard against forgotten IB outlets
    assert(window);
    assert(textField);
    assert(activityIndicator);
    assert(distanceSlider);
    assert(mapView);

    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];

    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];

    [textField setDelegate:self];
    [window makeKeyAndVisible];
    return YES;
}


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
#pragma mark UI Update {{{1

- (void)updateUI
{
    DBGS;
    DBG(currentLocation);

    int zoom = distanceSlider.value;

    NSLog(@"zoom=%d", zoom);

    // Update the MapKit View
    [mapView setCenterCoordinate: [currentLocation coordinate]
                       zoomLevel: zoom
                        animated: YES];
}

#pragma mark -
#pragma mark Accessors {{{1

- (CLLocation *)currentLocation
{
    return currentLocation;
}

- (void)setCurrentLocation:(CLLocation *)loc
{
    DBG(loc);

    [loc retain];
    [currentLocation release];
    currentLocation = loc;
}

#pragma mark -
#pragma mark Actions {{{1

- (IBAction)locationEntered:(id)sender
{
    DBGS;

    DBG(textField.text);

    [self updateUI];
}

- (IBAction)distanceChanged:(id)sender
{
    DBGS;
    [self updateUI];
}

#pragma mark -
#pragma mark Location Manager Delegate {{{1

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    DBGS;
    DBG(newLocation);

    self.currentLocation = newLocation;

    [self updateUI];
}

#pragma mark -
#pragma mark UITextFieldDelegate methods {{{1

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    DBGS;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    DBGS;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DBGS;
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    DBGS;
    return YES;
}
    
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DBGS;

    // make the keyboard actually go away by telling teh textfield
    // to resign its first responder status
    [textField resignFirstResponder];
    return NO;
    
}

#pragma mark -
#pragma mark Memory management {{{1

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [locationManager setDelegate:nil];
    [locationManager release];

    [window release];
    [super dealloc];
}


@end // }}}

// vim: set ts=4 sw=4 expandtab:
