//
//  moneyView.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionoptView.h"
#import "DAL.h"
@class SelectionoptView;
#import "NumberKeypadDecimalPoint.h"
@interface moneyView : UIViewController <UITextFieldDelegate,UIActionSheetDelegate>{

	SelectionoptView *SelectionoptViewController;
	IBOutlet UITextField *txtamount;
	CGFloat animatedDistance;
	UIButton *doneButton;
	NSString *strdone;
    testmapAppDelegate *appdel;
    int amount;
    IBOutlet UILabel *lblAmt;
    DAL *dal;
    IBOutlet UIButton *btnSubmit;
    NumberKeypadDecimalPoint *numberKeyPad;
    
  
}
-(IBAction) btnSubmit ;
@property (nonatomic, retain) NumberKeypadDecimalPoint *numberKeyPad;
@property(nonatomic,retain)UIButton *doneButton;
- (void)addButtonToKeyboard;
- (IBAction) backgroundTap;
@end
