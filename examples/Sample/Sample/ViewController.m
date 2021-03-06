//
//  ViewController.m
//  Sample
//
//  Created by Norikazu on 2015/06/27.
//  Copyright (c) 2015年 Stamp inc. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"
#import "FullScreenContentViewController.h"
#import "CollectionViewController.h"
#import "ComposeViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) UIButton *reloadForegroundButton;
@property (nonatomic) UIButton *reloadBackgroundButton;
@property (nonatomic) UIButton *insertForegroundButton;
@property (nonatomic) UIButton *showCellsButton;

@property (nonatomic) UIButton *backgroundScrollLeft;
@property (nonatomic) UIButton *backgroundScrollRight;

@property (nonatomic) NSArray *backgroundData;
@property (nonatomic) NSArray *foregroundData;
@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backgroundData = @[@"0",@"1",@"2",@"3",@"4"];
    _foregroundData = @[@"0",@"1",@"2",@"3",@"4",@"5"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    
    CGFloat height = 180;
    
    _showCellsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_showCellsButton setTitle:@"show visibleCells" forState:UIControlStateNormal];
    [_showCellsButton addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [_showCellsButton sizeToFit];
    _showCellsButton.tintColor = [UIColor whiteColor];
    _showCellsButton.center = CGPointMake(self.view.center.x, height - 90);
    [self.view addSubview:_showCellsButton];
    

    _reloadForegroundButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_reloadForegroundButton setTitle:@"reload foreground" forState:UIControlStateNormal];
    [_reloadForegroundButton addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [_reloadForegroundButton sizeToFit];
    _reloadForegroundButton.tintColor = [UIColor whiteColor];
    _reloadForegroundButton.center = CGPointMake(self.view.center.x, height - 60);
    [self.view addSubview:_reloadForegroundButton];
    
    _reloadBackgroundButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_reloadBackgroundButton setTitle:@"reload background" forState:UIControlStateNormal];
    [_reloadBackgroundButton addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [_reloadBackgroundButton sizeToFit];
    _reloadBackgroundButton.tintColor = [UIColor whiteColor];
    _reloadBackgroundButton.center = CGPointMake(self.view.center.x, height - 30);
    [self.view addSubview:_reloadBackgroundButton];
    
    _insertForegroundButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_insertForegroundButton setTitle:@"insert foreground" forState:UIControlStateNormal];
    [_insertForegroundButton addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [_insertForegroundButton sizeToFit];
    _insertForegroundButton.tintColor = [UIColor whiteColor];
    _insertForegroundButton.center = CGPointMake(self.view.center.x, height);
    [self.view addSubview:_insertForegroundButton];
    
    _backgroundScrollLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    [_backgroundScrollLeft setTitle:@"Background scroll to Left" forState:UIControlStateNormal];
    [_backgroundScrollLeft addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundScrollLeft sizeToFit];
    _backgroundScrollLeft.tintColor = [UIColor whiteColor];
    _backgroundScrollLeft.center = CGPointMake(self.view.center.x, height + 30);
    [self.view addSubview:_backgroundScrollLeft];
    
    _backgroundScrollRight = [UIButton buttonWithType:UIButtonTypeSystem];
    [_backgroundScrollRight setTitle:@"Background scroll to Right" forState:UIControlStateNormal];
    [_backgroundScrollRight addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundScrollRight sizeToFit];
    _backgroundScrollRight.tintColor = [UIColor whiteColor];
    _backgroundScrollRight.center = CGPointMake(self.view.center.x, height + 60);
    [self.view addSubview:_backgroundScrollRight];
    

    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    [self.toolbar setItems:@[flex, add]];
    
}

