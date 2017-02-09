//
//  LianxianView.m
//  Ubbsz
//
//  Created by tianjing on 15-3-13.
//  Copyright (c) 2015年 BBSZ. All rights reserved.
//

#import "LianxianView.h"

@interface LianxianView()
{
    NSMutableArray *pointArray;
    NSMutableArray *lineArray;
    int stateIndex;
    CGPoint myBeginPoint;
}

@end

@implementation LianxianView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//对进行重写，以便在视图初始化的时候创建并设置自定义的Context
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        pointArray=[[NSMutableArray alloc]init];
        lineArray=[[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//对drawRect进行重写
- (void)drawRect:(CGRect)rect
{
    //NSLog(@"drawRect");
    //获取当前上下文，
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 5.0f);
    //线条拐角样式，设置为平滑
    CGContextSetLineJoin(context,kCGLineJoinRound);
    //线条开始样式，设置为平滑
    CGContextSetLineCap(context, kCGLineCapRound);
    //查看lineArray数组里是否有线条，有就将之前画的重绘，没有只画当前线条
    if ([lineArray count] > 0) {
       // NSLog(@"查看lineArray数组里是否有线条");
        for (int i=0; i < [lineArray count]; i++) {
            NSArray * array=[NSArray arrayWithArray:[lineArray objectAtIndex:i]];
            if ([array count] > 0) {
                CGContextBeginPath(context);
                CGPoint myStartPoint = CGPointFromString([array objectAtIndex:0]);
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                CGPoint myEndPoint = CGPointFromString([array objectAtIndex:([array count]-1)]);
                CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                //设置线条的颜色，要取uicolor的CGColor
                CGContextSetStrokeColorWithColor(context,[[UIColor blackColor] CGColor]);
                //设置线条宽度
                CGContextSetLineWidth(context, 5.0);
                //保存自己画的
                CGContextStrokePath(context);
            }
        }
    }
    //画当前的线
    if ([pointArray count] > 0) {
        //NSLog(@"画当前的线");
        CGContextBeginPath(context);
        CGPoint myStartPoint = CGPointFromString([pointArray objectAtIndex:0]);
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        CGPoint myEndPoint = CGPointFromString([pointArray objectAtIndex:([pointArray count] - 1)]);
        CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
        CGContextSetStrokeColorWithColor(context,[[UIColor blackColor] CGColor]);
        CGContextSetLineWidth(context, 5.0);
        CGContextStrokePath(context);
    }
}

//手指划动时画线的代码
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    myBeginPoint = [touch locationInView:self];
    NSString *sPoint = NSStringFromCGPoint(myBeginPoint);
    [pointArray addObject:sPoint];
    if(pointArray.count > 1 || [self beginPoint]) {
      [self setNeedsDisplay];
    } else {
      [pointArray removeAllObjects];
    }
}

//正确的起始点
- (BOOL)beginPoint
{
    NSString *bp = [NSString stringWithFormat:@"%@",[pointArray objectAtIndex:0]];
    CGPoint bPoint = CGPointFromString(bp);
    for (int i=0; i<[self.frameArray count]; i++) {
        NSString *frameS = [NSString stringWithFormat:@"%@",[[self.frameArray objectAtIndex:i] objectAtIndex:0]];
        CGRect bframe = CGRectFromString(frameS);
        if (CGRectContainsPoint(bframe, bPoint)) {
            stateIndex = i;
            return YES;
        }
    }
    return NO;
}

//正确的结束点，链接正确
- (BOOL)endPoint
{
    if(pointArray.count) {
        NSString *ep = [NSString stringWithFormat:@"%@",[pointArray objectAtIndex:[pointArray count]-1]];
        CGPoint ePoint = CGPointFromString(ep);
        NSString *frameS = [NSString stringWithFormat:@"%@",[[self.frameArray objectAtIndex:stateIndex] objectAtIndex:1]];
        CGRect eframe = CGRectFromString(frameS);
        if (CGRectContainsPoint(eframe, ePoint)) {
            return YES;
        }
        return NO;
   }
   return NO;
}

-(void)addLA
{
    NSArray *array = [NSArray arrayWithArray:pointArray];
    [lineArray addObject:array];
    [pointArray removeAllObjects];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   // NSLog(@"ended");
    if([self endPoint]) {
       [self.frameArray removeObjectAtIndex:stateIndex];
       [self addLA];
        if (self.delegate && [self.delegate respondsToSelector:@selector(lianxianRight)]) {
            [self.delegate performSelector:@selector(lianxianRight) withObject:nil];
        }
    } else {
        [pointArray removeAllObjects];
        [self setNeedsDisplay];
        if (self.delegate && [self.delegate respondsToSelector:@selector(lianxianError)]) {
            [self.delegate performSelector:@selector(lianxianError) withObject:nil];
        }
    }
}

- (void)clearView
{
    [pointArray removeAllObjects];
    [lineArray removeAllObjects];
    [self setNeedsDisplay];
}

@end
