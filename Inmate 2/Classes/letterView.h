//
//  letterView.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "letterFormat.h"
#import "testmapAppDelegate.h"
#import "DAL.h"
@class letterFormat;
@interface letterView : UIViewController <UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
	letterFormat *letterFormatViewController;
	IBOutlet UITableView *tblFont;
	NSMutableArray *arrFontName;
	testmapAppDelegate *appdel;
	IBOutlet UIPickerView *pickerViewCBrand;
	IBOutlet UITextField *carbrandtext;
	IBOutlet UIActionSheet *actionSheetCBrand;
	IBOutlet UIButton *btnBussiness;
	IBOutlet UIButton *btnFrd;
    UITextField *txtLetName;
    NSString *letterName;
    IBOutlet UIButton *btnNext;
    BOOL *isFrd;
    BOOL *isBusiness;
    DAL *dal;
    
    
}
@property (nonatomic ,retain) NSString *letterName;
@property (nonatomic ,retain) UITableView *tblFont;
@property (nonatomic ,retain) UITextField *txtLetName;
-(IBAction)clickFrd:(id)sender;
-(IBAction)clickBusiness:(id)sender;
-(IBAction) btnFont :(id)sender;
-(IBAction) btnnext :(id)sender;
@end
