//
//  PlanADCollectionViewCell.m
//  PlanADScrollView
//
//  Created by anan on 2017/10/18.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "PlanADCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface PlanADCollectionViewCell ()
@property (nonatomic,strong) UIImageView *PlanADimageView;
@end

@implementation PlanADCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.PlanADimageView = [[UIImageView alloc] init];
        self.PlanADimageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.PlanADimageView];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.PlanADimageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}
-(void)imageStr:(NSString*)imageStr placeholderimage:(UIImage *)placeholderimage;{
    
    if ([imageStr hasPrefix:@"http"]) {
         [self.PlanADimageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:placeholderimage];
    }else{
        self.PlanADimageView.image = [UIImage imageNamed:imageStr];
    }
   
   
    
}

@end
