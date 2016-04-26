//
//  SelectionoptView.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "thankyouView.h"
#import "testmapAppDelegate.h"

@interface SelectionoptView : UIViewController {

	IBOutlet UIButton *btnletter;
	IBOutlet UIButton *btnphoto;
	IBOutlet UIButton *btnmoney;
    IBOutlet UILabel *lblFinalamount;
    IBOutlet UILabel *lblPhoto;
    IBOutlet UILabel *lblMoneyorder;
    IBOutlet UILabel *lblLetter;
    IBOutlet UIButton *btnSubmit;
    IBOutlet UIButton *btnWebsite;
    IBOutlet UILabel *lblQntPhoto;
    IBOutlet UILabel *lblQntPdf;
    IBOutlet UILabel *lblQntMoney;
    float amount;
    float amtPhoto;
    float amtLetter;
    float amtMoney;
	BOOL isPhoto;
    BOOL isLetter;
    BOOL isMoney;
    testmapAppDelegate *letterDelegate;
	thankyouView *thankyouViewController;
}
-(void)callMoney;
-(IBAction)website:(id)sender;
-(IBAction) btnSubmit :(id) sender;
-(IBAction) onMoney :(id) sender;
-(IBAction)onPhoto:(id)sender;
-(IBAction)onMoneyOrder:(id)sender;
-(IBAction)onLetter:(id)sender;
@end
