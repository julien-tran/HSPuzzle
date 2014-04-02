//
//  HSCardSelectViewController.m
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import "HSCardSelectViewController.h"
#import "iCarousel.h"
#import "HSCard.h"
#import "HSCardViewController.h"
#import "HSDataCenter.h"

@interface HSCardSelectViewController ()
@property (nonatomic, weak) IBOutlet iCarousel      *cardCarousel;
@property (nonatomic, weak) IBOutlet UISearchBar    *searchBar;
@property (nonatomic, strong) NSArray *matchedResults;
@end

@implementation HSCardSelectViewController

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
    self.contentSizeForViewInPopover = self.view.bounds.size;
    self.cardCarousel.type = iCarouselTypeRotary;
    [self reloadSearchData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadSearchData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:NSStringFromClass([HSCard class]) inManagedObjectContext:[HSDataCenter sharedInstance].managedObjectContext]];
    if (0 < self.searchBar.text.length)
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"hero = NULL AND cardName CONTAINS[cd] %@", self.searchBar.text]];
    else
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"hero = NULL"]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"cardName" ascending:YES];
    [fetchRequest setSortDescriptors:@[sort]];
    
    self.matchedResults = [[HSDataCenter sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [self.cardCarousel reloadData];
}

#pragma mark - iCarousel methods
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.matchedResults.count;
}

- (UIView*)carousel:(iCarousel*)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView*)reuseView
{
    HSCard *card = self.matchedResults[index];
    HSCardViewController *cardVC = [[HSCardViewController alloc] initWithNibName:nil bundle:nil];
    cardVC.card = card;
    return cardVC.view;
}

- (CGFloat)carouselItemWidth:(iCarousel*)carousel
{
    return 150;
}

/* User tap to a card */
- (void)carousel:(iCarousel*)carousel didSelectItemAtIndex:(NSInteger)index
{
    // If it is the centered page, we select the card
    if (carousel.currentItemIndex == index)
    {
    }
}

/* The carousel type is Rotary, so its visual effect is not good if there are only
 * 2 items (the 2nd view is hidden behind the 1st view). In this case we add 2 more
 * placeholder items to make a better rotation effect. */
- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    if (2 == self.matchedResults.count)
        return 2;
    else
        return 0;
}

/* Placeholder view is simply an invisible placeholder empty card (to have the same dimension) */
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    HSCardViewController *cardVC = [[HSCardViewController alloc] initWithNibName:nil bundle:nil];
    cardVC.view.alpha = 0;
    return cardVC.view;
}

/* The carousel is wrapped, unless there are only 2 items or less */
- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
            if (self.matchedResults.count < 3)
                return NO;
            else
                return YES;
        default:
            return value;
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
    [self reloadSearchData];
}

@end