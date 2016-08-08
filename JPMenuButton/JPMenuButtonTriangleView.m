//
//  JPMenuButtonTriangleView.m
//  JPMenuButton
//
//  Created by ovopark_iOS on 16/8/8.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import "JPMenuButtonTriangleView.h"

@implementation JPMenuButtonTriangleView
@synthesize tintColor = _tintColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // 拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 利用path进行绘制三角形
    CGContextBeginPath(context); // 标记
    
    CGContextMoveToPoint(context, 0, 0);//设置起点
    
    CGContextAddLineToPoint(context, self.frame.size.width, 0);
    
    CGContextAddLineToPoint(context, self.frame.size.width/2, self.frame.size.height);
    
    CGContextClosePath(context); // 路径结束标志，不写默认封闭
    
    // 设置填充色
    [self.tintColor setFill];
    
    // 设置边框颜色
    //    [[UIColor clearColor]setStroke];
    
    // 绘制路径path
    CGContextDrawPath(context, kCGPathFill);
}


- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
    }
    [self setNeedsDisplay];
}
- (UIColor *)tintColor
{
    if (_tintColor) {
        return _tintColor;
    } else {
        return [UIColor blueColor];
    }
}

@end
