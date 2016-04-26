//
//  photoView.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "photoView.h"
#import "testmapAppDelegate.h"
#import "CreateChooseLetter.h"

@implementation photoView

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
	 arrImg=[[NSMutableArray alloc]init];
    appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
   
    if (appdel.bolFinish) {
        appdel.arrImageData=[[NSMutableArray alloc]init];
    }
    else{
        appdel.arrImageData=[[NSMutableArray alloc]init];
    }
     
    scrl.contentSize=CGSizeMake(320,460);
	scrl.delegate=self;
}
-(void)viewWillAppear:(BOOL)animated{
	appdel.bolChoose=TRUE;
    
//       if(appdel.bolFinish && photo==0){
//           flag=appdel.bolFinish;
//           appdel.bolFinish=NO;
//        //appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
//        [appdel.arrImageData removeAllObjects];
//        appdel.arrImageData=[[NSMutableArray alloc]init];
//          
//        NSLog(@"%@",appdel.arrImageData);
//        
//        [scrl removeFromSuperview];
//       
//    }
  
   // if(!appdel.bolFinish)
   	//button.frame = CGRectMake(60, 10, 20, 20);
    if([appdel.arrImageData count]==0){
        [scrl removeFromSuperview];
    }
   
    [btnNO setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
    [btnBrowse setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
    
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	self.title=@"Photo";
	self.navigationController.navigationBarHidden=FALSE;
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    UIBarButtonItem *nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextBarButtonItem:)];
    
    self.navigationItem.rightBarButtonItem = nextBarButtonItem;
  

}
-(IBAction)back:(id)sender{
      appdel.bolPhoto=FALSE;
   appdel.tabController.selectedIndex=1;
   
   
    
   
}
-(IBAction)nextBarButtonItem:(id)sender{
     appdel.bolPhoto=FALSE;
   appdel.tabController.selectedIndex=3;
    
}
-(IBAction)btnNext:(id)sender{
//	moneyViewController = [[moneyView alloc] initWithNibName:@"moneyView" bundle:nil];
//	[self.navigationController pushViewController:moneyViewController animated:YES];
   
    [btnNO setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
       
    // appdel.bolFinish=flag;
    appdel.bolPhoto=FALSE;
    appdel.tabController.selectedIndex=3;
         
         

   
	
	
}
-(void)nextcall{
    appdel.tabController.selectedIndex=1;
}
-(IBAction) btnBrowse:(id)sender
{
	UIActionSheet *actionsheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library",nil];
	actionsheet.tag=0;
	[actionsheet showInView:self.tabBarController.view];
	
	[actionsheet release];
}
-(IBAction)btnSubmit:(id)sender{
    
      NSLog(@"here is the value of letter %d",appdel.bolLetter);
    if(![appdel.arrImageData count]==0){
        UIActionSheet *actionsheet=[[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Do you want to attach %d Photos",appdel.arrImageData.count] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Yes",@"No",nil];
        appdel.noOfPhotos=[appdel.arrImageData count];
        actionsheet.tag=1;
        [actionsheet showInView:self.tabBarController.view];
        
        [actionsheet release];
    }
    else{
        [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
        //appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate]; 
        //appdel.bolFinish=flag;

        appdel.tabController.selectedIndex=3;
                  
    }
    

}
- (void) actionSheet:(UIActionSheet *)actionsheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(actionsheet.tag==0){
        photo=1;
        if (buttonIndex == 0) {
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry!!" message:@"Camera not found on this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [alert release];
            }else{
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.editing=NO;
            
            [self presentModalViewController:imagePicker animated:YES];
            
            [imagePicker release];
            }
        }        
        if(buttonIndex ==1) {
            UIImagePickerController *picker;
            picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.editing=NO;
            
            
            [self presentModalViewController:picker animated:YES];
        }
        if(buttonIndex==2){
        }
	}
	else {
		if(buttonIndex==0){
			 [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
			appdel.bolPhoto=TRUE;
            
           // appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
            //appdel.bolFinish=flag;
			 appdel.tabController.selectedIndex=3;
              
            
		}
		else if(buttonIndex==1) {
            appdel.bolPhoto=FALSE;
            [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
            //appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
              //appdel.bolFinish=flag;
            appdel.tabController.selectedIndex=3;
            
			//letterDelegate.count=2;
		}
        else{
            
        }
        
	}
    
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
//{
//	
//	[picker dismissModalViewControllerAnimated:YES];
//	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//	NSLog(@"%@",arrImg);
//	NSDate *date = [NSDate date];
//    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
//    [formatter setDateFormat:@"MMddYYHHMMSS"];
//    date1= [formatter stringFromDate:date];
//    date2=[date1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    picname1=[@"image" stringByAppendingString:date2];
//    picname=[[picname1 stringByAppendingString:@".jpg"]retain];
//	
//	
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *dataFilePath = [[documentsDirectory stringByAppendingPathComponent:picname] retain];
//    NSLog(@"i is %d",i);
//    [arrImg addObject:dataFilePath];
//    [appdel.arrImageName addObject:picname];
//	//[arrImg insertObject:dataFilePath atIndex:i];
//    //[appdel.arrImageName insertObject:picname atIndex:i];
//	[UIImageJPEGRepresentation(imageView.image , 1.0) writeToFile:dataFilePath atomically:YES];
//	
//	NSLog(@"array is %@",appdel.arrImageName);
//	
//	for(int j=0;j<=i;j++){
//    NSData *imageData1 = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[arrImg objectAtIndex:j]]];
//		UIImage *img1 = [[UIImage alloc] initWithData:imageData1];
//		
//		img=[[UIImageView alloc]initWithImage:img1];
//		
//		img.frame =CGRectMake(0+(i*80), 0, 80, 80);
//		//[img setImage:img1];
//       
//		[scrl addSubview:img];
//		
//	}
//	NSLog(@"%@",arrImg);
//	
//	scrl.contentSize = CGSizeMake(scrl.frame.size.width * arrImg.count/4, scrl.frame.size.height);
//	float cnt=(float)[arrImg count];
//	cnt=cnt/4;
//	cnt=floor(cnt);
//	pageControl.currentPage = 0;
//	pageControl.numberOfPages =cnt/4;
//	NSLog(@"%d",pageControl.numberOfPages);
//    i++;
//		
//}	
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    

    
	
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissModalViewControllerAnimated:YES];
    if (image) {
        
        if ([appdel.arrImageData count]==0) {
            count=0;
            
        }
        count++;
        [appdel.arrImageData addObject:[image copy]];
    }
    
    NSLog(@"count %d",[appdel.arrImageData count]);
    
    [scrl removeFromSuperview];
    [scrl release];
    scrl =nil;
    
    [self addScrollview];
    
}
-(void)addScrollview
{
    scrl = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 270, self.view.frame.size.width, 100)];   
    
    [self.view addSubview:scrl];
    for(int i = 0; i< [appdel.arrImageData count]; i++)   
    {  
        
        UIView *viewImage = [[UIView alloc] initWithFrame:CGRectMake(i*80,0,80, 100)];       
        // viewImage.backgroundColor = [UIColor greenColor];  
        
        viewImage.tag=i+16;
        
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self 
                   action:@selector(btnCancel:)
         forControlEvents:UIControlEventTouchDown];
        [button setImage:[UIImage imageNamed:@"closebtn.png"] forState:UIControlStateNormal];
       
        button.tag=i+1;
        button.frame = CGRectMake(60, 10, 20, 20);
        
        
        
        
        UIImageView *imageData=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 80, 90)];
        
        [imageData setImage:(UIImage *)[appdel.arrImageData objectAtIndex:i]];
        imageData.tag=i+10;
        
        [viewImage addSubview:imageData];
      
        [scrl addSubview:viewImage];
          [viewImage addSubview:button];
        [viewImage release];  
        [imageData release];
    }    
	int z=[appdel.arrImageData count];
    scrl.contentSize = CGSizeMake(z*80,0);
    
}

