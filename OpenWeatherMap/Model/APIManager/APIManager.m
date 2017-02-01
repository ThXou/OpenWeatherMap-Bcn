//
//  APIManager.m
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import "APIManager.h"

static NSString *kAPIURL = @"http://api.openweathermap.org/data/2.5/forecast/daily?q=Barcelona&mode=json&units=metric&cnt=10&APPID=7855ff73bf07f8dc5cb11c3c93e28c24";


@interface APIManager () <NSURLSessionDownloadDelegate>

@property (nonatomic) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic) NSURLSession *backgroundSession;

@end


@implementation APIManager

- (void)downloadWeatherInformationWithCompletion:(void(^)(NSError *error))completion
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"sessionConfiguration"];
    self.backgroundSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    
    // start downloading
    
    NSURL *resourseURL = [NSURL URLWithString:kAPIURL];
    self.downloadTask = [self.backgroundSession downloadTaskWithURL:resourseURL];
    [self.downloadTask resume];
}



#pragma mark - Helpers

- (NSURL *)savedDataURL {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = paths[0];
    return [NSURL fileURLWithPath:[documentsPath stringByAppendingPathComponent:@"data.json"]];
}



#pragma mark - NSURLSession Delegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSURL *destinationURL = [self savedDataURL];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:[destinationURL path]]) {
        [fileManager removeItemAtURL:destinationURL error:&error];
        
        if (error) {
            return;
        }
    }
    
    [fileManager moveItemAtURL:location toURL:destinationURL error:&error];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kDownloadFinishNotification" object:error];
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    self.downloadTask = nil;
    
    if (error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kDownloadFinishNotification" object:error];
    }
}


@end
