//
//  RandomView.m
//  TouchGrowGame
//
//  Created by Songchao Zhang on 15/8/6.
//  Copyright (c) 2015年 UcfPay. All rights reserved.
//

#import "RandomView.h"

@implementation RandomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        frame.size.width = arc4random()%(int)(screenWidth-frame.origin.x-50)+30;
        self.frame = frame;
    }
    return self;
}

@end
