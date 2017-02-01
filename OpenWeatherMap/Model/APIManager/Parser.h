//
//  Parser.h
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

- (void)parseResponse:(NSDictionary *)response completion:(void(^)(NSArray *parsedData))completion;

@end
