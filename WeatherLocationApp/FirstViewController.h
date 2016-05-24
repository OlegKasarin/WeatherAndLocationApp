//
//  FirstViewController.h
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import "WeatherManager.h"
#import "HistoryManager.h"
#import "ItemObject.h"

@interface FirstViewController : UIViewController

@property (strong, nonatomic) ItemObject* itemObj;

+ (instancetype)StoryboardInstance;

@end
