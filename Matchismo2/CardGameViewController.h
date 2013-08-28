//
//  CardGameViewController.h
//  Matchismo2
//
//  Created by Sonny Back on 7/22/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game; // property for our model object
@end
