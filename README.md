

PlanADScrollView
----------------

  使用CollectionView实现的轮播图，支持网络和本地图片轮播，图片缓存使用SDWebImage
    
  #点击右上角的 star、watch 按钮，可以收藏本仓库，看到本仓库的更新！
  
    PlanADScrollView *ad =[[PlanADScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)imageUrls:imageUrls placeholderimage:[UIImage imageNamed:@"placeholderimage"]];
    ad.delegate =self;
    ad.pageContolStyle = PlanPageContolStyleRectangle;
    [self.view addSubview:ad];

  pageContolStyle 有三种方法：
   1.pageControl 默认圆点
   2.方条
   3.图片
  
  ![img](https://github.com/2877025939/PlanADScrollView/blob/master/PlanADCreollView.gif)  
  
  在iOS开发的过程中如有遇到问题，欢迎联系我进行探讨交流.

  邮箱：peiliancoding@gmail.com 


