//
//  ViewController.m
//  LianxianDemo
//
//  Created by tianjing on 15/3/31.
//  Copyright © 2015年 tianjing. All rights reserved.
//

#import "ViewController.h"
#import "LianxianView.h"

@interface ViewController ()<LianXianViewDelegate>
{
    NSMutableArray *aFrames;
    NSMutableArray *bFrames;
    NSMutableArray *randArray;
    int rightLx;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    float KDeviceHeight = [UIScreen mainScreen].bounds.size.height;
    float kDeviceWidth = [UIScreen mainScreen].bounds.size.width;
    aFrames = [[NSMutableArray alloc]init];
    bFrames  = [[NSMutableArray alloc]init];
    randArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 5; i++) {
        [randArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    for (int i = 0; i < [randArray count]; i++)
    {
        int m = (arc4random() % ([randArray count] - i)) + i;
        [randArray exchangeObjectAtIndex:i withObjectAtIndex: m];
    }

    for (int i =0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30, 30+(KDeviceHeight-60)/5*i, (kDeviceWidth-60)/4, (KDeviceHeight-60)/7);
        btn.backgroundColor = [UIColor greenColor];
        [btn setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [aFrames addObject:NSStringFromCGRect(btn.frame)];
    }
    
    for (int i =0; i<5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kDeviceWidth-30-(kDeviceWidth-60)/4, 30+(KDeviceHeight-60)/5*i, (kDeviceWidth-60)/4, (KDeviceHeight-60)/7);
        btn.backgroundColor = [UIColor greenColor];
        [btn setTitle:[NSString stringWithFormat:@"%@",[randArray objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [bFrames addObject:NSStringFromCGRect(btn.frame)];
    }
    
    NSMutableArray *frameArray = [[NSMutableArray alloc]init];
    for (int i =0; i<5; i++) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:[aFrames objectAtIndex:[[randArray objectAtIndex:i]integerValue]]];
        [array addObject:[bFrames objectAtIndex:i]];
        [frameArray addObject:array];
    }
    
    LianxianView *view = [[LianxianView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    view.delegate = self;
    view.frameArray = frameArray;
    [self.view addSubview:view];
}

-(void)lianxianError
{
    NSLog(@"error");
}

-(void)lianxianRight
{
    NSLog(@"right");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
