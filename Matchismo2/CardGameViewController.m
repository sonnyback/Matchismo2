//
//  CardGameViewController.m
//  Matchismo - Assignment 1
//
//  Created by Sonny Back on 7/22/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

// private properties/methods declared here. Outlets go here as well.
@interface CardGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel; // for dispplaying # of flips
@property (nonatomic) int flipCount;
/* Important note: outlets allow the controller to talk to the view. Actions let the view talk to the controller*/
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons; // outlet collection of card buttons
@property (strong, nonatomic) CardMatchingGame *game; // property for our model object
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel; // for displaying the score
@property (weak, nonatomic) IBOutlet UILabel *currentStatusLabel; // displays current status. Assignment 1, task 3
@property (weak, nonatomic) UIImage *cardBackImage; // for card back image, assignment 1, task 7
@end

// private properties/methods implemented here. Actions go here as well.
@implementation CardGameViewController
@synthesize flipsLabel = _flipsLabel;
@synthesize currentStatusLabel = _currentStatusLabel;
@synthesize flipCount = _flipCount;
@synthesize cardButtons = _cardButtons;
@synthesize game = _game;
@synthesize cardBackImage = _cardBackImage;

// getter method for *game with lazy instantiation
- (CardMatchingGame *)game {
    
    //NSLog(@"Getter method for game...");
    // initialize with designated initializer from CardMatchingGame. Card count comes from # of buttons in the view
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
    
    return _game;
}

// getter for *cardBackImage - image used for back of cards
- (UIImage *)cardBackImage {
    
    if (!_cardBackImage) {
        _cardBackImage = [UIImage imageNamed:@"cardback4.jpeg"];
    }
    
    return _cardBackImage;
}

/** ORIGINAL METHOD FROM DEMO PART 1 OF THE ASSIGNMENT **/
// setter methos for *cardButton array property
/*- (void)setCardButtons:(NSArray *)cardButtons {
    
    NSLog(@"Entered setCardButtons...");
    _cardButtons = cardButtons;
    for (UIButton *cardButton in cardButtons) {
        Card *card = [self.deck drawRandomCard]; // draw a random card from the deck
        NSLog(@"Current card is: %@", card.contents);
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}*/

// setter method for *cardButtons array property
- (void)setCardButtons:(NSArray *)cardButtons {
    
    NSLog(@"Entered setCardButtons...");
    _cardButtons = cardButtons;
    [self updateUI]; // call method to update the UI
    
}

/**
 * Method for updating game UI. The main purpose of this method is to make the UI (view) match the model.
 *
 * @ return void
 */
- (void)updateUI {
    
    NSLog(@"UpdateUI...");
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]]; // *Important - this maps the UI to the model!
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp; // set the card to be face up
        cardButton.enabled = !card.isUnplayable; // make it unplayable
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0; // if the card is matched and now unplayable, change the appearance
        //[cardButton setImageEdgeInsets:UIEdgeInsetsMake(1,-1,-1,-1)];
        // set the image for the back of the card when the card is not selected - assignment 1, task 7
        if (!card.isFaceUp) {
            [cardButton setImage:self.cardBackImage forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score]; // update the score label with the score
}

/**
 * Setter method for flipCount which is used to update the number of times the card is flipped. This also updates 
 * the UI because when flipCount is incremented in the flipCard method, it calls this setter and here we're also
 * updating the flipLabel. 
 */
- (void)setFlipCount:(int)flipCount {
    
    //NSLog(@"Entered setFlipCount...");
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount]; // update flipsLabel with # of flips
}

/**
 * Method for flipping the card
 *
 * @param UIButton *sender (any one of the 16 card buttons on screen)
 * @return void
 */
- (IBAction)flipCard:(UIButton *)sender {
    
    NSLog(@"Entered flipCard...");
    
    // call logic in the model for flipping the card at a given index, i.e. the card selected
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    self.flipCount++; // increment each time card is flipped
    
    // set the currentStatusLabel with last flipped card and/or match result
    self.currentStatusLabel.text = [NSString stringWithFormat:@"%@", [self lastFlipResult:sender]];
    
    [self updateUI]; // update the UI
}

/**
 * Method for updating the currentStatusLabel - updates for current card flipped and indicates matches and no matches
 *
 * @param UIButton *sender
 * @return NSString - string to display status in the label
 */
- (NSString *)lastFlipResult:(UIButton *)sender {
    
    //NSLog(@"Entered lastFlipResult...");
    NSString *lastResult = @"";
    NSString *andConcatenate = @"and";
    NSMutableArray *arrayString = [[NSMutableArray alloc] init];
    Card *flippedCard = [self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    // create the array contents used to display the current status label
    if ([self.game match] == NO) { // add contents to array for a non-match
        if (self.game.lastFlippedCard.contents) {
            //NSLog(@"lastFlippedCard is**** %@", self.game.lastFlippedCard.contents);
            lastResult = [lastResult stringByAppendingString:@"No Match for "];
            [arrayString addObject:lastResult];
            [arrayString addObject:self.game.lastFlippedCard.description];
            [arrayString addObject:andConcatenate];
            [arrayString addObject:flippedCard.description];
        } else {
            //NSLog(@"No match in lastFlipResult!");
            lastResult = [lastResult stringByAppendingString:@"Flipped up "];
            [arrayString addObject:lastResult];
            [arrayString addObject:flippedCard.description];
        }
    } else if ([self.game match] == YES) { // add contents to array for a match
        //NSLog(@"Match in lastFlipResult!");
        lastResult = [lastResult stringByAppendingString:@"Matched "];
        [arrayString addObject:lastResult];
        [arrayString addObject:self.game.lastFlippedCard.description];
        [arrayString addObject:andConcatenate];
        [arrayString addObject:flippedCard.description];
        [arrayString addObject:@"!"];
    }
    
    return [arrayString componentsJoinedByString:@" "];
}

/**
 * Method for resetting game to get new deck of cards and reset score and flipcount.
 * This is for assignment 1, task 4
 *
 * @param UIButton *sender (deal button)
 * @return void
 */
- (IBAction)resetGame {
    
    //NSLog(@"Entered resetGame Matchismo...");
    self.game = nil; // set the current game to nil
    self.flipCount = 0; // reset flipcount to 0 for new game
    self.currentStatusLabel.text = @"Match suit or rank of two cards!"; // reset the label for new game
    [self updateUI];
    
}

@end
