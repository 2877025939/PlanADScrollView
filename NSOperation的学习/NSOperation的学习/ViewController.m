//
//  ViewController.m
//  NSOperation的学习
//
//  Created by anan on 2017/8/29.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSMutableString *str ;
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.str = [[NSMutableString alloc]init];
    /**
     NSOperation 是一个抽象基类，其主要是为了提供接口，以及封装了一些内部实现。通常情况下我们会使用其子类来完成我们想要的操作，而不是直接创建一个 NSOperation 的实例，毕竟它并没有提供可以执行我们代码的接口，所以说它「几乎什么都做不了」。
     
     iOS 中提供了一些 NSOperation 的子类，如 NSInvocationOperation、NSBlockOperation 等等，必要的话，我们也可以自己写一个 NSOperation 的子类，来完成自定义操作。
     
     如果（我们）没有做一些特殊的修改的话，这些子类的使用方法应该是一样的，都是使用 NSOperation 默认的方法（接口）和执行流程。
    
     NSOperation是基于GCD的一个封装. 但是比GCD多了一些简单实用的功能, 这就使NSOperation变的更加的面向对象.
     **/
    
    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
//    [self test6];
//    [self test7];
    
}

#pragma mark - 异步同步,线程之间的传递信息
-(void)test1{

//    //主线程实现任务（没有意义）
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
//    
//    [operation start];
    
    
    //(1)异步实现
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runa) object:nil];
//    
//    [queue addOperation:operation];
    
//    //(2)
//    self.lable.text =@"20";
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    
//    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
//        sleep(2.0);
//        
//        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
//
//        // 2.回到主线程,可以刷新UI
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            
//            self.lable.text =@"100";
//            NSLog(@"当前的线程 %@", [NSThread currentThread]);
//        }];
//    }];
//    
//    [queue addOperation:operation1];
//
    
    //（3）
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    self.lable.text =@"20";
    
    [queue addOperationWithBlock:^{
        // 1.执行一些比较耗时的操作
        NSLog(@"当前的线程 %@", [NSThread currentThread]);
        
        // 2.回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.lable.text =@"100";
            NSLog(@"当前的线程 %@", [NSThread currentThread]);
        }];
        
    }];
    
}
-(void)runa{
    self.lable.text =@"20";
    NSLog(@"当前的线程 %@", [NSThread currentThread]);
    
    // 2.回到主线程
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.lable.text =@"100";
        NSLog(@"当前的线程 %@", [NSThread currentThread]);
    }];
    
}
#pragma mark - 线程之间可以设置依赖的关系，但是要注意不能相互依赖，否则会导致死锁
-(void)test2{
        //2. 线程之间可以设置依赖的关系，但是要注意不能相互依赖，否则会导致死锁
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
        NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
            sleep(2.0);
            NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    
        }];
        NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){
            sleep(2.0);
            NSLog(@"执行第2次操作，线程：%@", [NSThread currentThread]);
        }];
    
        NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^(){
            sleep(2.0);
            NSLog(@"执行第3次操作，线程：%@", [NSThread currentThread]);
        }];
    
        // operation1依赖于operation2
        [operation1 addDependency:operation2];
    
        [queue addOperation:operation1];
    
        [queue addOperation:operation2];
        
        [queue addOperation:operation3];
}

#pragma mark - NSBlockOperation不放到NSOperationQueue
-(void)test3{
    //3. 只要NSBlockOperation封装的操作数 > 1，就会异步执行操作。但是会在 当前线程和其他线程 中执行，也就是说还是会占用当前线程。
    //    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
    //
    //        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    //    }];
    //
    //    [operation addExecutionBlock:^() {
    //        NSLog(@"又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    //    }];
    //
    //    [operation addExecutionBlock:^() {
    //        NSLog(@"又执行了2个新的操作，线程：%@", [NSThread currentThread]);
    //    }];
    //
    //    [operation addExecutionBlock:^() {
    //        NSLog(@"又执行了3个新的操作，线程：%@", [NSThread currentThread]);
    //    }];
    //    
    //    // 开始执行任务  
    //    [operation start];
    

}

#pragma mark - 异步并行
-(void)test4{
        //4. 异步并行
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
             NSLog(@"group-1 %@", [NSThread currentThread]);
        }];
    
        [operation addExecutionBlock:^() {
            NSLog(@"group-2 %@", [NSThread currentThread]);
        }];
    
        [operation addExecutionBlock:^() {
            NSLog(@"group-3 %@", [NSThread currentThread]);
    
        }];
    
        [operation addExecutionBlock:^() {
            NSLog(@"group-4 %@", [NSThread currentThread]);
        }];
    
        [queue addOperation:operation];
    
        [operation setCompletionBlock:^() {
    
            NSLog(@"执行完毕");
        }];
        
        //队列取消
        //[operation cancel];

}

#pragma mark - 异步串行
-(void)test5{
    
    
    //5.异步串行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        
        NSLog(@"group-1 %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){
        
        NSLog(@"group-2 %@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^(){
        
        NSLog(@"group-3 %@", [NSThread currentThread]);
    }];
    
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
}

#pragma mark - 线程之间的传递信息
-(void)test6{
    
    

}

#pragma mark - 异步先并行，然后串行
-(void)test7{

    //7.异步先并行，然后串行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        
        NSLog(@"group-1 %@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){
        
        for (NSInteger i = 0 ; i<3; i++) {
            sleep(2.0);
            NSLog(@"2- %@", [NSThread currentThread]);
        }
        
    }];
    
    [operation addExecutionBlock:^() {
        NSLog(@"group-2 %@", [NSThread currentThread]);
        
        
    }];
    
    [operation addExecutionBlock:^() {
        NSLog(@"group-3 %@", [NSThread currentThread]);
        
    }];
    
    [operation addExecutionBlock:^() {
        NSLog(@"group-4 %@", [NSThread currentThread]);
        
    }];
    
    //添加依赖
    [operation2 addDependency:operation];
    
    [queue addOperation:operation];
    [queue addOperation:operation2];
    
    [operation setCompletionBlock:^() {
        
        NSLog(@"operation执行完毕");
    }];
    
    [operation2 setCompletionBlock:^() {
        
        NSLog(@"operation2执行完毕");
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
