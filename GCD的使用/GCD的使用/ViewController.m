//
//  ViewController.m
//  GCD的使用
//
//  Created by anan on 2017/3/8.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    
    // GCD异步串行的使用
    [self GCD];
    
    // GCD异步并行的使用
    //[self GCD1];
    
}

#pragma mark - GCD异步串行的使用
-(void)GCD{
    
    // 1.创建队列组，串行加通知
    dispatch_group_t group = dispatch_group_create();
    
    // 2. 串行队列
    dispatch_queue_t concurrencyQueue = dispatch_queue_create("myqueue",DISPATCH_QUEUE_SERIAL);
    
    //3.开辟一个子线程，异步操作
    dispatch_group_async(group, concurrencyQueue, ^{
        
        NSLog(@"group-1 %@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, concurrencyQueue, ^{
        
        NSLog(@"group-2 %@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, concurrencyQueue, ^{
        
        NSLog(@"group-3 %@", [NSThread currentThread]);
    });
    
    
    //4.都完成后会自动通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //主线程刷新数据
        NSLog(@"完成 - %@", [NSThread currentThread]);
        
    });
    
    
   // 不通知进程是否结束的串行
    dispatch_async(concurrencyQueue, ^{
        
        NSLog(@"group-1 %@", [NSThread currentThread]);
        
    });
    dispatch_async(concurrencyQueue, ^{
        NSLog(@"group-2 %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrencyQueue, ^{
        NSLog(@"group-3 %@", [NSThread currentThread]);
        
    });
    
}


#pragma mark - GCD异步并行的使用
-(void)GCD1{
    
    // GCD异步并行的使用
    
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   
    //dispatch_get_global_queue存在优先级，没错，一共有4个优先级
    
    //#define DISPATCH_QUEUE_PRIORITY_HIGH 2  高
    //#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0  中等
    //#define DISPATCH_QUEUE_PRIORITY_LOW (-2)    低
    //#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN 最后
    
    //3.多次使用队列组的方法执行任务, 只有异步方法
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"group-1 %@", [NSThread currentThread]);
        }
    });
    
    //3.2.主队列执行8次循环
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 8; i++) {
            NSLog(@"group-2 %@", [NSThread currentThread]);
        }
    });
    
    //3.3.执行5次循环
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"group-3 %@", [NSThread currentThread]);
        }
    });
    
    //4.都完成后会自动通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        //主线程刷新数据
        NSLog(@"完成 - %@", [NSThread currentThread]);
        
    });
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
