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
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setButtons;
//@property (strong, nonatomic) CardMatchingGame *setGame;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel; // for displaying the score
@property (weak, nonatomic) IBOutlet UILabel *currentStatusLabel; // displays current status
@end

// private properties/methods implemented here. Actions go here as well.
@implementation SetGameViewController
//@synthesize setGame = _setGame;

// getter method with lazy instantiation
/*- (CardMatchingGame *)game {
    
    NSLog(@"setGame...");
    if (!_setGame){
        // uncomment once we have the count and deck defined
        _setGame = [[CardMatchingGame alloc] initWithCardCount:[self.setButtons count]
                                                     usingDeck:[self createSetDeck]];
    }
    
    return _setGame;
}*/

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
    [self createSetDeck];
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
