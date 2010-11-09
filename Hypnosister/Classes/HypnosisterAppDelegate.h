//
//  HypnosisterAppDelegate.h
//  Hypnosister
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HypnosisView.h"

@interface HypnosisterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;

    //Subview
    //UIView                  *hypnoView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet UIWindow *hypnoView;

@end

// vim: set ts=4 sw=4 expandtab tw=78 : 

