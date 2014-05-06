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

@class DetailViewController;

@protocol DetailViewControllerDelegate <NSObject>
-(void)detaiViewWillDis:(DetailViewController*)DetailViewController;

@end


@interface DetailViewController : UIViewController<UITextFieldDelegate>
@property NSManagedObject *favarout;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *url;
@property (weak, nonatomic) IBOutlet UITextField *imageurl;
@property (weak, nonatomic) IBOutlet UIImageView *imageVie;

//getting this from rootViewController

@property NSString * urlRoot;

@property id<DetailViewControllerDelegate>delegate;


@end
