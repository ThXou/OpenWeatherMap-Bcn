//
//  HomeViewController.m
//  OpenWeatherMap
//
//  Created by ThXou on 01/02/2017.
//  Copyright © 2017 ThXou. All rights reserved.
//

#import "HomeViewController.h"
#import "APIManager.h"


@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) APIManager *apiManager;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadFinished:)
                                                 name:@"kDownloadFinishNotification"
                                               object:nil];
    
    [self.activityIndicator startAnimating];
    
    
    self.apiManager = [[APIManager alloc] init];
    [self.apiManager downloadWeatherInformationWithCompletion:^(NSError *error) {
        
    }];
}



#pragma mark - Helpers

- (void)downloadFinished:(NSNotification *)notification
{
    if (notification.object) {
        NSLog(@"error: %@", notification.object);
    }
    else
    {
        NSError *error;
        NSURL *destinationURL = [self.apiManager savedDataURL];
        NSData *data = [NSData dataWithContentsOfURL:destinationURL];
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"ok: %@", response);
    }
}



#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"WeatherCell" forIndexPath:indexPath];
    return cell;
}




@end
