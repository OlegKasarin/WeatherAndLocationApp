//
//  HistoryManager.h
//  WeatherLocationApp
//
//  Created by apple on 21.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemObject.h"

@interface HistoryManager : NSObject

@property (strong, nonatomic) NSMutableArray* itemObjects;

+ (HistoryManager*)sharedInstance;
- (void)addObject: (ItemObject*) itemObject;

@end
