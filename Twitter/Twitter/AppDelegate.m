//
//  AppDelegate.m
//  Twitter
//
//  Created by Priyankaa Vijayakumar on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "AppDelegate.h"
#import "TwitterClient.h"
#import "LoginViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    
    User *user = [User currentUser];
    if(user != nil) {
        NSLog(@"Welcome: %@", user.name);
        
        TweetsViewController *vc = [[TweetsViewController alloc]init];
        
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        
        self.window.rootViewController = nvc;

        //self.window.rootViewController = [[TweetsViewController alloc] init];
    } else {
        NSLog(@"Not logged in");
        LoginViewController *vc = [[LoginViewController alloc]init];
        
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        
        self.window.rootViewController = nvc;

        //self.window.rootViewController = [[LoginViewController alloc] init];
    }
    [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)userDidLogout {
    NSLog(@"Not logged in");
    self.window.rootViewController = [[LoginViewController alloc] init];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[TwitterClient sharedInstance] openURL:url];
    /*[[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
        NSLog(@"got the access token");
        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];
        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"current user : %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog(@"current user's name: %@", user.name);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed to get the current user");
        }];
        
        [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"tweets: %@", responseObject);
            NSArray *tweets = [Tweet tweetsWithArray:responseObject];
            for(Tweet *tweet in tweets) {
                NSLog(@"tweet: %@, created: %@", tweet.text, tweet.createdAt);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed to get the tweets");
        }];

        
    } failure:^(NSError *error) {
        NSLog(@"failed to get the access token");
    }]; */
    return YES;
}
@end
