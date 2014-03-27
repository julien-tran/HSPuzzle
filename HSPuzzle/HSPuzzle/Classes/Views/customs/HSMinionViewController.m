//
//  HSMinionViewController.m
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import "HSMinionViewController.h"
#import "HSMinion.h"

@interface HSMinionViewController ()
@property (nonatomic, weak) IBOutlet UIImageView    *minionImage;
@property (nonatomic, weak) IBOutlet UIImageView    *tauntImage;
@property (nonatomic, weak) IBOutlet UIImageView    *silenceImage;
@property (nonatomic, weak) IBOutlet UIImageView    *frozenImage;
@property (nonatomic, weak) IBOutlet UIImageView    *divineImage;
@property (nonatomic, weak) IBOutlet UIImageView    *legendaryImage;
@property (nonatomic, weak) IBOutlet UIImageView    *stealthImage;
@end

@implementation HSMinionViewController

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
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUI
{
    self.tauntImage.hidden = !(self.minion.isTaunt.boolValue);
    self.stealthImage.hidden = !(self.minion.isStealth.boolValue);
    self.divineImage.hidden = !(self.minion.divineShield.boolValue);
    self.frozenImage.hidden = !(self.minion.isFrozen.boolValue);
    self.legendaryImage.hidden = YES;
    self.silenceImage.hidden = YES;
    self.minionImage.image = [UIImage imageNamed:self.minion.cardName];
}

@end