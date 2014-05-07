
//
//  DetailViewController.m
//  Test
//
//  Created by Abbi H Safaie on 3/05/2014.
//  Copyright (c) 2014 Abbas H Safaie. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;

    //string coming from rootViewController
    
    if(self.urlRoot){
        self.url.text=self.urlRoot;
      }
    
    //load view with data passsed from table
    
    if(self.favarout){


        
        [self.name setText:[self.favarout valueForKey:@"name"]];
        [self.url setText:[self.favarout valueForKey:@"url"]];
        [self.imageurl setText:[self.favarout valueForKey:@"imageUrl"]];
       
        //get data from database create image
        
        UIImage * myImage = [UIImage imageWithData:[self.favarout valueForKey:@"image"]];
        //set image
        self.imageVie.image=myImage;
        
        self.imageVie.layer.cornerRadius = 50.0;
        self.imageVie.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.imageVie.layer.borderWidth = 1.0;
        self.imageVie.clipsToBounds = YES;
        
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//create data from our urlImage :D

-(NSData*)imageData{


    NSURL* urlCr=[NSURL URLWithString:self.imageurl.text];
    
    NSData *data=[[NSData alloc]initWithContentsOfURL:urlCr];
    
    UIImage* image=[UIImage imageWithData:data];
    
    NSData* imageData=UIImagePNGRepresentation(image);

    return imageData;

}

//textField delegate should return

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.favarout setValue:self.name.text forKey:@"name"];
    [self.favarout setValue:self.url.text forKey:@"url"];
    [self.favarout setValue:self.imageurl.text forKey:@"imageUrl"];
    [self.favarout setValue:[self imageData] forKey:@"image"];
    [self.delegate detaiViewWillDis:self];
    
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //segue to masterView and save data here in our database
    
    if ([[segue identifier] isEqualToString:@"goTable"]) {
       
        //if not empty add newEntry
        
        if((self.name.text.length!=0)||(self.url.text.length!=0)) {
            Favarouts * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Favarouts"
                                                                 inManagedObjectContext:self.managedObjectContext];
            
            newEntry.name=self.name.text;
            newEntry.url=self.url.text;
            newEntry.imageUrl=self.imageurl.text;
            
            [newEntry setValue:[self imageData] forKey:@"image"];
        }
      
        
    }
}




//method use for hide keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:(YES)];
}




@end
