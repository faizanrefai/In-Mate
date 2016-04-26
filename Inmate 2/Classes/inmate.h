//
//  inmate.h
//  testmap
//
//  Created by Hirak on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testmapAppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"
@class DAL;
@class PdfController;

@interface inmate : UIViewController <UITextFieldDelegate,UIScrollViewDelegate>
{
	TPKeyboardAvoidingScrollView  *scrollView;
	
	IBOutlet UITextField *fldUName;
	IBOutlet UITextField *fldUAdd;
	IBOutlet UITextField *fldUCity;
	IBOutlet UITextField *fldUState;
	IBOutlet UITextField *fldUZip;
    IBOutlet UITextField *fldULastName;
    
	
	IBOutlet UITextField *fldID;
	IBOutlet UITextField *fldIName;
    IBOutlet UITextField *fldILastName;
    IBOutlet UITextField *fldIInstituteName;;
    
	IBOutlet UITextField *fldIAdd;
	IBOutlet UITextField *fldICity;
	IBOutlet UITextField *fldIZip;
    IBOutlet UITextField *fldEmail;
    IBOutlet UITextField *fldIState;
    IBOutlet UITextField *fldBed;
	testmapAppDelegate *appDel;
    UITextField *activeField;
	
    UIBarButtonItem *prevBtn;
    UIBarButtonItem *nextBtn;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnNext;
	//IBOutlet UIView *infoView;
	IBOutlet UIView *mainView;
	UIButton *doneButton;
	CGFloat animatedDistance;
	DAL *dal;
    UIActionSheet *actionSheetState;
    UIPickerView *pickerState;
	
	NSMutableArray *array;
    NSArray *arrState;
    BOOL *isState;
    
    
    IBOutlet UIToolbar *toolbar;
}

@property (nonatomic,retain)IBOutlet TPKeyboardAvoidingScrollView  *scrollView;
- (void)addButtonToKeyboard;
-(IBAction) submitClicked:(id)sender;
-(IBAction) saveClicked:(id)sender;
@end
