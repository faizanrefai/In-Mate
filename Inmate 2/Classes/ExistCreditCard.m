//
//  ExistCreditCard.m
//  testmap
//
//  Created by Hirak on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExistCreditCard.h"
#import "CreditCard.h"

@implementation ExistCreditCard
@synthesize tblView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	appDel = (testmapAppDelegate *)[[UIApplication sharedApplication] delegate];
	
}

-(void)viewWillAppear:(BOOL)animated{
	dal=[[DAL alloc]init];
    if(appDel.tabController.selectedIndex==3)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }

    self.title=@"Choose Credit card";
	[dal initDatabase:@"DBInmate.sqlite"];
	retrivedata=[[NSMutableArray alloc]init];
	retrivedata=[[dal SelectWithStar:@"tblCreditCard"] retain];
	NSLog(@"%@",retrivedata);
    UIBarButtonItem *delButton=[[UIBarButtonItem alloc]initWithTitle:@"Delete" 
															   style:UIBarButtonItemStyleBordered
															  target:self action:@selector(Deletedata:)];
	[self.navigationItem setRightBarButtonItem:delButton];
	[tblView reloadData];
	
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [retrivedata count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newcellbg.png"]];    
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSString *holder = [[NSString alloc] initWithFormat:@"%@",[[retrivedata valueForKey:@"cardHolder"]objectAtIndex:indexPath.row]];
    cell.textLabel.text = holder;
	
    return cell;
}
- (IBAction)Deletedata:(id)sender{
	
	if(self.editing)
	{ 
		[super setEditing:NO animated:NO]; 
		[tblView setEditing:NO animated:NO];
		[tblView reloadData];
		[self.navigationItem.rightBarButtonItem setTitle:@"Delete"];
		[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
		self.navigationItem.rightBarButtonItem.enabled=TRUE;
	}
	else
	{
		[super setEditing:YES animated:YES]; 
		
		[tblView setEditing:YES animated:YES];
		[tblView reloadData];
		[self.navigationItem.rightBarButtonItem setTitle:@"Done"];
		[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
		self.navigationItem.rightBarButtonItem.enabled=TRUE;
	}
    
}



#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		//NSMutableDictionary *t_temp =[appdel.retriveData objectAtIndex:indexPath.row];
		
		[dal deleteFromTable:@"tblCreditCard" WhereField:@"ID =" 
				   Condition:[NSString stringWithFormat:@"%@",[[retrivedata objectAtIndex:indexPath.row] valueForKey:@"ID"]]];
        [retrivedata removeObjectAtIndex:indexPath.row];
		[tblView reloadData];
	}
}	

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	appDel.isExist=TRUE;
	appDel.creditNO=[[retrivedata valueForKey:@"ID"]objectAtIndex:indexPath.row];
	NSLog(@"%@",appDel.creditNO);
	CreditCard *objcredit = [[CreditCard alloc] initWithNibName:@"CreditCard" bundle:nil];
	[self.navigationController pushViewController:objcredit animated:YES];
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