- (void)tapped:(UIButton *)button
{
    if (button == _showCellsButton) {
        PKCollectionViewController *foregroundViewController = [self foregroundViewControllerAtIndex:self.selectedCategory];
        NSArray *cells = [foregroundViewController visibleCells];
        
        NSLog(@"cells %@", cells);
    }
    
    if (button == _reloadBackgroundButton) {
        _backgroundData = @[@"0",@"1",@"2"];
        [self reloadBackgroundData];
    }
    
    if (button == _reloadForegroundButton) {
        _foregroundData = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        [self reloadForegroundDataOnCategory:self.selectedCategory];
    }
    
    if (button == _insertForegroundButton) {
        
        NSMutableArray *dataSource = [NSMutableArray arrayWithArray:_foregroundData];
        [dataSource addObject:@"insert"];
        [dataSource addObject:@"insert"];
        [dataSource addObject:@"insert"];
        [dataSource addObject:@"insert"];
        [dataSource addObject:@"insert"];
        [dataSource addObject:@"insert"];
        [dataSource addObject:@"insert"];
        [dataSource addObject:@"insert"];
        _foregroundData = dataSource;
        
        NSMutableArray *insertIndexPaths = @[].mutableCopy;
        [insertIndexPaths addObject:[NSIndexPath indexPathForItem:0 inSection:1]];
        [insertIndexPaths addObject:[NSIndexPath indexPathForItem:1 inSection:1]];
        [insertIndexPaths addObject:[NSIndexPath indexPathForItem:2 inSection:1]];
        [insertIndexPaths addObject:[NSIndexPath indexPathForItem:3 inSection:1]];
        [insertIndexPaths addObject:[NSIndexPath indexPathForItem:4 inSection:1]];
        [insertIndexPaths addObject:[NSIndexPath indexPathForItem:5 inSection:1]];
        [insertIndexPaths addObject:[NSIndexPath indexPathForItem:6 inSection:1]];
        [insertIndexPaths addObject:[NSIndexPath indexPathForItem:7 inSection:1]];

        
        
        [self foregroundCollectionViewOnCategory:self.selectedCategory performBatchUpdates:^(PKCollectionViewController *controller){
            [controller.collectionView insertItemsAtIndexPaths:insertIndexPaths];
        } completion:^(BOOL finished) {
            [self.view setNeedsLayout];
        }];
        
    }
    
    if (button == _backgroundScrollRight) {
        NSInteger category = self.selectedCategory + 1;
        category = MIN(_backgroundData.count - 1, category);
        [self scrollToCategory:category animated:YES];
    }
    
    if (button == _backgroundScrollLeft) {
        NSInteger category = self.selectedCategory - 1;
        category = MAX(0, category);
        [self scrollToCategory:category animated:YES];
    }
    
}

- (void)add:(UIBarButtonItem *)buttonItem
{
    //ViewController *nextViewController = [ViewController new];
    //[[PKWindowManager sharedManager] showWindowWithRootViewController:nextViewController];
    
    ComposeViewController *viewController = [ComposeViewController new];
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (void)categoryWillSet:(NSUInteger)currentCategory nextCategory:(NSUInteger)nextCategory
{
    //NSLog(@"categoryWillSet %lu %lu", currentCategory, (unsigned long)nextCategory);
}

- (void)categoryDidSet:(NSUInteger)category
{
    //NSLog(@"categoryDidSet %lu", category);
}

- (void)didSelectViewController:(PKContentViewController *)viewController
{
    //NSLog(@"didSelectViewController %@", viewController);
}

- (void)didEndTransitionAnimation:(BOOL)expand
{
    //NSLog(@"didEndTransitionAnimation %d", expand);
}

- (NSInteger)backgroundCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _backgroundData.count;
}

- (NSInteger)numberOfSectionsInForegroundCollectionView:(UICollectionView *)collectionView onCategory:(NSInteger)category
{
    return 2;
}

- (NSInteger)foregroundCollectionVew:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section onCategory:(NSInteger)category
{
    if (section == 0) {
        return 1;
    }
    return _foregroundData.count;
}

- (UICollectionViewCell *)backgroundCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", (int)indexPath.item]];
    imageView.clipsToBounds = YES;
    cell.backgroundView = imageView;
    return cell;
}

- (PKContentViewController *)foregroundCollectionView:(PKCollectionView *)collectionView contentViewControllerForAtIndexPath:(NSIndexPath *)indexPath onCategory:(NSUInteger)category
{

    if (indexPath.section == 0) {
        return [CollectionViewController new];
    }
    
    if (indexPath.item % 3) {
        return [ContentViewController new];
    } else {
        return [FullScreenContentViewController new];
    }
}

- (void)scrollView:(UIScrollView *)scrollView slideToAction:(PKCollectionViewControllerScrollDirection)direction;
{
    if (direction == PKCollectionViewControllerScrollDirectionPrevious) {
        NSLog(@"PKCollectionViewControllerScrollDirectionPrevious");
    } else {
        NSLog(@"PKCollectionViewControllerScrollDirectionNext");
    }
}

- (void)pullDownToActionWithProgress:(CGFloat)progress
{
    
}



@end
