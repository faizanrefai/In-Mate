//
//  ExistInmate.m
//  testmap
//
//  Created by Hirak on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExistInmate.h"
#import "SelectionoptView.h"
#import "DAL.h"
#import "PdfController.h"
#import "inmate.h"
@implementation ExistInmate
@synthesize tblView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	appDel = (testmapAppDelegate *)[[UIApplication sharedApplication] delegate];
	arrInmateName=[[NSMutableArray alloc]init];
	//[self.view addSubview:infoView];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title=@"Choose Inmate";
	dal=[[DAL alloc]init];
	[dal initDatabase:@"DBInmate.sqlite"];
	arrInmateName=[[dal SelectWithStar:@"tblInmate"] retain];
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	self.navigationController.navigationBarHidden=FALSE;
	UIBarButtonItem *delButton=[[UIBarButtonItem alloc]initWithTitle:@"Delete" 
															   style:UIBarButtonItemStyleBordered
															  target:self action:@selector(Deletedata:)];
	[self.navigationItem setRightBarButtonItem:delButton];
    if(appDel.tabController.selectedIndex==3)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
	[tblView reloadData];
		//[infoView setHidden:YES];
}

-(IBAction) submitClicked:(id)sender
{
    
	SelectionoptView *SelectionoptViewController = [[SelectionoptView alloc] initWithNibName:@"SelectionoptView" bundle:nil];
	[self.navigationController pushViewController:SelectionoptViewController animated:YES];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		//NSMutableDictionary *t_temp =[appdel.retriveData objectAtIndex:indexPath.row];
		
		[dal deleteFromTable:@"tblInmate" WhereField:@"ID =" 
				   Condition:[NSString stringWithFormat:@"%@",[[arrInmateName objectAtIndex:indexPath.row] valueForKey:@"ID"]]];
        [arrInmateName removeObjectAtIndex:indexPath.row];
		[tblView reloadData];
	}
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
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [arrInmateName count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newcellbg.png"]];    
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
   // UIImageView *cellImg = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320, 44)] autorelease];
    //[cellImg setImage:[UIImage imageNamed:@"newcellbg.png"]];
    
     
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
       // [cell.contentView addSubview:cellImg]; 
    }
    
	[cell.textLabel setBackgroundColor:[UIColor clearColor]];
    
    // Configure the cell...
    NSString *inmat = [[NSString alloc] initWithFormat:@"%@",[[arrInmateName valueForKey:@"InName"]objectAtIndex:indexPath.row ]];
   
//    UIImageView *img=[[UIImageView alloc]init ];
//    
//    img.frame=CGRectMake(0, 0, 320, 44);
//    img.image=[UIImage imageNamed:@"newcellbg.png"];
//    cell.backgroundView=img;
//    [cell.contentView addSubview:img];
     cell.textLabel.text = inmat;
	
    return cell;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newcellbg.png"]];    
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    appDel.isLetter=FALSE;
	NSLog(@"arrinamte%@",arrInmateName);
	appDel.dataInmate=[arrInmateName objectAtIndex:indexPath.row];
	NSLog(@"dict %@",appDel.dataInmate);
    
    appDel.creditNO=[appDel.dataInmate valueForKey:@"ID"];
    inmate *objInmate=[[inmate alloc]initWithNibName:@"inmate" bundle:nil];
    [self.navigationController pushViewController:objInmate animated:YES];
    [objInmate release];
	
//	
//    
    

	//[infoView setHidden:NO];
}


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

