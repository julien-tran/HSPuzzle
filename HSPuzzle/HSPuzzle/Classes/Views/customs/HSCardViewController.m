//
//  HSCardViewController.m
//  HSPuzzle
//
//  Created by Julien Tran on 28/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import "HSCardViewController.h"
#import "HSCard.h"
#import "HSMinion.h"
#import "HSWeapon.h"
#import "HSSpell.h"

@interface HSCardViewController ()
@property (nonatomic, weak) IBOutlet UIImageView    *cardFrame;
@property (nonatomic, weak) IBOutlet UIImageView    *minionImage;
@property (nonatomic, weak) IBOutlet UIImageView    *spellImage;
@property (nonatomic, weak) IBOutlet UIImageView    *weaponImage;
@end

@implementation HSCardViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUI
{
    if ([self.card isKindOfClass:[HSMinion class]])
    {
        HSMinion *minion = (HSMinion*)self.card;
        self.minionImage.image = [UIImage imageNamed:minion.cardName];
        self.weaponImage.image = nil;
    }
    else if ([self.card isKindOfClass:[HSWeapon class]])
    {
        HSWeapon *weapon = (HSWeapon*)self.card;
        self.weaponImage.image = [UIImage imageNamed:weapon.cardName];
        self.minionImage.image = nil;
    }
    else
    {
        self.minionImage.image = nil;
        self.weaponImage.image = nil;
    }
}

@end
