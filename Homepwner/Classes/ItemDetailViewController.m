//
//  ItemDetailsController.m
//  Homepwner
//
//  Created by Stephan Eletzhofer on 10.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "ItemDetailViewController.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)


@implementation ItemDetailViewController

@synthesize editingPossession;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    DBGS;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    DBGS;
    [super viewWillAppear:animated];

    // Use properties of incoming possession to change user interface
    [nameField setText:[editingPossession possessionName]];
    [serialNumberField setText:[editingPossession serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d", 
                                             [editingPossession valueInDollars]]];

    // Create a NSDateFormatter... we filter NSDate objects through this formatted
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] 
                                            autorelease];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];

    // Use filtered NSDate object to return string to set dateLabel contents
    [dateLabel setText:
        [dateFormatter stringFromDate:[editingPossession dateCreated]]];
    // Change the nav item to display name of possession
    [[self navigationItem] setTitle:[editingPossession possessionName]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    DBGS;
    [super viewWillDisappear:animated];

    // resign all firstResponer status to get rid of them keyboards
    [nameField resignFirstResponder];
    [valueField resignFirstResponder];
    [serialNumberField resignFirstResponder];

    // Save Values
    editingPossession.possessionName = nameField.text;
    editingPossession.serialNumber = serialNumberField.text;
    editingPossession.valueInDollars = [[valueField text] intValue];
}

- (void)viewDidUnload
{
    DBGS;
    [nameField release];
    nameField = nil;

    [valueField release];
    valueField = nil;

    [serialNumberField release];
    serialNumberField = nil;

    [dateLabel release];
    dateLabel = nil;

    [editingPossession release];
    editingPossession = nil;

    [super viewDidUnload];
}


- (void)dealloc {
    [nameField release];
    [valueField release];
    [serialNumberField release];
    [dateLabel release];
    [editingPossession release];

    [super dealloc];
}


@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
