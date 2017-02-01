//
//  WeatherCell.m
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import "WeatherCell.h"
#import "WeatherDay.h"
#import <UIImageView+WebCache.h>


@implementation WeatherCell

- (void)configureCellWithWeatherDay:(WeatherDay *)weatherDay
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.statusLabel.text = weatherDay.main;
    self.tempDayLabel.text = [NSString stringWithFormat:@"%.0fº", weatherDay.dayTemp];
    self.tempMinLabel.text = [NSString stringWithFormat:@"Min: %.0fº", weatherDay.minTemp];
    self.tempMaxLabel.text = [NSString stringWithFormat:@"Max: %.0fº", weatherDay.maxTemp];
    self.dayTextLabel.text = [[self formatter] stringFromDate:weatherDay.date];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png", kIconURL, weatherDay.icon]];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:url
                          options:0
                         progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                self.iconImageView.image = image;
                            }
                        }];
}


- (NSDateFormatter *)formatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEEE";
    });
    return formatter;
}



@end
