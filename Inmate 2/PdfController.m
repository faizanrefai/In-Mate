//
//  PdfController.m
//  Inmate
//
//  Created by girish on 12/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PdfController.h"
#import "SelectionoptView.h"
#import "PDFService.h"
#import "PDFHelper.h"
@implementation PdfController

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
	
}
-(void)viewWillAppear:(BOOL)animated{
    
    
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(Next)]; 
    self.navigationItem.rightBarButtonItem = buttonItem;
    [buttonItem release];
	appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.title=[NSString stringWithFormat:@"%@",appdel.inMateName];
    if(appdel.tabController.selectedIndex==3)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }

    [self createPDFFile];
    [self loadPDFFile];
}
-(void)Next{
	
	 NSLog(@"no of pages %d",appdel.noOfPages);
	SelectionoptView *objSel=[[SelectionoptView alloc]initWithNibName:@"SelectionoptView" bundle:nil];
	[self.navigationController pushViewController:objSel animated:YES];
	[objSel release];
	
	
}

- (void)createPDFFile
{
    
    PDFHelper *pdfHelper = [[PDFHelper alloc] init];
    
    //create the file path to store our PDF document (will be created inside our app's documents directory) 
    //If you're using the simulator, the file can be found in: homeFolder/Library/Application Support/iPhone Simulator/versionOfIOS_Simulator/Applications/SomeWeirdStringIdentifyingYourApp/Documents/
    
    NSString *fileName = @"inmate.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *saveDirectory = [paths objectAtIndex:0];
	NSString *saveFileName = fileName;
	NSString *documentPath = [saveDirectory stringByAppendingPathComponent:saveFileName];
    
    //make call to PDFHelper class and create the document
    NSLog(@"%@",appdel.appFontName);
   
    [pdfHelper createPDF:documentPath withContent:appdel.appTxtBody forSize:17 andFont:[NSString stringWithFormat:@"%@",appdel.appFontName] andColor:[UIColor blackColor] :YES :YES :([appdel.appTxtBody length] > 0) ? pdfPasswordTextField.text : nil];
    
    
    
    
    [pdfHelper release];
   
}
-(void)CreateContact{
    PDFHelper *pdfHelper = [[PDFHelper alloc] init];
    NSString *fileName1 = @"contact.pdf";
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *saveDirectory1 = [paths1 objectAtIndex:0];
	NSString *saveFileName1 = fileName1;
	NSString *documentPath1 = [saveDirectory1 stringByAppendingPathComponent:saveFileName1];
    
    //make call to PDFHelper class and create the document
     
    [pdfHelper createPDF1:documentPath1 withContent:@"sdfsdf" forSize:17 andFont:@"Arial" andColor:[UIColor blackColor] :YES :YES :(@"asdzd" > 0) ? pdfPasswordTextField.text : nil];
    [pdfHelper release];
}

- (IBAction)loadPDFFile
{
    NSArray *arrayPaths = 
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"/inmate.pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
	webView.scalesPageToFit=YES;
    [webView loadRequest:request];
//    NSString *pathToPdfDoc = [[NSBundle mainBundle] pathForResource:@"mypdf" ofType:@"pdf"];    
//    NSURL *pdfUrl = [NSURL fileURLWithPath:pathToPdfDoc];   
//    CGPDFDocumentRef document = CGPDFDocumentCreateWithURL((CFURLRef)pdfUrl);  
    
}


#pragma mark -
#pragma mark delegate method


//- (void)service:(PDFService *)service
//didFailedCreatingPDFFile:(NSString *)filePath
//        errorNo:(HPDF_STATUS)errorNo
//       detailNo:(HPDF_STATUS)detailNo
//{
//    NSString *message = [NSString stringWithFormat:@"Couldn't create a PDF file at %@\n errorNo:0x%04x detalNo:0x%04x",
//                         filePath,
//                         errorNo,
//                         detailNo];
//    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"PDF creation error"
//                                                     message:message
//                                                    delegate:nil
//                                           cancelButtonTitle:@"OK"
//                                           otherButtonTitles:nil] autorelease];
//    [alert show];
//}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
