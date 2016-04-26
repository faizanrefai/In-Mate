//
//  SelectionoptView.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "SelectionoptView.h"
#import "testmapAppDelegate.h"
#import "termView.h"
#import "WebSite.h"



@implementation SelectionoptView

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
    self.title=@"Selected Items";
    
	letterDelegate = (testmapAppDelegate*)[[UIApplication sharedApplication]delegate];

	//NSLog([letterDelegate.dataInmate description]);
    if(letterDelegate.tabController.selectedIndex==3)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    NSLog(@"%d",letterDelegate.bolLetter);
	if (letterDelegate.bolLetter)
	{
        isLetter=TRUE;
		[btnletter setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
	}
    else{
        btnletter.enabled=FALSE;
        [btnletter setImage:[UIImage imageNamed:@"notselected.png"] forState:UIControlStateNormal];
    }
	if(letterDelegate.bolPhoto)
	{
        isPhoto=TRUE;
		//[btnletter setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
		[btnphoto setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
	}
    else{
        btnphoto.enabled=FALSE;
        [btnphoto setImage:[UIImage imageNamed:@"notselected.png"] forState:UIControlStateNormal];
    }
	if(letterDelegate.bolMoney)
	{
        isMoney=TRUE;
		//[btnletter setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
		//[btnphoto setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
		[btnmoney setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];		
	}
    else{
        btnmoney.enabled=FALSE;
        [btnmoney setImage:[UIImage imageNamed:@"notselected.png"] forState:UIControlStateNormal];
    }
    lblFinalamount.text=[NSString stringWithFormat:@"%d", letterDelegate.finalAmt/100];
    NSLog(@"no of pages %d and no of photos %d",letterDelegate.noOfPages,letterDelegate.noOfPhotos);
    amount=0,amtLetter=0,amtPhoto=0,amtMoney=0;;
    
    float noPhoto;
    if(isLetter && letterDelegate.noOfPages>=1){
        if(letterDelegate.noOfPages<=6 && isLetter){
            
            
            amtLetter=amtLetter+0.99;
            
        }
        else{
            NSLog(@"YEs yes");
            if(letterDelegate.noOfPages % 6==0){
                
                
                int a=letterDelegate.noOfPages/6;
                NSLog(@"value of a is %d",a);
                amtLetter=a*0.99;
                NSLog(@"1111  %f",amtLetter);
                
                
            }
            else{
                NSLog(@"%d",letterDelegate.noOfPages);
                int a1=letterDelegate.noOfPages/6;
                NSLog(@"%d",a1);
               
              
                amtLetter=0.99+a1*0.99;
                NSLog(@"2222 %f",amtLetter);
                
            }
        }
        
        lblLetter.text=[NSString stringWithFormat:@"$%.2f",amtLetter];
        lblQntPdf.text=[NSString stringWithFormat:@"%d",letterDelegate.noOfPages];
        
        NSLog(@"amount is %f",amount);
    }
    else{
        lblLetter.text=@"$0.00";
        lblQntPdf.text=@"0";
    }
    
    
    
    noPhoto= (float)letterDelegate.noOfPhotos;
    if(noPhoto==0){
        lblPhoto.text=@"$0.00";
        lblQntPhoto.text=@"0";
    }
    else{
        if(isPhoto){
            if(letterDelegate.noOfPhotos>0){
                
                amtPhoto=(letterDelegate.noOfPhotos*0.49);
                noPhoto=(float)letterDelegate.noOfPhotos;
                
                lblPhoto.text=[NSString stringWithFormat:@"$%.2f",(noPhoto*0.49)];
                lblQntPhoto.text=[NSString stringWithFormat:@"%d",letterDelegate.noOfPhotos];
                
                
                NSLog(@"amount is %f",amount);
                
            }
            
        }
        else{
            if(letterDelegate.noOfPhotos==0){
            lblPhoto.text=@"$0.00";
            lblQntPhoto.text=@"0";
            }
            else{
                lblPhoto.text=@"$0.00";
                lblQntPhoto.text=@"0";
            }
        }
        
    }
    if(isMoney && letterDelegate.moneyorderAmt>0.0){
        NSLog(@"%f",amount);
        amtMoney=0.99+letterDelegate.moneyorderAmt;
        lblMoneyorder.text=[NSString stringWithFormat:@"$%.2f",letterDelegate.moneyorderAmt+0.99];
        NSLog(@"amount is %f",amtMoney);
    }
    else
        lblMoneyorder.text=@"$0.00";
    
    NSLog(@"amount is %.2f",amount/100);
    NSLog(@"final is %.2f",letterDelegate.finalAmt-amount/100);
    
    lblFinalamount.text=[NSString stringWithFormat:@"$%.2f", amtMoney+amtPhoto+amtLetter];

    [btnWebsite setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
}
#pragma mark IBAction
-(IBAction) onMoney :(id) sender{
	
	[self.navigationController popViewControllerAnimated:YES];
	
}
-(IBAction)onPhoto:(id)sender{
    if(isPhoto)
    isPhoto=FALSE;
    else
        isPhoto=TRUE;
    [self callMoney];
    
}
-(IBAction)onMoneyOrder:(id)sender{
    if(isMoney)
        isMoney=FALSE;
    else
        isMoney=TRUE;
    [self callMoney];
}
-(IBAction)onLetter:(id)sender{
    if(isLetter)
        isLetter=FALSE;
    else
        isLetter=TRUE;
    [self callMoney];
}
-(void)callMoney{
    if (isLetter)
	{
        
		[btnletter setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
	}
    else{
        [btnletter setImage:[UIImage imageNamed:@"notselected.png"] forState:UIControlStateNormal];
    }
	if(isPhoto)
	{
        
		//[btnletter setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
		[btnphoto setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
	}
    else{
        [btnphoto setImage:[UIImage imageNamed:@"notselected.png"] forState:UIControlStateNormal];
    }
	if(isMoney)
	{
        
		//[btnletter setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
		//[btnphoto setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
		[btnmoney setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];		
	}
    else{
       [btnmoney setImage:[UIImage imageNamed:@"notselected.png"] forState:UIControlStateNormal];
    }
   
    NSLog(@"no of pages %d and no of photos %d",letterDelegate.noOfPages,letterDelegate.noOfPhotos);
    amount=0,amtLetter=0,amtPhoto=0,amtMoney=0;;
   
    float noPhoto;
    if(isLetter && letterDelegate.noOfPages>=1){
        if(letterDelegate.noOfPages<=6 && isLetter){
            
            
            amtLetter=amtLetter+0.99;
            
        }
        else{
            if(letterDelegate.noOfPages % 6==0 ){
                
                float a=letterDelegate.noOfPages%6;
                amtLetter=a*0.99;
                
                
            }
            else{
                int a=letterDelegate.noOfPages/6;
                amtLetter=0.99+a*0.99;
                
            }
        }
        
    lblLetter.text=[NSString stringWithFormat:@"%.2f$",amtLetter];
    lblQntPdf.text=[NSString stringWithFormat:@"%d",letterDelegate.noOfPages];
 
    NSLog(@"amount is %f",amount);
    }
    else{
        lblLetter.text=@"0.00$";
        lblQntPdf.text=@"0";
    }
    
   
   
    noPhoto= (float)letterDelegate.noOfPhotos;
    if(noPhoto==0){
        lblPhoto.text=@"0.00$";
        lblQntPhoto.text=@"0";
    }
    else{
        if(isPhoto){
            if(letterDelegate.noOfPhotos>0){
                
                amtPhoto=(letterDelegate.noOfPhotos*0.49);
                noPhoto=(float)letterDelegate.noOfPhotos;
               
                lblPhoto.text=[NSString stringWithFormat:@"%.2f$",(noPhoto*0.49)];
                lblQntPhoto.text=[NSString stringWithFormat:@"%d",letterDelegate.noOfPhotos];
              
                
                  NSLog(@"amount is %f",amount);
                
            }
        
        }
        else{
            lblPhoto.text=@"0.00$";
            lblQntPhoto.text=@"0";
        }
        
    }
    if(isMoney && letterDelegate.moneyorderAmt>0.0){
        NSLog(@"%f",amount);
        amtMoney=0.99+letterDelegate.moneyorderAmt;
        lblMoneyorder.text=[NSString stringWithFormat:@"%.2f$",letterDelegate.moneyorderAmt+0.99];
        NSLog(@"amount is %f",amtMoney);
    }
    else
        lblMoneyorder.text=@"0.00$";
   
    NSLog(@"amount is %.2f",amount/100);
    NSLog(@"final is %.2f",letterDelegate.finalAmt-amount/100);
    
    lblFinalamount.text=[NSString stringWithFormat:@"%.2f$", amtMoney+amtPhoto+amtLetter];
    

}
-(IBAction)website:(id)sender{
   [btnWebsite setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
    WebSite *objWEb=[[WebSite alloc]initWithNibName:@"WebSite" bundle:nil];
    [self presentModalViewController:objWEb animated:YES];
    [objWEb release];
}
-(IBAction) btnSubmit :(id) sender
{
    letterDelegate.bolMoney=isMoney;
    letterDelegate.bolPhoto=isPhoto;
    letterDelegate.bolLetter=isLetter;
    NSLog(@"%f",amount);
    letterDelegate.finalAmt=amtMoney+amtPhoto+amtLetter;
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
	letterDelegate.isTerm=FALSE;
    termView *objTerm = [[termView alloc] initWithNibName:@"termView" bundle:nil];
    [self.navigationController pushViewController:objTerm animated:YES];
    [objTerm release];
//	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Submit" message:@"Are you Ready to Pay the Cost" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//	
//	[alert show];
//	[alert release];
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex==1) 
	{
		termView *objTerm = [[termView alloc] initWithNibName:@"termView" bundle:nil];
		[self.navigationController pushViewController:objTerm animated:YES];
		[objTerm release];
		
		//thankyouViewController = [[thankyouView alloc] initWithNibName:@"thankyouView" bundle:nil];
		//[self.navigationController pushViewController:thankyouViewController animated:YES];
	}

}


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