-(IBAction)btnCancel:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    if (btn.tag==1) {
        UIView *viewtest=(UIView *)[scrl viewWithTag:16];
        UIImageView *viewima=(UIImageView *)[viewtest viewWithTag:10];
        [viewima removeFromSuperview];
        [appdel.arrImageData removeObjectAtIndex:btn.tag-1];
        
    }else if (btn.tag==2) {
        
        UIView *viewtest=(UIView *)[scrl viewWithTag:17];
        UIImageView *viewima=(UIImageView *)[viewtest viewWithTag:11];
        [viewima removeFromSuperview];
        [appdel.arrImageData removeObjectAtIndex:btn.tag-1];
        
        
    }else if (btn.tag==3) {
        
        UIView *viewtest=(UIView *)[scrl viewWithTag:18];
        UIImageView *viewima=(UIImageView *)[viewtest viewWithTag:12];
        [viewima removeFromSuperview];
        [appdel.arrImageData removeObjectAtIndex:btn.tag-1];
        
    }else if (btn.tag==4) {
        
        UIView *viewtest=(UIView *)[scrl viewWithTag:19];
        UIImageView *viewima=(UIImageView *)[viewtest viewWithTag:13];
        [viewima removeFromSuperview];
        [appdel.arrImageData removeObjectAtIndex:btn.tag-1];
        
    }else if (btn.tag==5) {
        
        UIView *viewtest=(UIView *)[scrl viewWithTag:20];
        UIImageView *viewima=(UIImageView *)[viewtest viewWithTag:14];
        [viewima removeFromSuperview];
        [appdel.arrImageData removeObjectAtIndex:btn.tag-1];
        
    }
    [scrl removeFromSuperview];
    [scrl release];
    scrl =nil;
    NSLog(@"%@",appdel.arrImageData);
    [self addScrollview];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = scrl.frame.size.width;
		int page = floor((scrl.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		pageControl.currentPage = page;
        //[self changePage];
        
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (IBAction)changePage {
	// Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = scrl.frame.size.width * pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = scrl.frame.size;
	[scrl scrollRectToVisible:frame animated:YES];
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	pageControlBeingUsed = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    appdel.noOfPhotos=[appdel.arrImageData count];
    if(appdel.noOfPhotos==0){
        appdel.bolPhoto=FALSE;
    }
    
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
