//
//  WeatherCell.h
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kIconURL = @"http://openweathermap.org/img/w/";

@class WeatherDay;
@interface WeatherCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempMinLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempMaxLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempDayLabel;
@property (nonatomic, weak) IBOutlet UILabel *dayTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;

- (void)configureCellWithWeatherDay:(WeatherDay *)weatherDay;

@end
