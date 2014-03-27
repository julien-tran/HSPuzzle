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

@interface HSPuzzleBuilderViewController ()
@property (nonatomic, weak) IBOutlet UIView *menuViewContainer;

@property (nonatomic, strong) UIPopoverController *currentPopover;
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
    HSHeroEditViewController *heroEditVC = [[HSHeroEditViewController alloc] initWithNibName:nil bundle:nil];
    self.currentPopover = [[UIPopoverController alloc] initWithContentViewController:heroEditVC];
    [self.currentPopover presentPopoverFromRect:heroEditButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.currentPopover.delegate = self;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController*)popoverController
{
    self.currentPopover = nil;
}

@end
