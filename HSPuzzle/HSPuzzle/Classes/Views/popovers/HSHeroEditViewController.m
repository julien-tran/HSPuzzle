//
//  HSHeroEditViewController.m
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import "HSHeroEditViewController.h"

// Data
#import "HSDataCenter.h"
#import "HSHero.h"

// Custom Views
#import "iCarousel.h"

@interface HSHeroEditViewController ()
@property (nonatomic, weak) IBOutlet iCarousel  *heroCarousel;
@property (nonatomic, weak) IBOutlet UIView     *editView;

@property (nonatomic, strong) NSArray *heroIDList;
@end

@implementation HSHeroEditViewController

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
    
    self.heroCarousel.type = iCarouselTypeRotary;
    self.heroIDList = [HSDataCenter heroIDList];
    [self.heroCarousel reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - iCarousel methods
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.heroIDList.count;
}

- (UIView*)carousel:(iCarousel*)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView*)reuseView
{
    if (nil == reuseView)
    {
        reuseView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    NSString *heroID = self.heroIDList[index];
    NSString *heroImageName = [NSString stringWithFormat:@"hero_avatar_%@", heroID];
    
    UIImageView *reuseImageView = (UIImageView*)reuseView;
    reuseImageView.image = [UIImage imageNamed:heroImageName];
    [reuseImageView sizeToFit];
    return reuseImageView;
}

- (CGFloat)carouselItemWidth:(iCarousel*)carousel
{
    return 150;
}

- (CGFloat)carousel:(iCarousel*)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    // The carousel is wrapped
    switch (option)
    {
        case iCarouselOptionWrap:
            return YES;
        default:
            return value;
    }
}

- (void)carouselWillBeginDragging:(iCarousel*)carousel;
{
    // Hide the edit view when the scrolling starts
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^(){
        weakSelf.editView.alpha = 0;
    }];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel*)carousel
{
    // When the scrolling stop, we show the edit view again
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^(){
        weakSelf.editView.alpha = 1;
    }];
    
    self.hero.heroID = self.heroIDList[carousel.currentItemIndex];
}

/* User tap to a cover page */
- (void)carousel:(iCarousel*)carousel didSelectItemAtIndex:(NSInteger)index
{
    // If it isn't the centered page, we scroll to that page (automatically done
    // by iCarousel) and manually call appropriate delegate methods.
    if (carousel.currentItemIndex != index)
    {
        [self carouselWillBeginDragging:carousel];
    }
}

@end
