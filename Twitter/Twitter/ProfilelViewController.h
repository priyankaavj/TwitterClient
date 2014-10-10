//
//  ProfilelViewController.h
//  Twitter
//
//  Created by Priyankaa Vijayakumar on 10/9/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilelViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
