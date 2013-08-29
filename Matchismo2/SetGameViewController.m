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

    [self updateSetGameUI];
}

- (void)updateSetGameUI {
    
    NSLog(@"updateSetGameUI");
    
    for (UIButton *setButton in self.gameButtons) {
        Card *card = [self.setGame cardAtIndex:[self.gameButtons indexOfObject:setButton]];
        [setButton setTitle:card.description forState:UIControlStateSelected];
        [setButton setTitle:card.description forState:UIControlStateSelected|UIControlStateDisabled];
    }
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

@end
