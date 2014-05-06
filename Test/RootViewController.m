//
//  RootViewController.m
//  Test
//
//  Created by Abbi H Safaie on 3/05/2014.
//  Copyright (c) 2014 Abbas H Safaie. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController ()




@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.myWeb.hidden=NO;
    
    self.url=self.urlTextfield.text;
    
    //set url entry
    dispatch_queue_t background= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    //set our url entry from textField as string to create NSURL
    
    NSString*urlAdress=[NSString stringWithFormat:@"https://%@",self.url];
    
    //  NSString*urlAdress=urlInCom;
    
    NSURL *url=[NSURL URLWithString:urlAdress];
    dispatch_async(background,^{
        
        
        NSURLRequest*request=[NSURLRequest requestWithURL:url];
        //load to web view
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.myWeb loadRequest:request];
        });
    });
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier ] isEqualToString:@"addButton"]) {
        DetailViewController *dvc=[segue destinationViewController];
        
        dvc.urlRoot=self.urlTextfield.text;
        
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
