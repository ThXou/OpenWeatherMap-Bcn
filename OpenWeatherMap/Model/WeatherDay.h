//
//  WeatherDay.h
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherDay : NSObject

@property (nonatomic) NSDate *date;
@property (nonatomic) double dayTemp;
@property (nonatomic) double minTemp;
@property (nonatomic) double maxTemp;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *main;

- (instancetype)initWithDate:(NSDate *)date dayTemp:(double)dayTemp minTemp:(double)minTemp maxTemp:(double)maxTemp icon:(NSString *)icon main:(NSString *)main;

+ (WeatherDay *)weatherDayWithDate:(NSDate *)date dayTemp:(double)dayTemp minTemp:(double)minTemp maxTemp:(double)maxTemp icon:(NSString *)icon main:(NSString *)main;

@end
