//
//  Favarouts.h
//  Test
//
//  Created by Abbi H Safaie on 6/05/2014.
//  Copyright (c) 2014 Abbas H Safaie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Favarouts : NSManagedObject

@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSData * image;

@end
