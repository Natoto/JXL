//
//  BubbleLayout.m
//  pengmi
//
//  Created by 星盛 on 15/2/9.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "BubbleLayout.h"

@implementation BubbleLayout
@synthesize cellCount,center,radius;

- (void)prepareLayout{
    [super prepareLayout];
    CGSize size = self.collectionView.frame.size;
    cellCount=[self.collectionView numberOfItemsInSection:0];
    center=CGPointMake(size.width/2, size.height/2);
    radius = MIN(size.width, size.height) / 2.5;
    
}
-(CGSize)collectionViewContentSize{
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0)
    {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.bounds.size;
    contentSize.height = ITEM_HEIGHT + (ITEM_HEIGHT + ITEM_JIANGE) * (cellCount)/2; //[self.columnHeights[0] floatValue];
    return contentSize;
//    return [self collectionView].frame.size;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    CGFloat MAINWIDTH = [UIScreen mainScreen].bounds.size.width;
    if (path.row == 0) {
        
        attributes.size = CGSizeMake(MAINWIDTH - ITEM_JIANGE , ITEM_HEIGHT);
        attributes.center =CGPointMake([UIScreen mainScreen].bounds.size.width/2, ITEM_HEIGHT/2 + ITEM_JIANGE/2);
    }
    else
    {
        attributes.size = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
        switch (path.row%2) {
            case 0:
                attributes.center =CGPointMake((MAINWIDTH * 3)/4, (ITEM_HEIGHT + ITEM_JIANGE ) * (0.5 + (1 + path.row)/2));
                break;
            case 1:
                attributes.center =CGPointMake(MAINWIDTH/4, (ITEM_HEIGHT + ITEM_JIANGE) * (0.5 + (1+ path.row)/2));
            default:
                break;
        }
    }
    // CGPointMake(center.x + radius * cosf(2 * path.item * M_PI /cellCount),\
                                    \
                                    center.y + radius * sinf(2 * path.item * M_PI /cellCount));
    return attributes;
}
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(center.x, center.y);
    return attributes;
}
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(center.x, center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}
@end
