//
//  Tweet.h
//  Twitter
//
//  Created by Priyankaa Vijayakumar on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Tweet : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate * createdAt;
@property (strong, nonatomic) User *user;

- (id)initWithDictionary: (NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
