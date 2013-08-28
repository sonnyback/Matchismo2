//
//  SetCard.m
//  Matchismo2
//
//  Created by Sonny Back on 8/27/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
@synthesize number = _number;
@synthesize symbol = _symbol;
@synthesize color = _color;
@synthesize pattern = _pattern;

#define SYMBOL_CIRCLE @"●" // circle
#define SYMBOL_SQUARE @"■" // square
#define SYMBOL_TRI @"▲"  // triangle
#define PATTERN_OPEN @"open"
#define PATTERN_SOLID @"solid"
#define PATTERN_SHADED @"shaded"
#define COLOR_R @"red"
#define COLOR_G @"green"
#define COLOR_B @"blue"

- (void)setNumber:(NSNumber *)number {
    
    //NSLog(@"SetCard.setNumber: %@", number);
    if ([[SetCard validNumbers] containsObject:number]) {
        _number = number;
    }
         
}

- (NSString *)symbol {
    
     // if the symbol is one of the valid ones in the array use that otherwise use "?"
    return _symbol ? _symbol : @"?";
}
- (void)setSymbol:(NSString *)symbol {
    
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setColor:(NSString *)color {
    
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setPattern:(NSString *)pattern {
    
    if ([[SetCard validPatterns] containsObject:pattern]) {
        _pattern = pattern;
    }
}

/**
 * Method that creates a static array for the valid symbols used for the cards
 *
 * @return NSArray *symbols[circle, square, triangle]
 */
+ (NSArray *)validSymbols {
    
    static NSArray *symbols = nil;
    if (!symbols) symbols = @[SYMBOL_CIRCLE,SYMBOL_SQUARE,SYMBOL_TRI];
    
    //NSLog(@"validSymbols %@", symbols);
    return symbols;
}

/**
 * Method that creates a static array for the valid colors used for the symbols on the cards
 *
 * @return NSArray *colors[red, green, blue]
 */
+ (NSArray *)validColors {
    
    static NSArray *colors = nil;
    
    if (!colors) colors = @[COLOR_R,COLOR_G,COLOR_B];
    
    //NSLog(@"validColors %@", colors);
    return colors;
}

/**
 * Method that creates a static array for the valid shading patterns used for the symbols on the cards
 *
 * @return NSArray *patterns[open, solid, shaded]
 */
+ (NSArray *)validPatterns {
    
    static NSArray *patterns = nil;
    
    if (!patterns) patterns = @[PATTERN_OPEN,PATTERN_SOLID,PATTERN_SHADED];
    
    //NSLog(@"validPatterns %@", patterns);
    return patterns;
}

/**
 * Method that creates a static array for the valid numbers of symbols that each card can have
 *
 * @return NSArray *numbers
 */
+ (NSArray *)validNumbers {
    
    static NSArray *numbers = nil;
    
    if (!numbers) numbers = @[@(1),@(2),@(3)];
    
    //NSLog(@"validNumbers %@", numbers);
    return numbers;
}

@end
