//
//  RootViewController.h
//  Test
//
//  Created by Abbi H Safaie on 3/05/2014.
//  Copyright (c) 2014 Abbas H Safaie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITextFieldDelegate>

@property NSString*url;


@property (weak, nonatomic) IBOutlet UITextField *urlTextfield;
@property (weak, nonatomic) IBOutlet UIWebView *myWeb;

@end
