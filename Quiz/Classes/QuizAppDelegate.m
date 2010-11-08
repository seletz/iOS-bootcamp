//
//  QuizAppDelegate.m
//  Quiz
//
//  Created by Stephan Eletzhofer on 08.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "QuizAppDelegate.h"

@implementation QuizAppDelegate

@synthesize window;
@synthesize questionLabel;
@synthesize answerLabel;


#pragma mark -
#pragma mark Application lifecycle {{{1


- (id)init
{
	if (self = [super init]) {
		answers = [[NSMutableArray alloc] init];
		questions = [[NSMutableArray alloc] init];

		[questions addObject:@"What time is it?"];
		[answers addObject:@"I don't know dumbo"];

		[questions addObject:@"What is your name?"];
		[answers addObject:@"I don't know either"];

	}
	return self;
}

#pragma mark -
#pragma mark Application delegate methods {{{1


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
	[self showQuestion:nil];
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
#pragma mark actions {{{1

- (IBAction)showQuestion:(id)sender
{
	DBGS;

	currentQuestionIndex += 1;
	currentQuestionIndex = currentQuestionIndex % [questions count];

	NSString *question = [questions objectAtIndex:currentQuestionIndex];

	[questionLabel setText:question];
	[answerLabel setText:@"???"];
}

- (IBAction)showAnswer:(id)sender
{
	DBGS;

	NSString *answer = [answers objectAtIndex:currentQuestionIndex];
	[answerLabel setText:answer];
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
	[questions release];
	[answers release];
    [super dealloc];
}


@end
