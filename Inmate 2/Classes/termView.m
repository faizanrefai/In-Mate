//
//  termView.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "termView.h"
#import "CreditCard.h"

@implementation termView


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	//self.title =@"Terms And Condition";
	
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	appDel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    dal=[[DAL alloc]init];
	[dal initDatabase:@"DBInmate.sqlite"];

	if(!appDel.isTerm){
        if(appDel.tabController.selectedIndex==3)
        {
            
        }
        else{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
		webView.frame=CGRectMake(0, 0, 320, 480);
		UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"I Agree" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked)]; 
		self.navigationItem.rightBarButtonItem = buttonItem;
		[buttonItem release];
        
	}
    else{
       
        if(appDel.tabController.selectedIndex==0)
        {
            
        }
        else{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }

    }
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	
	self.navigationController.navigationBarHidden=FALSE;
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
    [buttonItem release];
	
	NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"TermsofServiceAgreement" ofType:@"pdf"];
	
	NSURL *url = [NSURL fileURLWithPath:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	[webView loadRequest:requestObj];
	webView.scalesPageToFit = YES;
    

	
	
}
-(IBAction) doneClicked
{

    
    NSMutableArray *temp=[[NSMutableArray alloc]init ];
    temp=[[dal SelectWithStar:@"tblCreditCard"] retain];

    if([temp count]==0){
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil	otherButtonTitles:@"Create Credit Card",nil];
        [action showInView:self.tabBarController.view];	
    }else{
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil	otherButtonTitles:@"Create Credit Card",@"Choose Existing Info",nil];
	[action showInView:self.tabBarController.view];	
    }
}
-(IBAction)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==1)
	{
		ExistCreditCard *objExistCreditCard = [[ExistCreditCard alloc] initWithNibName:@"ExistCreditCard" bundle:nil];
		[self.navigationController pushViewController:objExistCreditCard animated:YES];
	}
	else if (buttonIndex==0)
	{
		appDel.isExist=FALSE;
		CreditCard *objCreditCard = [[CreditCard alloc] initWithNibName:@"CreditCard" bundle:nil];
		[self.navigationController pushViewController:objCreditCard animated:YES];
	}
	
}



/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

