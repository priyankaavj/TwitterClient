//
//  LoginViewController.m
//  Twitter
//
//  Created by Priyankaa Vijayakumar on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if(user != nil) {
            //show tweets modally
            NSLog(@"Welcome user : %@", user.name);
            [self.navigationController pushViewController:[[TweetsViewController alloc] init] animated:YES];
            //[self presentViewController:[[TweetsViewController alloc] init] animated:YES completion:nil];
            
        }
        else {
            //error
        }
    }];
    /*[[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    [[TwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token" method: @"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"req token success");
        
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
        
        
    } failure:^(NSError *error) {
        NSLog(@"req token fail");
    }];*/
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"here");
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
