//
//  CreditCard.h
//  testmap
//
//  Created by Hirak on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "thankyouView.h"
#import "testmapAppDelegate.h"
#import "DAL.h"
#import "Reachability.h"
//#import "MobileDeviceLoginRequest.h"
//#import "AuthNet.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "photoView.h"
#import "thankyouView.h"
#import <SystemConfiguration/SystemConfiguration.h>

//#import "AuthNetUnitTests.h"
@interface CreditCard : UIViewController <UITextFieldDelegate,UIScrollViewDelegate,MFMailComposeViewControllerDelegate>
{
	DAL *dal;
    Reachability* reachability;
    BOOL isInternetAvailable;
	IBOutlet UITextField *tfldNumber;
	IBOutlet UITextField *tfldHolder;
	IBOutlet UITextField *tfldDate;
	IBOutlet UITextField *tfldCode;
	IBOutlet UITextField *tfldType;
    IBOutlet UITextField *tfldEmail;
   	IBOutlet UIScrollView *scroll;
	CGFloat animatedDistance;
	testmapAppDelegate *appDel;
	NSMutableArray *arrCreditDet;
    NSMutableArray *arrNsImages;
    NSString *sessionToken;
    photoView *photoObj;
    thankyouView *objThanks;
    NSString * ccNumber;
    NSString *emailBody;
    NSString *strNew;
    NSData *data;
    IBOutlet UIButton *btnDone;
    UIActionSheet *actionSheetCBrand;
    UIPickerView *pickerViewCBrand;
    NSArray *arrCardType;
    UITextField *activeField;
    //AuthNetUnitTests *authNetUnitTests;
    int flag;
    
    UIBarButtonItem *prevBtn;
    UIBarButtonItem *nextBtn;
     IBOutlet UITextField *pdfPasswordTextField;
    
   }
-(IBAction) doneClicked:(id)sender;
-(IBAction)onBack:(id)sender;
-(IBAction)click:(id)sender;
- (void) loginToGateway;
-(void)registerDevice;
-(void )showPicker;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
- (NSString *) validateCard:(NSString *)ccNumberString;
-(BOOL) isValidCreditCardNumber:(NSString *)number;
-(void)SendData;
-(void)authorize;
- (void) updateInterfaceWithReachability: (Reachability*) curReach;
-(void)callPOST:(NSString *)filename withParameter:(NSString *)strparameter  withRequest:(NSMutableURLRequest *)request withData:(NSData *)data;
-(void)CreatePdf;
@end
