//
//  PlanPageControl.m
//  PlanADScrollView
//
//  Created by anan on 2017/10/19.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "PlanPageControl.h"
@interface PlanPageControl()

@end

@implementation PlanPageControl


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//从写setCurrentPage方法，可以修改 点的间距 和 点的图片
-(void)setCurrentPage:(NSInteger)page{
    
    //NSLog(@"setCurrentPage");
    [super setCurrentPage:page];
    
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIView* point = [self.subviews objectAtIndex:i];
        
        [point setFrame:CGRectMake(point.frame.origin.x, point.frame.origin.y, self.pointSize.width, self.pointSize.height)];
        if ([point.subviews count] == 0) {
            UIImageView * view = [[UIImageView alloc]initWithFrame:point.bounds];
            [point addSubview:view];
        };
        UIImageView * view = point.subviews[0];
        
        if (i==self.currentPage) {
            if (self.currentImage) {
                view.image=self.currentImage;
                point.backgroundColor = [UIColor clearColor];
            }else {
                view.image = nil;
                point.backgroundColor = self.currentPageIndicatorTintColor;
            }
        }else if (self.pageImage) {
            view.image=self.pageImage;
            point.backgroundColor = [UIColor clearColor];
        }else {
            view.image = nil;
            point.backgroundColor = self.pageIndicatorTintColor;
        }
    }

    
}



@end
