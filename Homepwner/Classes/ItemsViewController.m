//
//  ItemsViewController.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "ItemsViewController.h"
#import "Possession.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@implementation ItemsViewController

#pragma mark -
#pragma mark initializers {{{1

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];

    // Create an array of 10 random possession objects
    possessions = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [possessions addObject:[Possession randomPossession]];
    }

    // configure the navigation bar item which will be used by the
    // UINavigationController controlling us
    self.navigationItem.leftBarButtonItem  = self.editButtonItem;

    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (id)headerView
{
    if(headerView)
        return headerView;

    // Create a UIButton object, simple rounded rect style
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    // Set the title of this button to "Edit"
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];

    // How wide is the screen?
    float w = [[UIScreen mainScreen] bounds].size.width;

    // Create a rectangle for the button
    CGRect editButtonFrame = CGRectMake(8.0, 8.0, w - 16.0, 30.0);  
    [editButton setFrame:editButtonFrame];

    // When this button is tapped, send the message 
    // editingButtonPressed: to this instance of ItemsViewController
    [editButton addTarget:self 
                   action:@selector(editingButtonPressed:) 
         forControlEvents:UIControlEventTouchUpInside];

    // Create a rectangle for the headerView that will contain the button
    CGRect headerViewFrame = CGRectMake(0, 0, w, 48);
    headerView = [[UIView alloc] initWithFrame:headerViewFrame];

    // Add button to the headerView's view hierarchy
    [headerView addSubview:editButton];

    return headerView;
}

#pragma mark -
#pragma mark actions {{{1

- (IBAction)editingButtonPressed:(id)sender
{
    DBGS;

    if (self.editing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

#pragma mark -
#pragma mark UITableView delegate methods {{{1

- (UIView *)    tableView:(UITableView *)tableView
   viewForHeaderInSection:(NSInteger)section
{
    DBGS;

    return self.headerView;
}

- (CGFloat)    tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return headerView.bounds.size.height;
}

#pragma mark -
#pragma mark data source delegate methods {{{1

// basic cell handling {{{2
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    DBGS;

    int rows = [possessions count];

    return self.editing ? rows+1 : rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBGS;
    DBG(indexPath);

    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell = 
        [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];

    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        NSLog(@"allocating new cell ...");
        cell = [[[UITableViewCell alloc] 
                    initWithStyle:UITableViewCellStyleDefault 
                  reuseIdentifier:@"UITableViewCell"] autorelease];
    }

    // If the table view is filling a row with a possession in it, do as normal 
    if ([indexPath row] < [possessions count]) {
        // set data in cell returned
        Possession *p = [possessions objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[p description]];
    } else {
        // Otherwise, if we are editing we have one extra row - place this text in that row
        [[cell textLabel] setText:@"Add New Item..."];
    }

    return cell;
}

// }}}2


// editing and deleting {{{2
- (BOOL)        tableView:(UITableView *)tableView
    canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBGS;
    DBG(indexPath); // XXX: first (0) index is section :p
    //NSLog(@"index: %d", [indexPath indexAtPosition:1]);
    //return [indexPath indexAtPosition:1]%2 == 0?YES:NO;
    return YES;
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    DBGS;

    // Always call super implementation of this method, it needs to do work
    [super setEditing:flag animated:animated];

    // You need to insert/remove a new row in to table view
    if (flag) {
        // If entering edit mode, we add another row to our table view
        NSIndexPath *indexPath = 
            [NSIndexPath indexPathForRow:[possessions count] inSection:0];
        NSArray *paths = [NSArray arrayWithObject:indexPath];
        [[self tableView] insertRowsAtIndexPaths:paths
                                withRowAnimation:UITableViewRowAnimationLeft];  
    } else {
        // If leaving edit mode, we remove last row from table view
        NSIndexPath *indexPath = 
            [NSIndexPath indexPathForRow:[possessions count] inSection:0];
        NSArray *paths = [NSArray arrayWithObject:indexPath];
        [[self tableView] deleteRowsAtIndexPaths:paths 
                                withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    DBGS;
    if ([self isEditing] && [indexPath row] == [possessions count]) {
        // During editing...
        // The last row during editing will show an insert style button
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}


- (void)        tableView:(UITableView *)tableView
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBGS;

    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            NSLog(@"handling delete command");
            [possessions removeObjectAtIndex: [indexPath row]];
            [tableView reloadData];
            //[tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject:indexPath]
            //                 withRowAnimation: UITableViewRowAnimationFade];
            break;
        case UITableViewCellEditingStyleInsert:
            NSLog(@"handling insert command");
            [possessions addObject:[Possession randomPossession]];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                             withRowAnimation:UITableViewRowAnimationLeft];
            break;

        default:
            NSLog(@"Unhandled editing style: %d", editingStyle);
            break;
    }
}


// }}}2

// reordering {{{2

- (BOOL)        tableView:(UITableView *)tableView 
    canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
    DBGS;
    // Only allow rows showing possessions to move
    if ([indexPath row] < [possessions count])
        return YES;
    return NO;
}

- (NSIndexPath *)                   tableView:(UITableView *)tableView 
     targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath 
                          toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    DBG(sourceIndexPath);
    DBG(proposedDestinationIndexPath);

    if ([proposedDestinationIndexPath row] < [possessions count]) {
        // If we are moving to a row that currently is showing a possession,
        // then we return the row the user wanted to move to
        return proposedDestinationIndexPath;
    }
    // Execution gets here if we are trying to move a row to underneath the "Add New Item..."
    // row, have the moving row go one row above it instead.
    NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[possessions count] - 1 
                                                      inSection:0];
    return betterIndexPath;
}



- (void)        tableView:(UITableView *)tableView
       moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
              toIndexPath:(NSIndexPath *)toIndexPath
{
    DBGS;

    // Get pointer to object being moved
    Possession * p = [possessions objectAtIndex:[fromIndexPath row]];

    // Retain it... (retain count = 2, 1 for scope of this method, 1 for being inside array)
    [p retain];

    // Remove p from our array, it is automatically sent release (retain count of p = 1)
    [possessions removeObjectAtIndex:[fromIndexPath row]];

    // Re-insert p into array at new location, it is automatically retained (retain count of p = 2)
    [possessions insertObject:p atIndex:[toIndexPath row]];

    // Release p (retain count = 1, only owner is now array)
    [p release];

}

// }}}2

#pragma mark -
#pragma mark memory management {{{1

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [possessions release];
    [super dealloc];
}


@end
// vim: set ts=4 sw=4 expandtab tw=78 : 

