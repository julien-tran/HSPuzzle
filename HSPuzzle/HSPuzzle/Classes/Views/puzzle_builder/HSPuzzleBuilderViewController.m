//
//  HSPuzzleBuilderViewController.m
//  HSPuzzle
//
//  Created by Julien Tran on 26/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import "HSPuzzleBuilderViewController.h"

// Views
#import "HSPuzzleBuilderMenuViewController.h"

// Popovers
#import "HSHeroEditViewController.h"

// Data
#import "HSDataCenter.h"
#import "HSScene.h"
#import "HSHero.h"

@interface HSPuzzleBuilderViewController ()
@property (nonatomic, weak) IBOutlet UIView *menuViewContainer;

// Hero View
@property (nonatomic, weak) IBOutlet UIButton       *heroEditButton;
@property (nonatomic, weak) IBOutlet UIImageView    *heroPowerImageView;
@property (nonatomic, weak) IBOutlet UIButton       *villainEditButton;
@property (nonatomic, weak) IBOutlet UIImageView    *villainPowerImageView;

@property (nonatomic, strong) UIPopoverController *currentPopover;

// Data
@property (nonatomic, strong) HSScene   *scene;
@property (nonatomic, strong) HSHero    *hero;
@property (nonatomic, strong) HSHero    *villain;
@end

@implementation HSPuzzleBuilderViewController

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
    HSPuzzleBuilderMenuViewController *menuViewController = [[HSPuzzleBuilderMenuViewController alloc] initWithNibName:nil bundle:nil];
    [self.menuViewContainer addSubview:menuViewController.view];
    menuViewController.view.frame = self.view.bounds;
    [self addChildViewController:menuViewController];
    
    // Init data
    self.scene = [HSDataCenter sharedInstance].newScene;
    self.hero = [HSDataCenter sharedInstance].newHero;
    self.hero.scene = self.scene;
    self.villain = [HSDataCenter sharedInstance].newHero;
    self.villain.isVillain = @(YES);
    self.villain.scene = self.scene;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - User Actions
- (IBAction)heroEditButtonDidClick:(UIButton*)heroEditButton
{
    // Create the hero edit popover. This could be to edit the hero or the villain
    HSHeroEditViewController *heroEditVC = [[HSHeroEditViewController alloc] initWithNibName:nil bundle:nil];
    if (heroEditButton == self.heroEditButton)
        heroEditVC.hero = self.hero;
    else
        heroEditVC.hero = self.villain;
    
    // Display the popover
    self.currentPopover = [[UIPopoverController alloc] initWithContentViewController:heroEditVC];
    [self.currentPopover presentPopoverFromRect:heroEditButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.currentPopover.delegate = self;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController*)popoverController
{
    self.currentPopover = nil;
    if ([popoverController.contentViewController isKindOfClass:[HSHeroEditViewController class]])
    {
        HSHeroEditViewController *heroEditVC = (HSHeroEditViewController*)popoverController.contentViewController;
        [self reloadViewForHero:heroEditVC.hero];
    }
}

#pragma mark - Data
- (void)reloadViewForHero:(HSHero*)hero
{
    UIImageView *heroPowerImageView = self.heroPowerImageView;
    UIButton *heroEditButton = self.heroEditButton;
    if (hero.isVillain.boolValue)
    {
        heroPowerImageView = self.villainPowerImageView;
        heroEditButton = self.villainEditButton;
    }
    
    [heroEditButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hero_avatar_%@", hero.heroID]]
                    forState:UIControlStateNormal];
    heroPowerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hero_power_%@", hero.heroID]];
}

@end
