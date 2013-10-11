//
//  SetGameViewController.m
//  Set matching game - Assignment 2
//
//  Created by Sonny Back on 8/24/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "SetGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import <QuartzCore/QuartzCore.h>

// private properties and methods go here...Oulets as well.
@interface SetGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel; // for dispplaying # of flips
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *gameButtons;
@property (strong, nonatomic) CardMatchingGame *setGame;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel; // for displaying the score
@property (weak, nonatomic) IBOutlet UILabel *currentStatusLabel; // displays current status
@end

// private properties/methods implemented here. Actions go here as well.
@implementation SetGameViewController
@synthesize setGame = _setGame;
@synthesize gameButtons = _gameButtons;
@synthesize flipCount = _flipCount;
@synthesize currentStatusLabel = _currentStatusLabel;

// getter method with lazy instantiation
- (CardMatchingGame *)setGame {
    
    //NSLog(@"Getter method for setGame...");
    if (!_setGame){
        // uncomment once we have the count and deck defined
        _setGame = [[CardMatchingGame alloc] initWithCardCount:[self.gameButtons count]
                                                     usingDeck:[[SetCardDeck alloc] init]];
    }
    
    return _setGame;
}

- (void)setGameButtons:(NSArray *)gameButtons {
    
    NSLog(@"Entered setGameButtons...");
    _gameButtons = gameButtons;
    
    // button rendering properties
    for (UIButton *button in self.gameButtons) {
        button.showsTouchWhenHighlighted = TRUE;
        button.layer.cornerRadius = 3;
        button.layer.borderWidth = 1;
        button.clipsToBounds = YES;
        button.showsTouchWhenHighlighted = TRUE;
        button.layer.borderColor = [UIColor blackColor].CGColor;
    }

    [self updateUI]; // update the UI
}

/**
 * Method for updating game UI. The main purpose of this method is to make the UI (view) match the model.
 *
 * @ return void
 */
- (void)updateUI {
    
    NSLog(@"UpdateUI...");
    NSDictionary *attributes = nil;
    NSString *shapeKey = @"shape";
    NSString *numberKey = @"number";
    
    // render all the game buttons with attributed strings based on the dictionary of attributes
    for (UIButton *setButton in self.gameButtons) {
        Card *card = [self.setGame cardAtIndex:[self.gameButtons indexOfObject:setButton]]; // map the Card from the deck to the button
        //[setButton setImageEdgeInsets:UIEdgeInsetsMake(1,-1,-1,-1)];
        attributes = [self getCardAttributes:card]; // get the attributes for the given Card
        
        NSMutableAttributedString *mat = [[NSMutableAttributedString alloc] init];
        // used to render the correct shape for each card
        NSMutableAttributedString *shapes = [[NSMutableAttributedString alloc] initWithString:attributes[shapeKey]];
        NSRange range = [[shapes string] rangeOfString:attributes[shapeKey]];
        
        if (range.location != NSNotFound) {
            [shapes addAttributes:attributes range:range];
            
            int numberOfShapes = [attributes[numberKey] integerValue]; // to determine # of shapes to render
            // loop through and append the shape(s) for the correct number of shapes for each card
            for (int i = 1; i <= numberOfShapes; i++) {
                [mat appendAttributedString:shapes];
            }
            
            // add the attributed string to render the image on the card
            [setButton setAttributedTitle:mat forState:UIControlStateNormal];
            //setButton.showsTouchWhenHighlighted = TRUE;
            
            setButton.selected = card.isSelected; // button is selected if card is as well
            setButton.enabled = !card.isUnplayable; // disable the button if the card is unplayable
            
            // if selected, make the card black so we know it's a card waiting to be matched
            [setButton setBackgroundColor:setButton.isSelected ? [UIColor blackColor] : [UIColor whiteColor]];
            setButton.alpha = card.isUnplayable ? 0.0 : 1.0;
            
        }
    }
}

/**
 * Method to get the attributes for each SetCard, i.e. number, shape, color, pattern
 *
 * @param Card *card (current card)
 * @return NSDictionary *cardAttributes
 */
