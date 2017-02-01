//
//  HomeViewController.m
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import "HomeViewController.h"
#import "WeatherCell.h"
#import "WeatherDay.h"
#import "APIManager.h"
#import "Parser.h"
#import <UIImageView+WebCache.h>


@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempMinLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempMaxLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempDayLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;

@property (nonatomic) APIManager *apiManager;
@property (nonatomic) Parser *parser;
@property (nonatomic) NSArray *weatherData;
@property (nonatomic) WeatherDay *today;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.apiManager = [[APIManager alloc] init];
    self.parser = [[Parser alloc] init];
    
    [self.apiManager downloadWeatherInformation];
    [self.activityIndicator startAnimating];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadFinished:)
                                                 name:@"kDownloadFinishNotification"
                                               object:nil];
}



#pragma mark - Helpers

- (void)downloadFinished:(NSNotification *)notification
{
    [self.activityIndicator stopAnimating];
    
    if (notification.object) {
        NSLog(@"error: %@", notification.object);
    }
    else
    {
        NSError *error;
        NSURL *destinationURL = [self.apiManager savedDataURL];
        NSData *data = [NSData dataWithContentsOfURL:destinationURL];
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        [self.parser parseResponse:response[@"list"] completion:^(NSArray *parsedData) {
            self.today = [parsedData firstObject];
            [self showTodayData];
            
            NSMutableArray *mutableData = [parsedData mutableCopy];
            [mutableData removeObjectAtIndex:0];
            self.weatherData = mutableData;
            [self.tableView reloadData];
        }];
    }
}


- (void)showTodayData
{
    self.statusLabel.text = self.today.main;
    self.tempDayLabel.text = [NSString stringWithFormat:@"%.0fº", self.today.dayTemp];
    self.tempMinLabel.text = [NSString stringWithFormat:@"Min: %.0fº", self.today.minTemp];
    self.tempMaxLabel.text = [NSString stringWithFormat:@"Max: %.0fº", self.today.maxTemp];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png", kIconURL, self.today.icon]];
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



#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weatherData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherDay *weatherDay = self.weatherData[indexPath.row];
    
    WeatherCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"WeatherCell" forIndexPath:indexPath];
    [cell configureCellWithWeatherDay:weatherDay];
    return cell;
}



@end
