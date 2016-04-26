//
//  ExistInmate.h
//  testmap
//
//  Created by Hirak on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testmapAppDelegate.h"
@class DAL;
@interface ExistInmate : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
	testmapAppDelegate *appDel;
	IBOutlet UITableView *tblView;
	//IBOutlet UIView *infoView;
	
	IBOutlet UILabel *lblUname;
	IBOutlet UILabel *lblUAdd;
	IBOutlet UILabel *lblUCity;
	IBOutlet UILabel *lblUState;
	IBOutlet UILabel *lblUZip;
	IBOutlet UILabel *lblid;
	IBOutlet UILabel *lblIName;
	IBOutlet UILabel *lblIAdd;
	IBOutlet UILabel *lblICity;
	IBOutlet UILabel *lblIState;
	IBOutlet UILabel *lblIZip;
	
	NSMutableArray *arrInmateName;
	DAL *dal;
}
@property (nonatomic,retain)UITableView *tblView;

-(IBAction) submitClicked:(id)sender;
@end
