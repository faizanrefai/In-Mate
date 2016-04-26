//
//  ChooseExistingLetter.m
//  Jail Mail
//
//  Created by girish on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ChooseExistingLetter.h"
#import "letterFormat.h"
#import "BusinessFormat.h"
@implementation ChooseExistingLetter


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	arrLetterName=[[NSMutableArray alloc]init];
    arrBusiness=[[NSMutableArray alloc]init];
    
    
	appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    if(appdel.tabController.selectedIndex==1)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
	dal=[[DAL alloc]init];
	[dal initDatabase:@"DBInmate.sqlite"];
	arrLetterName=[[dal SelectWithStar:@"tblFrdFormat"] retain];
	NSLog(@"arrletter %@",arrLetterName);
    arrBusiness=[[dal SelectWithStar:@"tblBusiness"] retain];
    NSLog(@"arr business %@",arrBusiness);
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Letter" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
	self.title=@"Choose letter";
    [buttonItem release];
    UIBarButtonItem *delButton=[[UIBarButtonItem alloc]initWithTitle:@"Delete" 
															   style:UIBarButtonItemStyleBordered
															  target:self action:@selector(Deletedata:)];
	[self.navigationItem setRightBarButtonItem:delButton];
}
-(IBAction)backButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    //    CreateChooseLetter *objChoose=[[CreateChooseLetter alloc]initWithNibName:@"CreateChooseLetter" bundle:nil];
    //    [self.navigationController pushViewController:objChoose animated:YES];
    //    [objChoose release];
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
		if(indexPath.section==0){
		[dal deleteFromTable:@"tblFrdFormat" WhereField:@"ID =" 
				   Condition:[NSString stringWithFormat:@"%@",[[arrLetterName objectAtIndex:indexPath.row] valueForKey:@"ID"]]];
        [arrLetterName removeObjectAtIndex:indexPath.row];
            [tblView reloadData];
        }
        else{
            [dal deleteFromTable:@"tblBusiness" WhereField:@"ID =" 
                       Condition:[NSString stringWithFormat:@"%@",[[arrBusiness objectAtIndex:indexPath.row] valueForKey:@"ID"]]];
            [arrBusiness removeObjectAtIndex:indexPath.row];
            [tblView reloadData];
        }
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section==0)
    return [arrLetterName count];
    else
        return [arrBusiness count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0){
        return @"Friend Letter";
    }
    else{
        return @"Business Letter";
    }
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
	NSLog(@"%@",arrLetterName);
    if(indexPath.section==0)
    cell.textLabel.text=[[arrLetterName valueForKey:@"LetterName"]objectAtIndex:indexPath.row];
    if(indexPath.section==1)
        cell.textLabel.text=[[arrBusiness valueForKey:@"LetterName"]objectAtIndex:indexPath.row];
     
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"%@",arrLetterName);
	appdel.isLetter=FALSE;
    if(indexPath.section==0){
        appdel.bolLetterFormat=TRUE;
	appdel.arrLetterDet=[arrLetterName objectAtIndex:indexPath.row];
	letterFormat *let=[[letterFormat alloc]initWithNibName:@"letterFormat" bundle:nil];
	[self.navigationController pushViewController:let animated:YES];
	[let release];
    }
    else{
        appdel.bolLetterFormat=FALSE;
        appdel.arrLetterDet=[arrBusiness objectAtIndex:indexPath.row];
        BusinessFormat *busObj=[[BusinessFormat alloc] initWithNibName:@"BusinessFormat" bundle:nil];
        [self.navigationController pushViewController:busObj animated:YES];
        [busObj release];
    }
	
	
}

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

