//
//  Parser.m
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import "Parser.h"
#import "WeatherDay.h"


@implementation Parser

- (void)parseResponse:(NSArray *)response completion:(void(^)(NSArray *parsedData))completion
{
    NSMutableArray *data = [@[] mutableCopy];
    [response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WeatherDay *weatherDay = [WeatherDay weatherDayWithDate:[NSDate dateWithTimeIntervalSinceNow:[obj[@"dt"] integerValue]]
                                                        dayTemp:[obj[@"temp"][@"day"] doubleValue]
                                                        minTemp:[obj[@"temp"][@"min"] doubleValue]
                                                        maxTemp:[obj[@"temp"][@"max"] doubleValue]
                                                           icon:obj[@"weather"][0][@"icon"]
                                                           main:obj[@"weather"][0][@"main"]];
        [data addObject:weatherDay];
    }];
    
    if (completion) {
        completion(data);
    }
}



@end
