//
//  RootViewController.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "RootViewController.h"

#import "WebSite.h"
@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(IBAction) btninfo :(id)sender
{
    imgWebsite.image=[UIImage imageNamed:@"newBlackBg.png"];
	detailViewController = [[DetailView alloc] initWithNibName:@"DetailView" bundle:nil];
    appdel.bolChoose=TRUE;
	detailViewController.title = @"Information";
	[self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    appdel=(testmapAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.navigationController.navigationBarHidden=FALSE;
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
     	imgWebsite.image=[UIImage imageNamed:@"newBlueBg.png"];
    self.title=@"Jail Mail";
   
   
}
-(IBAction)website:(id)sender{
    
    WebSite *objWEb=[[WebSite alloc]initWithNibName:@"WebSite" bundle:nil];
   [self presentModalViewController:objWEb animated:YES];
    [objWEb release];
}
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
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[detailViewController release];
}


@end

