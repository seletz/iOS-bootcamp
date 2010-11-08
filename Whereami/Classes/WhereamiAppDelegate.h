//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Stephan Eletzhofer on 08.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKMapView.h>

#import "MKMapView+ZoomLevel.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

#define RELEASE(x) do { [x release]; x = nil; } while(0)

@interface WhereamiAppDelegate : NSObject <UIApplicationDelegate, UITextFieldDelegate, CLLocationManagerDelegate> {
    UIWindow *window;

    CLLocationManager           *locationManager;

    UITextField                 *textField;
    MKMapView                   *mapView;
    UIActivityIndicatorView     *activityIndicator;
    UISlider                    *distanceSlider;

    // controller state
    CLLocation                  *currentLocation;
    NSNumber                    *currentDistance;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UISlider *distanceSlider;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

- (IBAction)locationEntered:(id)sender;
- (IBAction)distanceChanged:(id)sender;

@end

// vim: set ts=4 sw=4 expandtab:
