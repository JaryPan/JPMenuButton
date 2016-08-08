//
//  JPMenuButton.m
//  JPMenuButton
//
//  Created by ovopark_iOS on 16/8/8.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#define JPMenuButtonSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#import "JPMenuButton.h"
#import "JPMenuButtonTriangleView.h"

@interface JPMenuButton ()
{
    UILabel *titleLabel;
    JPMenuButtonTriangleView *triangleView;
}

@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;

@end

@implementation JPMenuButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.titleFont = [UIFont systemFontOfSize:15];
        self.tintColor = [UIColor blueColor];
        
        // 标题框
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = self.tintColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        // 三角形标志
        triangleView = [[JPMenuButtonTriangleView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 10.0/2, self.frame.size.height/2 - 10.0*9.0/16.0/2, 10.0, 10.0*9.0/16.0)];
        [self addSubview:triangleView];
        
        // 添加手势
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)]];
    }
    return self;
}

#pragma mark - addTarget:action:
- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

#pragma mark - tapGestureAction
- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    if (self.target && self.action) {
        JPMenuButtonSuppressPerformSelectorLeakWarning([self.target performSelector:self.action withObject:self]);
    }
}


#pragma mark - setTitle
- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
    }
    titleLabel.text = title;
    
    if (title.length > 0) {
        CGFloat length = [self labelSizeForText:title withFont:self.titleFont andMaxWidth:self.frame.size.width - 15].width;
        titleLabel.frame = CGRectMake(self.frame.size.width/2 - (length + 15)/2, 0, length, self.frame.size.height);
        triangleView.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, self.frame.size.height/2 - 10.0*9.0/16.0/2, 10, 10.0*9.0/16.0);
    } else {
        titleLabel.frame = CGRectZero;
        triangleView.frame = CGRectMake(self.frame.size.width/2 - 10.0/2, self.frame.size.height/2 - 10.0*9.0/16.0/2, 10.0, 10.0*9.0/16.0);
    }
}

#pragma mark - setTitleFont
- (void)setTitleFont:(UIFont *)titleFont
{
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
    }
    
    titleLabel.font = titleFont;
    
    if (self.title.length > 0) {
        CGFloat length = [self labelSizeForText:self.title withFont:titleFont andMaxWidth:self.frame.size.width - 15].width;
        titleLabel.frame = CGRectMake(self.frame.size.width/2 - (length + 15)/2, 0, length, self.frame.size.height);
        triangleView.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, self.frame.size.height/2 - 10.0*9.0/16.0/2, 10, 10.0*9.0/16.0);
    } else {
        titleLabel.frame = CGRectZero;
        triangleView.frame = CGRectMake(self.frame.size.width/2 - 10.0/2, self.frame.size.height/2 - 10.0*9.0/16.0/2, 10.0, 10.0*9.0/16.0);
    }
}

#pragma mark - setTintColor
- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
    }
    
    titleLabel.textColor = tintColor;
    triangleView.tintColor = tintColor;
}

#pragma mark - setSelected
- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        [UIView animateWithDuration:0.15 animations:^{
            triangleView.transform = CGAffineTransformMakeRotation(3.1415926);
        }];
    } else {
        [UIView animateWithDuration:0.15 animations:^{
            triangleView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}


#pragma mark - 计算文字所占的尺寸
- (CGSize)labelSizeForText:(NSString *)text withFont:(UIFont *)font andMaxWidth:(CGFloat)maxWidth
{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}


#pragma mark - layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.title.length > 0) {
        CGFloat length = [self labelSizeForText:self.title withFont:self.titleFont andMaxWidth:self.frame.size.width - 15].width;
        titleLabel.frame = CGRectMake(self.frame.size.width/2 - (length + 15)/2, 0, length, self.frame.size.height);
        triangleView.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, self.frame.size.height/2 - 10.0*9.0/16.0/2, 10, 10.0*9.0/16.0);
    } else {
        titleLabel.frame = CGRectZero;
        triangleView.frame = CGRectMake(self.frame.size.width/2 - 10.0/2, self.frame.size.height/2 - 10.0*9.0/16.0/2, 10.0, 10.0*9.0/16.0);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
