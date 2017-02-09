//
//  LianxianView.h
//  Ubbsz
//
//  Created by tianjing on 15-3-13.
//  Copyright (c) 2015年 BBSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LianXianViewDelegate <NSObject>//连线正确错误的委托

- (void)lianxianRight;
- (void)lianxianError;

@end

@interface LianxianView : UIView

- (void)clearView;

@property (nonatomic,weak) id<LianXianViewDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *frameArray;

@end
