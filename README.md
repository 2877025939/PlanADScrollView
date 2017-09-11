# GCD

这里主要介绍了iOS开发多线程的使用
GCD，NSThread，NSOperation

1.GCD 是iOS4推出的，C语言框架，能够自动利用更多cpu的核数，自动管理线程的生命周期
队列分为四种:
串行（Serial）:让任务一个完毕之后接着另一个执行
并发（Concurrent）:可以让多个任务并发（同时）执行（自动开启多个线程同时执行任务）并发功能只有在异步（dispatch_async）函数下才有效。
同步（Synchronous）:在当前线程中执行任务，不具备开启新线程的能力
异步（Asynchronous）:在新的线程中执行任务，具备开启新线程的能力


2.NSOperation是基于GCD的一个封装. 但是比GCD多了一些简单实用的功能, 这就使NSOperation变的更加的面向对象.
NSOperation是一个抽象基类，我们使用最多的是它的子类NSInvocationOperation和NSBlockOperation。

在iOS开发的过程中如有遇到问题，欢迎联系我进行探讨交流.
邮箱：peiliancoding@gmail.com 
QQ ：2877025939.
