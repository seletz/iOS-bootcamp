//
//  ItemDetailsController.h
//  Homepwner
//
//  Created by Stephan Eletzhofer on 10.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Possession.h"


@interface ItemDetailViewController : UIViewController {

    IBOutlet UILabel         *dateLabel;
    IBOutlet UITextField     *nameField;
    IBOutlet UITextField     *serialNumberField;
    IBOutlet UITextField     *valueField;

    Possession               *editingPossession;

}

@property (nonatomic, retain) Possession *editingPossession;

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
