//
//  ViewController.m
//  NSRunLoopDemo
//
//  Created by renjinwei on 2021/1/2.
//  Copyright © 2021 renjinwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self timer1];
    
//    [self addRunLoopObserver];
    
    //create子线程timer
    [NSThread detachNewThreadSelector:@selector(timer2) toTarget:self withObject:nil];
}

/*
 kCFRunLoopEntry = (1UL << 0),
 kCFRunLoopBeforeTimers = (1UL << 1),
 kCFRunLoopBeforeSources = (1UL << 2),
 kCFRunLoopBeforeWaiting = (1UL << 5),
 kCFRunLoopAfterWaiting = (1UL << 6),
 kCFRunLoopExit = (1UL << 7),
 */
void observerCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"即将进入kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"即将处理timer kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"即将处理source kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"即将进入睡眠 kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"即将唤醒 kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"即将退出 kCFRunLoopExit");
            break;
            
        default:
            break;
    }
}

#pragma mark -- 监听状态
- (void)addRunLoopObserver
{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, observerCallBack, nil);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
}

#pragma mark -- timer
//子线程timer
- (void)timer2
{
    // timer自动添加到runloop， default里面
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer2 fire ---%@ ", [NSRunLoop mainRunLoop].currentMode);
    }];
    //主动开启runloop
    //不停的run
    [[NSRunLoop currentRunLoop] run];
    /*
     可以换一个1 为条件
     */
//    while (1) {
//        NSLog(@"runloop run -----");
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
//    }
    
    // 运行3s， 退出，
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
}


//主线程timer1
- (void)timer1
{
    NSTimer* timer = [NSTimer timerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"+++++++++++++++++timer1 fire ---%@ ", [NSRunLoop mainRunLoop].currentMode);
    }];
    //NSDefaultRunLoopMode
    //    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // uitracking mode , default 都可以工作
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}




@end
