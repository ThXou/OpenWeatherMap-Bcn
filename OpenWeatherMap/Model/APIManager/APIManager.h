//
//  APIManager.h
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

- (void)downloadWeatherInformation;
- (NSURL *)savedDataURL;

@end
