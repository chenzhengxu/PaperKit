//
//  PKCollectionViewController.h
//  PaperKit
//
//  Created by Norikazu on 2015/06/13.
//  Copyright (c) 2015年 Stamp inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>
#import <POP/POPLayerExtras.h>
#import "PKScrollView.h"
#import "PKCollectionView.h"
#import "PKContentCollectionView.h"
#import "PKCollectionViewCell.h"
#import "PKCollectionViewFlowLayout.h"
#import "PKPanGestureRecognizer.h"


@interface PKCollectionViewController : UIViewController

@property (nonatomic) PKContentCollectionView *collectionView;
@property (nonatomic) PKCollectionViewFlowLayout *layout;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) CGFloat transtionProgress;
@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) PKPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGFloat zoomScale;
@property (nonatomic) BOOL pagingEnabled;
@property (nonatomic) NSIndexPath *selectedIndexPath;


- (NSArray *)visibleCells;
- (NSArray *)indexPathsForVisibleItems;
- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
