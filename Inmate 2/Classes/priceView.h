//
//  priceView.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testmapAppDelegate.h"

@interface priceView : UIViewController {

	NSArray *array;
	IBOutlet UITableView *tblPrices;
	UILabel *txtViewDescription;
    testmapAppDelegate *appdel;
	
}
-(IBAction)backButton;
@end
