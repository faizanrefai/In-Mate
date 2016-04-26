//
//  benefitsView.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "moneyView.h"
#import "testmapAppDelegate.h"
@class moneyView;
@interface benefitsView : UIViewController<UITableViewDataSource,UITableViewDelegate> {

	NSArray *array;
	moneyView *moneyview;
    IBOutlet UITableView *TBL;
    UILabel *txtViewDescription;
    testmapAppDelegate *appdel;
}
-(IBAction)onBack:(id)sender;


@end
