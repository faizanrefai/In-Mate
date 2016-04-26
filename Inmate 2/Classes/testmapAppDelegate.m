//
//  testmapAppDelegate.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "testmapAppDelegate.h"
#import "RootViewController.h"
#import "BusinessFormat.h"
#import "PdfController.h"

@implementation testmapAppDelegate

@synthesize window,isFB,appLetterName,bolChoose,arrImageData,emailID,appSalutation;
@synthesize navigationController,isTerm,creditNO,viewController,appTxtBody,appTxtDate,appTxtDear,appTxtSign,noOfPages,noOfPhotos;
@synthesize count,dataInmate,dataCreditCard,isExist,appFontName,tabController,arrLetterDet;
@synthesize isLetter,finalAmt,arrImageName,strMessage,bolFinish;
@synthesize bolMoney,bolLetter,bolPhoto,inMateName,indexOfFont,moneyorderAmt,appSubject,bolLetterFormat;
#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
	dataInmate = [[NSMutableDictionary alloc] init];
	dataCreditCard = [[NSMutableDictionary alloc] init];
	isExist=FALSE;
    bolMoney=FALSE;
    bolLetter=FALSE;
    bolPhoto=FALSE;
    bolChoose=TRUE;
    bolFinish=NO;
	self.viewController= [[[PdfController alloc] initWithNibName:@"PDFView"
                                                            bundle:nil] autorelease];
   
    [self.window addSubview:tabController.view];
    [self.window makeKeyAndVisible];
	[self checkAndCreateDatabase];
    return YES;
}

-(void) checkAndCreateDatabase
{
	BOOL success;
	
	NSString *databaseName = @"DBInmate.sqlite";
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	//NSLog(@"database path:%@",databasePath);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	success = [fileManager fileExistsAtPath:databasePath];
	
	if(success) return;
	
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	[fileManager release];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController1    {

  
    [(UINavigationController*)viewController1 popToRootViewControllerAnimated:NO];
    
  
  

    return YES;
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController1   {
    [(UINavigationController*)viewController1 popToRootViewControllerAnimated:NO];
    


}
-(NSArray *)tabControllerAtIndexes:(NSIndexSet *)indexes{
    NSLog(@"%@",indexes);
    return arrImageData;
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item

{
    
    if (item != self.tabController.tabBarItem) {
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

