//
//  priceView.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "priceView.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@implementation priceView


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	//UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
//    self.navigationItem.leftBarButtonItem = buttonItem;
//    [buttonItem release];
	//self.navigationController.navigationBarHidden=TRUE;

		array = [[NSArray alloc] initWithObjects:@"99cents per letter (up to six pages)",@"49cents per photo.",@"99cents for money order plus the amount being sent.",nil];
}
-(void)viewWillAppear:(BOOL)animated{
	appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newcellbg.png"]];
	self.navigationController.navigationBarHidden=FALSE;
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Information" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
    if(appdel.tabController.selectedIndex==0)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    [buttonItem release];
}
-(IBAction)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newcellbg.png"]];    
//}


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
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [array count];
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newcellbg.png"]];    
//}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UIImageView *cellImg;
    if(indexPath.row!=3){
    cellImg= [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320, 50)] autorelease];
    [cellImg setImage:[UIImage imageNamed:@"newcellbg.png"]];
    
    }
    else{
        cellImg= [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320, 60)] autorelease];
        [cellImg setImage:[UIImage imageNamed:@"newcellbg.png"]];

    }
	    
    // Configure the cell...
       
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
         [cell.contentView addSubview:cellImg]; 
    }
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];


	NSString *text =[array objectAtIndex:indexPath.row];
	txtViewDescription=[[UILabel alloc]init];
    [txtViewDescription setBackgroundColor:[UIColor clearColor ]];
	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	txtViewDescription.numberOfLines=2;
        txtViewDescription.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];

	[txtViewDescription setFrame:CGRectMake(5, 0, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height-60, 50.0f))];
	txtViewDescription.text = text;
	
	[cell.contentView addSubview:txtViewDescription];
    
    
   // cell.textLabel.text=[array objectAtIndex:indexPath.row];
    //cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];

   
	
   	
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row!=3) {
        return 50;
    }
    else{
        return 60;
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




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
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

