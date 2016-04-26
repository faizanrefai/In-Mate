//
//  testmapAppDelegate.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RootViewController;
@class PdfController;

@interface testmapAppDelegate : NSObject <UIApplicationDelegate,UITabBarControllerDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	UITabBarController *tabController;
	NSInteger count;
	
	NSMutableDictionary *dataInmate;
	NSMutableDictionary *dataCreditCard;
	
	BOOL isTerm;
	NSString *appFontName;
	BOOL isExist;
	BOOL isLetter;
	NSString *creditNO;
	PdfController *viewController;
	
	NSString *appTxtDate;
	NSString *appTxtDear;
	NSString *appTxtBody;
	NSString *appTxtSign;
    NSString *appLetterName;
    NSString *inMateName;
    NSString *emailID;
    NSString *appSubject;
    NSString *appSalutation;
    
    float moneyorderAmt;
	int noOfPages;
    int noOfPhotos;
    NSString *indexOfFont;
	NSMutableArray *arrLetterDet;
    float finalAmt;
    NSString *strMessage;
    NSMutableArray *arrImageName;
    NSMutableArray *arrImageData;
    
    BOOL isFB;
    BOOL bolPhoto;
    BOOL bolLetter;
    BOOL bolMoney;
    BOOL bolChoose;
    BOOL bolFinish;
    BOOL bolLetterFormat;
    
}
@property(nonatomic,retain) NSString *appSalutation;
@property(nonatomic,assign) BOOL bolLetterFormat;
@property(nonatomic,retain)NSString *appSubject;
@property(nonatomic,retain)NSString *emailID;
@property(nonatomic,retain)NSString *indexOfFont;
@property(nonatomic,retain)NSString *inMateName;
@property(nonatomic,retain)NSString *appLetterName;
@property(nonatomic,retain)NSString *strMessage;
@property(nonatomic,retain)NSMutableArray *arrImageName;
@property(nonatomic,retain)NSMutableArray *arrImageData;
@property(nonatomic,assign) float finalAmt;
@property(nonatomic,assign) float moneyorderAmt;
@property(nonatomic,assign)int noOfPages;
@property(nonatomic,assign)int noOfPhotos;
@property(nonatomic,assign)BOOL bolFinish;
@property(nonatomic,retain)NSMutableArray *arrLetterDet;
@property(nonatomic,retain)NSString *appTxtDate;
@property(nonatomic,retain)NSString *appTxtDear;
@property(nonatomic,retain)NSString *appTxtBody;
@property(nonatomic,retain)NSString *appTxtSign;
@property (nonatomic, retain) PdfController *viewController;
@property(nonatomic,retain)NSString *appFontName;
@property(nonatomic,retain)NSString *creditNO;
@property (nonatomic ,assign) BOOL isExist;
@property (nonatomic ,assign) BOOL isFB;
@property (nonatomic ,assign) BOOL isLetter;
@property (nonatomic ,assign) BOOL bolPhoto;
@property (nonatomic ,assign) BOOL bolLetter;
@property (nonatomic ,assign) BOOL bolMoney;
@property (nonatomic ,assign) BOOL bolChoose;
@property(nonatomic,assign)BOOL isTerm;
@property (nonatomic ,retain) NSMutableDictionary *dataCreditCard;
@property (nonatomic ,retain) NSMutableDictionary *dataInmate;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic,assign) NSInteger count; 
@property (nonatomic, retain) IBOutlet   UITabBarController *tabController;
-(void) checkAndCreateDatabase;
-(void)registerDevice;
@end

