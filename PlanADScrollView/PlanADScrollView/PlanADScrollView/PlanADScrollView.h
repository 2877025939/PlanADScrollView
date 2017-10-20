//
//  PlanADScrollView.h
//  PlanADScrollView
//
//  Created by anan on 2017/10/18.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import <UIKit/UIKit.h>
//可以定义PageContol圆点的类型
typedef enum {
    PlanPageContolStyleNone,     //圆点
    PlanPageContolStyleRectangle,//条状
    PlanPageContolStyleImage,    //图片
} PlanPageContolStyle;


@protocol PlanADScrollViewDelegate <NSObject>

/**
 代理回调方法，点击图片回调
 */
- (void)PlanADScrollViewdidSelectAtIndex:(NSInteger )index;

@end

@interface PlanADScrollView : UIView
@property(nonatomic,weak) id<PlanADScrollViewDelegate> delegate;

/** 
 pageContol点的样式
 */
@property (nonatomic)PlanPageContolStyle pageContolStyle;


/**
 初始化方法
 imageUrls         需要加载的图片数组，可以是本地的，也可以是网络的图片  
 placeholderimage  占位图片
 */
- (instancetype)initWithFrame:(CGRect)frame
                    imageUrls:(NSArray *)imageUrls
             placeholderimage:(UIImage*)placeholderimage;


/**
 当选中的PlanPageContolStyle 是PlanPageContolStyleImage, 图片类型的时候调用，
 如果不调用使用默认图片
 currentImage      选中图片
 pageImage         默认图片
 */
-(void)currentImage:(UIImage *)currentImage
          pageImage:(UIImage*)pageImage;


@end
