//
//  ViewController.m
//  NSThread
//
//  Created by anan on 2017/8/28.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1.
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTask) object:nil];
//    thread.name = @"线程类";
//    [thread start];
//    
    
    //取消 [thread cancel];
    
    //停止 [NSThread exit];
    
    /**
     qualityOfService的枚举值如下：
     　　　NSQualityOfServiceUserInteractive：最高优先级，用于用户交互事件
     　　　NSQualityOfServiceUserInitiated：次高优先级，用于用户需要马上执行的事件
     　　　NSQualityOfServiceDefault：默认优先级，主线程和没有设置优先级的线程都默认为这个优先级
     　　　NSQualityOfServiceUtility：普通优先级，用于普通任务
     　　　NSQualityOfServiceBackground：最低优先级，用于不重要的任务
     
     　　比如给线程设置次高优先级：
     
     [newThread setQualityOfService:NSQualityOfServiceUserInitiated];
     
     
     */
    
    
//    //2.快速创建，并自动开启：
//    [NSThread detachNewThreadSelector:@selector(threadTask) toTarget:self withObject:nil];
//    
//    //3.隐式创建，并自动开启：
//    [self performSelectorInBackground:@selector(threadTask) withObject:nil];
    
    
    //主线程
//    [self performSelector:@selector(threadTask)];
//    [self performSelector:@selector(threadTask) withObject:nil];
//    [self performSelector:@selector(threadTask) withObject:nil afterDelay:2.0];
    
   
//    //在主线程更新数据
//    [self performSelectorOnMainThread:@selector(threadTask) withObject:@"" waitUntilDone:YES];
//    
//    [self performSelector:@selector(threadTask) onThread:[NSThread mainThread] withObject:@"" waitUntilDone:YES];

   
}

-(void)threadTask{
    
    
    if ([NSThread isMainThread]) {
        
        NSLog(@"当前线程 是 主线程，是%@", [NSThread currentThread]);
        
    } else {
        
        NSLog(@"当前线程 非 主线程，是%@", [NSThread currentThread]);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
