//
//  ExistCreditCard.h
//  testmap
//
//  Created by Hirak on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testmapAppDelegate.h"
#import "DAL.h"
@class testmapAppDelegate;
@interface ExistCreditCard : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
	IBOutlet UITableView *tblView;
	testmapAppDelegate *appDel;
	NSMutableArray *retrivedata;
	DAL *dal;
}
@property (nonatomic,retain) UITableView *tblView;

@end
