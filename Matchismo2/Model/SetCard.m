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
@synthesize colors2 = _colors2;

#define SYMBOL_CIRCLE @"●" // circle
#define SYMBOL_SQUARE @"■" // square
#define SYMBOL_TRI @"▲"  // triangle
#define PATTERN_OPEN @"open"
#define PATTERN_SOLID @"solid"
#define PATTERN_SHADED @"shaded"
#define COLOR_R @"red"
#define COLOR_G @"green"
#define COLOR_B @"blue"

/**
 * This method overrides Card's implementation so that we can match based on rank or suit
 *
 * @param NSArray *otherCards
 * @return int - the score
 */
- (int)match:(NSArray *)otherCards {
    
    NSLog(@"Entered SetCard.match...");
    
    int score = 0; // to determine if it's a match or not; 0 = no match, 1 = match
    
    if ([otherCards count] == 2) {
        if ([self isKindOfClass:[SetCard class]]) { // introspect the class to make sure it's a SetCard
            SetCard *setCard1 = self; // first matching card is self
            if ([otherCards indexOfObject:[SetCard class]]) { // introspect the array to make sure it has SetCards
                SetCard *setCard2 = otherCards[0];
                SetCard *setCard3 = otherCards[1];
                
                if (
                    (  // either there are three cards all of the same number:
                     ((setCard1.number == setCard2.number) &&
                      (setCard2.number == setCard3.number) &&
                      (setCard1.number == setCard3.number))
                     ||
                     // or all three different numbers...
                     ((setCard1.number != setCard2.number) &&
                      (setCard2.number != setCard3.number) &&
                      (setCard1.number != setCard3.number)
                      )
                     )
                    &&   // AND as if that wasn't hard enough we must also have
                    ( // either all three of the same symbol
                     ([setCard1.symbol isEqualToString:setCard2.symbol] &&
                      [setCard2.symbol isEqualToString:setCard2.symbol] &&
                      [setCard3.symbol isEqualToString:setCard3.symbol])
                     ||
                     // or all three different symbols
                     ((![setCard1.symbol isEqualToString:setCard2.symbol]) &&
                      (![setCard2.symbol isEqualToString:setCard3.symbol]) &&
                      (![setCard1.symbol isEqualToString:setCard3.symbol])
                      )
                     )
                    &&  // AND ...
                    ( // all same or all different shading
                     ([setCard1.pattern isEqualToString:setCard2.pattern] &&
                      [setCard2.pattern isEqualToString:setCard3.pattern] &&
                      [setCard1.pattern isEqualToString:setCard3.pattern])
                     || // or all different shading
                     ((![setCard1.pattern isEqualToString:setCard2.pattern]) &&
                      (![setCard2.pattern isEqualToString:setCard3.pattern]) &&
                      (![setCard1.pattern isEqualToString:setCard3.pattern])
                      )
                     )
                    &&
                    ( // AND all same or all different color!
                     ([[self getStringFromColor:setCard1.colors2] isEqualToString:[self getStringFromColor:setCard2.colors2]] &&
                      [[self getStringFromColor:setCard2.colors2] isEqualToString:[self getStringFromColor:setCard3.colors2]] &&
                      [[self getStringFromColor:setCard1.colors2] isEqualToString:[self getStringFromColor:setCard3.colors2]])
                     || // or all different color!
                     ((![[self getStringFromColor:setCard1.colors2] isEqualToString:[self getStringFromColor:setCard2.colors2]]) &&
                      (![[self getStringFromColor:setCard2.colors2] isEqualToString:[self getStringFromColor:setCard3.colors2]]) &&
                      (![[self getStringFromColor:setCard1.colors2] isEqualToString:[self getStringFromColor:setCard3.colors2]])
                      )
                     )
                    ) score = 1; // matching criteria passed!
            }
        }
    } else {
        NSLog(@"Error - not enough Cards passed in the array. Not able to match!");
    }
    
    return score;
}


- (void)setNumber:(NSNumber *)number {
    
    //NSLog(@"SetCard.setNumber: %@", number);
    // if number is one of the valide ones, set the number
    if ([[SetCard validNumbers] containsObject:number]) {
        _number = number;
    }
         
}

- (NSString *)symbol {
    
     // if the symbol is one of the valid ones in the array use that otherwise use "?"
    return _symbol ? _symbol : @"?";
}
- (void)setSymbol:(NSString *)symbol {
    
    // if symbol is one of the valide ones, set the symbol
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setColor:(NSString *)color {
    
    // if color is one of the valide ones, set the color
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setPattern:(NSString *)pattern {
    
    // if pattern is one of the valide ones, set the pattern
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

+ (NSArray *)validColors2 {
    
    static NSArray *colors2 = nil;
    
    if (!colors2) colors2 = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    
    return colors2;
}
/*+ (NSDictionary *)validColors2 {
    
    NSDictionary *colors2 = nil;
    
    if (!colors2) {
        colors2 = @{COLOR_R : [UIColor redColor],
                    COLOR_G : [UIColor greenColor],
                    COLOR_B : [UIColor blueColor]};
    }
    
    return colors2;
}*/

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

/**
 * Override description method to return a description of the SetCard with all the data members
 *
 * @return NSString *description
 */
- (NSString *)description {
    
    //return [NSString stringWithFormat:@"%@-%@-%@-%@", self.symbol, self.color, self.number, self.pattern];
    //return [NSString stringWithFormat:@"%@-%@-%@-%@", self.symbol, self.colors2.description, self.number, self.pattern];
    return [NSString stringWithFormat:@"%@-%@-%@-%@", self.symbol, [self getStringFromColor:self.colors2], self.number, self.pattern];
}

/**
 * Method to convert the UIColor to a printable string based on the UIColor description value
 *
 * @param UIColor
 * @return NSString
 */
- (NSString *)getStringFromColor:(UIColor *)theColor {
    
    NSString *colorString = @"";
    
    if ([theColor.description isEqualToString:@"UIDeviceRGBColorSpace 0 0 1 1"]) {
        //NSLog(@"color is blue");
        colorString = [NSString stringWithFormat:@"blue"];
    } else if ([theColor.description isEqualToString:@"UIDeviceRGBColorSpace 0 1 0 1"]) {
        //NSLog(@"color is green");
        colorString = [NSString stringWithFormat:@"green"];
    } else if ([theColor.description isEqualToString:@"UIDeviceRGBColorSpace 1 0 0 1"]) {
        //NSLog(@"color is red");
        colorString = [NSString stringWithFormat:@"red"];
    }
    
    return colorString;
}

/**
 * Returns the string value of the NSNumber
 *
 * @param NSNumber
 * @return NSString
 */
- (NSString *)getStringFromNumber:(NSNumber *)number {
    
    return [number stringValue];
}

/**
 * Override contents method to return a consolidated contents description of the SetCard
 *
 */
- (NSString *)contents {
    
    return [NSString stringWithFormat:@"%@ %@ %@ %@", self.symbol, self.color, self.number, self.pattern];
}

@end
