//
//  ItemsViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewController : UITableViewController {
    NSMutableArray *possessions;

    // Header
    UIView         *headerView;
}

-(UIView *)headerView;

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
