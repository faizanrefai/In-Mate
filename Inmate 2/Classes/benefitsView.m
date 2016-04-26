//
//  benefitsView.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "benefitsView.h"

#import "moneyView.h"
@implementation benefitsView

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	array = [[NSArray alloc] initWithObjects:@"NEVER HAVE TO GO TO POST OFFICE OR FIND A MAILBOX TO SEND A LETTER TO LOVED ONE AGAIN!!",@"NEVER HAVE TO PRINT OR GET PICTURES DEVELOPED TO SEND!!",@"NEVER HAVE TO WAIT IN THOSE LONG LINES TO GET A MONEY ORDER!!",@"EVERYTHING IS DONE FROM CONVENIENCE OF YOUR MOBILE PHONE OR TABLET!!",@"NO REGISTRATION OR SUBSCRIPTION NEEDED!!",@"MAIL TO WHOEVER YOU WANT, WHENEVER YOU WANT, AS MANY TIMES YOU WANT!!",@"NO MORE BUYING STAMPS!!",@"MAIL IS SENT OUT SAME DAY WE RECEIVE IT!!",nil];
}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	moneyview.doneButton.hidden=TRUE;
	self.navigationController.navigationBarHidden=FALSE;
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Information" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
    [buttonItem release];
    appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    if(appdel.tabController.selectedIndex==0)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
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
#pragma mark IBAction
-(IBAction)onBack:(id)sender{
	
	[self.navigationController popViewControllerAnimated:YES];
	
	
}

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
//        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newcellbg.png"]];    
//}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UIImageView *cellImg;
    cellImg= [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320, 88)] autorelease];
    [cellImg setImage:[UIImage imageNamed:@"newcellbg.png"]];
        

    

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
          
    }
    [cell.contentView addSubview:cellImg];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    
        
	NSString *text =[array objectAtIndex:indexPath.row];
	txtViewDescription=[[UILabel alloc]init];
    [txtViewDescription setBackgroundColor:[UIColor clearColor ]];
	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	txtViewDescription.numberOfLines=4;
    txtViewDescription.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
    
	[txtViewDescription setFrame:CGRectMake(5, 0, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height-10, 88.0f))];
	txtViewDescription.text = text;
	
	[cell.contentView addSubview:txtViewDescription];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	    
        return 88;
    
    
	
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
-(void)viewWillDisappear:(BOOL)animated{
	
	[NSNotificationCenter defaultCenter];
	 
	 }

- (void)dealloc {
    [super dealloc];
}


@end

