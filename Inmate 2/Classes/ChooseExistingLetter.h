//
//  ChooseExistingLetter.h
//  Jail Mail
//
//  Created by girish on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAL.h"
#import "testmapAppDelegate.h"
@interface ChooseExistingLetter : UIViewController<UITableViewDelegate,UITableViewDataSource> {

	NSMutableArray *arrLetterName;
	DAL *dal;
	testmapAppDelegate *appdel;
    IBOutlet UITableView *tblView;
    NSMutableArray *arrBusiness;
}

@end
