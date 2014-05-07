//
//  masterViewController.h
//  Test
//
//  Created by Abbi H Safaie on 3/05/2014.
//  Copyright (c) 2014 Abbas H Safaie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Favarouts.h"
#import "DetailViewController.h"
#import "RootViewController.h"


@interface masterViewController : UITableViewController<DetailViewControllerDelegate>

//our Array

@property (nonatomic,strong)NSMutableArray*fetchedFavaroutsArray;


@end
