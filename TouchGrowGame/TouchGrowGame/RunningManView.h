//
//  RunningManView.h
//  TouchGrowGame
//
//  Created by Songchao Zhang on 15/8/6.
//  Copyright (c) 2015年 UcfPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunningManView : UIView


/**
 *  Running Man 跑，跑步的距离经过计算之后的，如果是长度不够的，就传TouchView的长度，如果是够了的，就传RandomView的X值
 */
- (void)run:(float)distance after:(dispatch_block_t)result;


/**
 *  坠落动画执行完后回调
 */
- (void)dropAfter:(void(^)(void))endGrowHandler;

@end
