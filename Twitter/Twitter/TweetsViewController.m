//
//  TweetsViewController.m
//  Twitter
//
//  Created by Priyankaa Vijayakumar on 10/9/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetCell.h"
#import "ProfilelViewController.h"

@interface TweetsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *screenName;

@end

@implementation TweetsViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:22 green:166 blue:230 alpha:0.9]];
        
    }
    return self;
}

- (IBAction)didSwipeRight:(id)sender {
    NSLog(@"did swipe right");
    User *user = [User currentUser];
    
    NSString *posterUrl = [user valueForKeyPath:@"profileImageUrl"];
    [self.profilePic setImageWithURL:[NSURL URLWithString:posterUrl]];
    self.screenName.text = user.name;
    [UIView animateWithDuration:.50 animations:^{
        self.menuConstraint.constant = 160;
        
    }];
}
- (IBAction)menuProfile:(id)sender {
    [self profileSelect];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];

    [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];
   
    UIBarButtonItem *one = [[UIBarButtonItem alloc]initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:self action:@selector(profileSelect)];
    UIBarButtonItem *two = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutSelect)];
    [one setTintColor: [UIColor whiteColor]];
    [two setTintColor: [UIColor whiteColor]];
    
    // create a spacer
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = 30;
    
    NSArray *buttons = @[one, space, two];
    
    self.navigationItem.rightBarButtonItems = buttons;
    // Do any additional setup after loading the view from its nib.
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {

            for(Tweet *tweet in tweets){
                NSLog(@"tweet deets : %@ %@ %@", tweet.text, tweet.createdAt, tweet.user.name);
            }
        self.tweets = tweets;
        
        [self.tableView reloadData];
        
    }];
   
    
    
    
}
-(void) goBack {

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) profileSelect {
    [self.navigationController pushViewController:[[ProfilelViewController alloc] init] animated:YES];
    
}
- (void) logoutSelect {
    [User logout];
}
- (IBAction)onLogout:(id)sender {
    [User logout];
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
