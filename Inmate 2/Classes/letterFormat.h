//
//  letterFormat.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "photoView.h"
#import "testmapAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "DAL.h"
@class letterView;
@interface letterFormat : UIViewController<UIScrollViewDelegate,UITextViewDelegate> {
	photoView *photoViewController;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UITextView *txtView;
	IBOutlet UITextField *txtDate;
	IBOutlet UITextField *txtDear;
	IBOutlet UILabel *lblSinc;
	IBOutlet UILabel *lblSig;
	testmapAppDelegate *appdel;
	CGFloat animatedDistance;
	IBOutlet UITextView *txtSignature;
	IBOutlet UIDatePicker *pickerViewDOB;
	UIActionSheet *actionSheetDOB;
	letterView *letterView;
	BOOL isTrue;
	NSString *strLetName;
	DAL *dal;
	NSMutableDictionary *dict;
    NSString *letter;
    UITextField *pdfPasswordTextField;
    IBOutlet UIButton *btnSubmit;
    IBOutlet UITextView *txtCG;
    NSArray *arrSalutations;
    IBOutlet UITextField *txtSign;
    UIActionSheet *actionSheetSal;
    UIPickerView *pickerViewSal;
    IBOutlet UITextView *txtCGSign;
    UIActionSheet *actionSheetGreet;
    UIPickerView *pickerViewGreet;
    NSArray *arrGreetings;
    
    UIBarButtonItem *prevBtn;
    UIBarButtonItem *nextBtn;
    UITextField *activeField;
    UITextView *activeView;
    int flag;
    UILabel *placeholderLabel;
    UILabel *placeholderLabel1;
    IBOutlet UITextField *txtSubject;
    IBOutlet UITextView *txtCG2;
    int saveUpdate;
    int coming;
    

    
}

@property(nonatomic, retain)letterView *letterView;
//@property(nonatomic,retain)IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property(nonatomic,retain)UITextField *txtDate;
@property(nonatomic,retain)UITextView *txtView;
@property(nonatomic,retain)UITextView *txtSignature;
@property(nonatomic,retain)UITextField *txtDear;
-(IBAction) btnSubmit :(id)sender;
-(IBAction) back :(id)sender;
-(IBAction)click:(id)sender;
@end
