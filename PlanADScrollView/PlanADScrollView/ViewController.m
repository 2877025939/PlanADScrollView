//
//  ViewController.m
//  PlanADScrollView
//
//  Created by anan on 2017/10/18.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "PlanADScrollView.h"
@interface ViewController ()<PlanADScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self PlanADScrollView];
}

-(void)PlanADScrollView{
    
    //完美支持 本地图片、网络图片
    
    NSArray *imageUrls = @[@"http://pic1.win4000.com/wallpaper/1/58194457a834e.jpg",
                           @"http://pic31.photophoto.cn/20140622/0005018377654922_b.jpg",
                           @"http://p1.gexing.com/shaitu/20130128/0005/51055060557b3.jpg",
                           @"http://pic31.photophoto.cn/20140419/0005018307715498_b.jpg",
                           @"http://img.wanyx.com/Uploads/ueditor/image/20170418/1492498061368610.jpg",
                           @"http://img.wanyx.com/Uploads/ueditor/image/20170405/1491381650725820.jpg"];
   
    //本地图片演示
    NSArray *imageUrl1s = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    
    PlanADScrollView *ad =[[PlanADScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)imageUrls:imageUrls placeholderimage:[UIImage imageNamed:@"placeholderimage"]];
    ad.delegate =self;
    ad.pageContolStyle = PlanPageContolStyleRectangle;
    [self.view addSubview:ad];
    
    
    PlanADScrollView *ad1 =[[PlanADScrollView alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 200)imageUrls:imageUrl1s placeholderimage:nil];
    ad1.delegate =self;
    ad1.pageContolStyle = PlanPageContolStyleImage;
    [ad1 currentImage:[UIImage imageNamed:@"check"] pageImage:[UIImage imageNamed:@"check1"]];
    [self.view addSubview:ad1];

}
-(void)PlanADScrollViewdidSelectAtIndex:(NSInteger)index{
    
    NSLog(@"点击了第%ld图片",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
