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
    
    //子线程timter
    [NSThread detachNewThreadSelector:@selector(timer2) toTarget:self withObject:nil];
}

//子线程timer
- (void)timer2
{
    // timer自动添加到runloop， default里面
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer2 fire ---%@ ", [NSRunLoop mainRunLoop].currentMode);
    }];
    //主动开启runloop
    //不停的run
//    [[NSRunLoop currentRunLoop] run];
    // 运行3s， 退出，
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
}


//主线程timer1
- (void)timer1
{
    NSTimer* timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer1 fire ---%@ ", [NSRunLoop mainRunLoop].currentMode);
    }];
    //NSDefaultRunLoopMode
    //    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // uitracking mode , default 都可以工作
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}




@end
