//
//  SetCardDeck.m
//  Matchismo2
//
//  Created by Sonny Back on 8/27/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    
    NSLog(@"SetCardDeck.init!");
    
    self = [super init]; // initialize super class
    
    if (self) {
        for (int i = 1; i <= 3; i++)
            for (NSString *symbol in [SetCard validSymbols])
                for (NSString *color in [SetCard validColors])
                    for (NSString *pattern in [SetCard validPatterns]) {
                        SetCard *setCard = [[SetCard alloc] init];
                        setCard.symbol = symbol; // set the symbol
                        setCard.color = color;
                        setCard.pattern = pattern; // set the shading pattern
                        setCard.number = [NSNumber numberWithInt:i]; // set the number of symbols
                        //[self addCard:setCard atTop:YES];
                        NSLog(@"SetCard Symbol: %@ Number: %@ Color: %@ Pattern: %@", setCard.symbol, setCard.number, setCard.color, setCard.pattern);
                        //NSLog(@"SetCardDeck - card: %@", setCard.description);
                    }
    }
    
    return self;
}

@end
