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
     NSOperation是基于GCD的一个封装. 但是比GCD多了一些简单实用的功能, 这就使NSOperation变的更加的面向对象.
     NSOperation是一个抽象基类，我们使用最多的是它的子类NSInvocationOperation和NSBlockOperation。
     **/
    
 //   [self test1];
    [self test2];
    [self test3];
    [self test4];
    [self test5];
    [self test6];
    
}

#pragma mark - 同步异步,线程之间的传递信息
-(void)test1{
    
//    //NSOperationQueue 有两种队列，主队列，自定义
//    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];  //主队列
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init]; //自定义队列
//
//    
//    //主线程实现任务（同步，没意义）
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runner) object:nil];
//    [operation start];
    
    
//    //异步实现(2)
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runner) object:nil];
//   //当把operation放大queue的时候，系统会自动创建异步并发队列。
//    [queue addOperation:operation];
//    
    
//    //(3)NSBlockOperation
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

    
//    //（4）NSOperationQueue 添加一个block形式的Operation
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    self.lable.text =@"20";
//    
//    [queue addOperationWithBlock:^{
//        sleep(2.0);
//        // 1.执行一些比较耗时的操作
//        NSLog(@"group-1当前的线程 %@", [NSThread currentThread]);
//        
//        // 2.回到主线程
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            self.lable.text =@"100";
//            NSLog(@"当前的线程 %@", [NSThread currentThread]);
//        }];
//        
//    }];
    
    
    
}

-(void)runner{
    self.lable.text =@"20";
    NSLog(@"当前的线程 %@", [NSThread currentThread]);
    
    // 2.回到主线程更新UI
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
    
    
        // operation1依赖于operation2
        [operation1 addDependency:operation2];
    
        [queue addOperation:operation1];
    
        [queue addOperation:operation2];
    
}

#pragma mark - NSBlockOperation的使用并发
-(void)test3{
    //3. 只要NSBlockOperation封装的操作数 > 1，就会异步执行操作。但是会在 主线程和其他线程并发执行，也就是说还是会占用当前线程。
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
    
            NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
        }];
    
        [operation addExecutionBlock:^() {
            NSLog(@"又执行了1个新的操作，线程：%@", [NSThread currentThread]);
        }];
    
        [operation addExecutionBlock:^() {
            NSLog(@"又执行了2个新的操作，线程：%@", [NSThread currentThread]);
        }];
    
        [operation addExecutionBlock:^() {
            NSLog(@"又执行了3个新的操作，线程：%@", [NSThread currentThread]);
        }];
        
        // 开始执行任务  
        [operation start];
//    如果想要不占用主线程，则需要进行下面的操作，并去掉 [operation start]，因为NSOperationQueue会自动进行线程的管理
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];
    
}

#pragma mark - NSBlockOperation异步并发
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
    
    
        [queue addOperation:operation];
    
        [operation setCompletionBlock:^() {
    
            NSLog(@"执行完毕");
        }];
        
        //队列取消
        //[operation cancel];
}

#pragma mark - NSBlockOperation异步串行
-(void)test5{
    
    //5.异步串行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //这句代码是最重要，设置最大并发为1个就可以串行
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        sleep(2.0);
        NSLog(@"group-1 %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){
        sleep(2.0);
        NSLog(@"group-2 %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^(){
        sleep(2.0);
        NSLog(@"group-3 %@", [NSThread currentThread]);
    }];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
   
    //这种可以取消任务队列，但是在 执行的不可以取消
    // [queue cancelAllOperations];

}


#pragma mark - 异步先并行，然后串行
-(void)test6{

    //6.异步先并行，然后串行
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