- (NSMutableDictionary *)getCardAttributes:(Card *)card {
    
    //NSLog(@"Entered getCardAttributes...");
    NSMutableDictionary *cardAttributes = [[NSMutableDictionary alloc] init];
    //UIColor *color = nil;
    NSString *shapeKey = @"shape";
    //NSString *colorKey = @"color";
    //NSString *patternKey = @"pattern";
    NSString *numberKey = @"number";
    
    // create the dictionary based on the SetCard attributes
    if (card) { // make sure card is not null
        if ([card isKindOfClass:[SetCard class]]) { // use introspection to ensure we have the right type of card (SetCard)
            SetCard *setCard = (SetCard *)card; // create the SetCard
            
            // get the shape (symbol) and add to the dictionary
            [cardAttributes setValue:setCard.symbol forKey:shapeKey];
            
            // get the number and add to the dictionary
            [cardAttributes setValue:setCard.number forKey:numberKey];
            
            // add the attributes based on the pattern - solid, open, shaded
            if ([setCard.pattern isEqualToString:@"solid"]) { // draw a solid shape
                [cardAttributes setValue:setCard.colors2 forKey:NSForegroundColorAttributeName];
            } else if ([setCard.pattern isEqualToString:@"open"]) { // draw the shape with the stroke only
                [cardAttributes setValue:@(5) forKey:NSStrokeWidthAttributeName];
                [cardAttributes setValue:setCard.colors2 forKey:NSStrokeColorAttributeName];
            } else if ([setCard.pattern isEqualToString:@"shaded"]) { // draw shape with the stroke and fill with "shaded" color
                [cardAttributes setValue:[setCard.colors2 colorWithAlphaComponent:0.3] forKey:NSForegroundColorAttributeName];
                [cardAttributes setValue:@(-5) forKey:NSStrokeWidthAttributeName];
                [cardAttributes setValue:setCard.colors2 forKey:NSStrokeColorAttributeName];
            }
            
            // get the color and add it to the dictionary
            /*if ([setCard.color isEqualToString:@"red"]) {
                color = [UIColor redColor];
                [cardAttributes setValue:color forKey:NSForegroundColorAttributeName];
                //[cardAttributes setValue:@(5) forKey:NSStrokeWidthAttributeName];
                //[cardAttributes setValue:[UIColor redColor] forKey:NSStrokeColorAttributeName];
            } else if ([setCard.color isEqualToString:@"green"]) {
                color = [UIColor greenColor];
                [cardAttributes setValue:color forKey:NSForegroundColorAttributeName];
            } else if ([setCard.color isEqualToString:@"blue"]) {
                color = [UIColor blueColor];
                [cardAttributes setValue:color forKey:NSForegroundColorAttributeName];
            }*/
            
            //[cardAttributes setValue:setCard.colors2 forKey:NSForegroundColorAttributeName];
        }
    }
    
    return cardAttributes;
}

/**
 * Setter method for flipCount which is used to update the number of times the card is flipped(selected). This also updates
 * the UI because when flipCount is incremented in the flipCard method, it calls this setter and here we're also
 * updating the flipLabel.
 * 
 * @param int
 * @return void
 */
- (void)setFlipCount:(int)flipCount {
    
    //NSLog(@"Entered setFlipCount...");
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount]; // update flipsLabel with # of flips
}

/**
 * Method for detecting the card selected
 *
 * @param UIButton *sender
 * @return void
 */
- (IBAction)selectedCard:(UIButton *)sender {
    
    Card *card = [self.setGame cardAtIndex:[self.gameButtons indexOfObject:sender]];
    sender.selected = !sender.selected; // set to the opposite state to track playability status
    NSLog(@"selectedCard...%@", card.description);
    self.flipCount++; // increment flipcount for each time card is selected
    
    [self.setGame selectSetCardAtIndex:[self.gameButtons indexOfObject:sender]];
    
    // update the current status label with the current card/status
    self.currentStatusLabel.attributedText = [self lastSelectedCard:[self getCardAttributes:card] forCard:card];
    
    [self updateUI];
}

/**
 * Method for updating the currentStatusLabel - updates for current card selected and indicates matches and no matches
 *
 * @param NSDictionary *attributes of the current Card
 * @return NSAttributedString - Attributed string to display status in the label
 */
- (NSAttributedString *)lastSelectedCard:(NSDictionary *)attributes forCard:(Card *)card {
    
    //NSLog(@"Entered lastSelectedCard...");
    NSString *shapeKey = @"shape";
    NSString *numberKey = @"number";
    //NSString *lastResult = @"";
    //NSString *andConcatenate = @"and";
    //NSMutableArray *arrayString = [[NSMutableArray alloc] init];
    NSMutableAttributedString *mat = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *shapes = [[NSMutableAttributedString alloc] initWithString:attributes[shapeKey]];
    NSRange range = [[shapes string] rangeOfString:attributes[shapeKey]];
    [shapes addAttributes:attributes range:range];
    
    //NSLog(@"lastFlippedCard - %@", self.setGame.lastSelectedSetCard); // won't work until match algorithm is implemented
    
    if (range.location != NSNotFound) {
        [shapes addAttributes:attributes range:range];
        
        int numberOfShapes = [attributes[numberKey] integerValue]; // to determine # of shapes to render
        // loop through and append the shape(s) for the correct number of shapes for each card
        for (int i = 1; i <= numberOfShapes; i++) {
            [mat appendAttributedString:shapes];
        }
        
    }

    
    return mat;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Deck *)createSetDeck {
    
    NSLog(@"createSetDeck");
    return [[SetCardDeck alloc] init];
}

/**
 * Method for resetting game to get new deck of cards and reset score and flipcount.
 * This is for assignment 2, task 7
 *
 * @return void
 */
- (IBAction)resetGame {
    
    NSLog(@"Entered resetGame SetGame...");
    self.setGame = nil;
    self.flipCount = 0;
    self.currentStatusLabel.text = @"Play Set!"; // reset the label for new game
    // make sure all the buttons are not in selected state for new game
    for (UIButton *button in self.gameButtons) {
        button.selected = NO;
    }
    [self updateUI];
}

@end
