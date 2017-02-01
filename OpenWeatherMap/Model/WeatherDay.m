//
//  WeatherDay.m
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import "WeatherDay.h"

@implementation WeatherDay

- (instancetype)initWithDate:(NSDate *)date dayTemp:(double)dayTemp minTemp:(double)minTemp maxTemp:(double)maxTemp icon:(NSString *)icon main:(NSString *)main
{
    self = [super init];
    if (self) {
        self.date = date;
        self.dayTemp = dayTemp;
        self.minTemp = minTemp;
        self.maxTemp = maxTemp;
        self.icon = icon;
        self.main = main;
    }
    return self;
}


+ (WeatherDay *)weatherDayWithDate:(NSDate *)date dayTemp:(double)dayTemp minTemp:(double)minTemp maxTemp:(double)maxTemp icon:(NSString *)icon main:(NSString *)main {
    return [[self alloc] initWithDate:date dayTemp:dayTemp minTemp:minTemp maxTemp:maxTemp icon:icon main:main];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"day: %f | min: %f | max: %f", self.dayTemp, self.minTemp, self.maxTemp];
}



@end
