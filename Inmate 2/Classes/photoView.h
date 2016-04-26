//
//  photoView.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "moneyView.h"
#import "testmapAppDelegate.h"
@interface photoView : UIViewController <UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate>{
	IBOutlet UIImageView *imageView;
	IBOutlet UIImageView *img;
	moneyView *moneyViewController;
	NSMutableArray *arrImg;
	IBOutlet UIScrollView *scrl;
	NSString *picname1,*picname,*date1,*date2;
	
	UIPageControl* pageControl;
	BOOL pageControlBeingUsed;
	BOOL *isPhoto;
    testmapAppDelegate *appdel;
    IBOutlet UIButton *btnBrowse;
    IBOutlet UIButton *btnNO;
    IBOutlet UIButton *btnSubmit;
    int photo;
     int count;
    BOOL flag;
    UIButton *button;
   
}
-(IBAction)btnNext:(id)sender;
-(IBAction) btnBrowse:(id)sender;
-(IBAction)btnSubmit:(id)sender;
-(void)addScrollview;
-(void)nextcall;
@end
