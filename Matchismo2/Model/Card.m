//
//  Card.m
//  Matchismo2
//
//  Created by Sonny Back on 7/22/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    
    NSLog(@"Entered Card.match...");
    int score = 0; // set initial score to 0
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

/**
 * Method to override description method and return description (contents) of the Card
 *
 * @return NSString - card contents
 */
- (NSString *)description {
    
    return self.contents;
}

@end
