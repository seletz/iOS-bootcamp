//
//  QuizAppDelegate.h
//  Quiz
//
//  Created by Stephan Eletzhofer on 08.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

#define RELEASE(x) do { [x release]; x = nil; } while(0)

@interface QuizAppDelegate : NSObject <UIApplicationDelegate> {

	// View Objects
    UIWindow *window;

	// Model Objects
	NSMutableArray *answers;
	NSMutableArray *questions;

	// Object State
	int currentQuestionIndex;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UILabel *answerLabel;


- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end

