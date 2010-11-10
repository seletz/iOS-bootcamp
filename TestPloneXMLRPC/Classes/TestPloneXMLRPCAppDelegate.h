//
//  TestPloneXMLRPCAppDelegate.h
//  TestPloneXMLRPC
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMLRPC.h"
#import "PloneContentModel.h"
#import "PloneController.h"

@interface TestPloneXMLRPCAppDelegate : NSObject <UIApplicationDelegate, PloneControllerDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

