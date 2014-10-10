//
//  ProfilelViewController.m
//  Twitter
//
//  Created by Priyankaa Vijayakumar on 10/9/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ProfilelViewController.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"
#import "User.h"
#import "TweetCell.h"

@interface ProfilelViewController ()
@property (nonatomic, strong) NSArray *tweets;

@end

@implementation ProfilelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    // Do any additional setup after loading the view from its nib.
    User *user = [User currentUser];
    self.synopsis.text = user.tagline;
    self.screenName.text = user.name;
    NSString *posterUrl = [user valueForKeyPath:@"profileImageUrl"];
    [self.profileImage setImageWithURL:[NSURL URLWithString:posterUrl]];
    NSString *bkgUrl = [user valueForKeyPath:@"bkgImageUrl"];
    [self.coverImage setImageWithURL:[NSURL URLWithString:bkgUrl]];
    
    [[TwitterClient sharedInstance] profileTimelineWithParams:@{@"user_id": @"priyankaavj"} completion:^(NSArray *tweets, NSError *error) {
        
        self.tweets = tweets;
        [self.tableView reloadData];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Tweet *tweet = self.tweets[indexPath.row];
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.titleLabel.text = tweet.user.name;
    cell.synopsisLabel.text = tweet.text;
    NSString *posterUrl = [tweet.user valueForKeyPath:@"profileImageUrl"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
