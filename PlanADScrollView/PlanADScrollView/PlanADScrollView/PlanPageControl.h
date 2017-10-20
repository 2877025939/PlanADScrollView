//
//  PlanPageControl.h
//  PlanADScrollView
//
//  Created by anan on 2017/10/19.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanPageControl : UIPageControl

@property (nonatomic,strong)UIImage *currentImage; //选中图片
@property (nonatomic,strong)UIImage *pageImage;    //默认图片
@property (nonatomic,assign)CGSize pointSize;       //图标大小

@end
