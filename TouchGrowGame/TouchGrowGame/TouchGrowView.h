//
//  TouchGrowView.h
//  TouchGrowGame
//
//  Created by Songchao Zhang on 15/8/6.
//  Copyright (c) 2015年 UcfPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchGrowView : UIView


/**
 *  Init With Rate
 */

- (instancetype)initWithFrame:(CGRect)frame rate:(float)rate;


/**
 *  自增长
 */
- (void)growHeight;


/**
 *  停止增长
 */
- (void)endGrowAfter:(void(^)(float length))endGrowHandler;

/**
 *  长度没达到时掉落
 */
- (void)dropAfter:(void (^)(float))endGrowHandler;

@end
