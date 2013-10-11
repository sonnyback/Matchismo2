//
//  SetCard.h
//  Matchismo2
//
//  Created by Sonny Back on 8/27/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *pattern;
@property (strong, nonatomic) UIColor *colors2;

+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validPatterns;
+ (NSArray *)validNumbers;
+ (NSDictionary *)validColors2;

@end
