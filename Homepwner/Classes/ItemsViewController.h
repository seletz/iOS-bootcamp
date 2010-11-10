//
//  ItemsViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemDetailViewController.h"

@interface ItemsViewController : UITableViewController {
    NSMutableArray *possessions;

    // Header
    UIView                  *headerView;

    ItemDetailViewController *detailViewController;
}

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
