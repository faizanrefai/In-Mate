//
//  BusinessFormat.h
//  Jail Mail
//
//  Created by Openxcell on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "testmapAppDelegate.h"
#import "DAL.h"
#import "PDFHelper.h"
@interface BusinessFormat : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>{
    
    TPKeyboardAvoidingScrollView *scrollView;
	IBOutlet UITextView *txtView;
	IBOutlet UITextField *txtDate;
	IBOutlet UITextField *txtDear;
    IBOutlet UITextField *txtSub;
    IBOutlet UITextField *txtSalutation;
	NSArray *arrSalutations;
	testmapAppDelegate *appdel;
	CGFloat animatedDistance;
	IBOutlet UITextView *txtSignature;
	IBOutlet UIDatePicker *pickerViewDOB;
	UIActionSheet *actionSheetDOB;
	
	BOOL isTrue;
	NSString *strLetName;
	DAL *dal;
	NSMutableDictionary *dict;
    NSString *letter;
    UITextField *pdfPasswordTextField;
    IBOutlet UIButton *btnSubmit;
    IBOutlet UITextView *txtCG;
    IBOutlet UITextView *txtCG1;
    IBOutlet UITextView *txtCG2;
    UIActionSheet *actionSheetSal;
    UIPickerView *pickerViewSal;
    
    UIActionSheet *actionSheetGreet;
    UIPickerView *pickerViewGreet;
    NSArray *arrGreetings;
     UILabel *placeholderLabel;
      UILabel *placeholderLabel1;
    UIBarButtonItem *prevBtn;
    UIBarButtonItem *nextBtn;
     UITextField *activeField;
    UITextView *activeView;
    int flag;
   int saveUpdate;
    int coming;

    
}
@property(nonatomic,retain)IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@end
