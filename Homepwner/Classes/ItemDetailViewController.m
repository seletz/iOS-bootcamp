//
//  ItemDetailsController.m
//  Homepwner
//
//  Created by Stephan Eletzhofer on 10.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ImageCache.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)


@implementation ItemDetailViewController

@synthesize editingPossession;

#pragma mark -
#pragma mark initializer {{{1

- (id)init
{
    [super initWithNibName:@"ItemDetailViewController" bundle:nil];

    // create a button for the navigation bar which causes
    // the image picker to be load.
    UIBarButtonItem *cameraBarButtonItem = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                             target:self
                             action:@selector(takePicture:)];

    // place the bar button
    [[self navigationItem] setRightBarButtonItem: cameraBarButtonItem];

    [cameraBarButtonItem release];
    return self;
}

- (id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle
{
    return [self init];
}

#pragma mark -
#pragma mark actions {{{1

- (IBAction)takePicture:(id)sender
{
    DBGS;
    [[self view] endEditing:YES];

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

    // If our device has a camera, we want to take a picture, otherwise, we just 
    // pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    else
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];

    // image picker needs a delegate so we can respond to its messages
    [imagePicker setDelegate:self];

    // Place image picker on the screen -- NEW
    //if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //if(imagePickerPopover)
            //[imagePickerPopover release];
        //imagePickerPopover = [[UIPopoverController alloc] 
            //initWithContentViewController:imagePicker];
        //[imagePickerPopover setDelegate:self];
        //[imagePickerPopover presentPopoverFromBarButtonItem:sender 
                                   //permittedArrowDirections:UIPopoverArrowDirectionAny 
                                                   //animated:YES];
    //} else {
        [self presentModalViewController:imagePicker animated:YES];
    //}


    // The image picker will be retained until it has been dismissed
    [imagePicker release];
}

#pragma mark -
#pragma mark UIImagePickerController Delegate {{{1

- (void)       imagePickerController:(UIImagePickerController *)picker
       didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    DBG(info);

    NSString *oldKey = [editingPossession imageKey];

    // Did the possession already have an image?
    if (oldKey) {

        // Delete the old image
        [[ImageCache sharedImageCache] deleteImageForKey:oldKey];
    }

    // Get picked image from info dictionary
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];


    // Create a CFUUID object - it knows how to create unique identifiers
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);

    // Create a string from unique identifier
    CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);

    // Use that unique ID to set our possessions imageKey
    [editingPossession setImageKey:(NSString *)newUniqueIDString];

    // We used "Create" in the functions to generate objects, we need to release them
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);

    // Store image in the ImageCache with this key
    [[ImageCache sharedImageCache] setImage:image forKey:[editingPossession imageKey]];

    // Put that image on to the screen in our image view
    [imageView setImage:image];

    // Take image picker off the screen
    [self dismissModalViewControllerAnimated:YES];
    // IPAD STUFF
    //[imagePickerPopover dismissPopoverAnimated:YES];
}


#pragma mark -
#pragma mark view handling {{{1

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

    // Image Cache Stuff
    NSString *imageKey = [editingPossession imageKey];
    if (imageKey) {
        // Get image for image key from image cache
        UIImage *imageToDisplay = [[ImageCache sharedImageCache] imageForKey:imageKey];

        // Use that image to put on the screen in imageView
        [imageView setImage:imageToDisplay];
    } else {
        // Clear the imageView
        [imageView setImage:nil];
    }

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

    [imageView release];
    imageView = nil;

    [super viewDidUnload];
}

#pragma mark -
#pragma mark memory handling {{{1

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [nameField release];
    [valueField release];
    [serialNumberField release];
    [dateLabel release];
    [imageView release];
    [editingPossession release];

    [super dealloc];
}


@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
