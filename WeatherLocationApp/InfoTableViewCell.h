//
//  InfoTableViewCell.h
//  WeatherLocationApp
//
//  Created by apple on 20.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
