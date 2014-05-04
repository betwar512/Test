//
//  DetailViewController.h
//  Test
//
//  Created by Abbi H Safaie on 3/05/2014.
//  Copyright (c) 2014 Abbas H Safaie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favarouts.h"
#import "AppDelegate.h"

@interface DetailViewController : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *url;
@property (weak, nonatomic) IBOutlet UITextField *imageurl;

//getting this from rootViewController

@property NSString * urlRoot;


@end
