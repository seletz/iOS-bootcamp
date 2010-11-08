//
//  QuizAppDelegate.h
//  Quiz
//
//  Created by Stephan Eletzhofer on 08.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

