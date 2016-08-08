//
//  JPMenuButton.h
//  JPMenuButton
//
//  Created by ovopark_iOS on 16/8/8.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPMenuButton : UIView

/* default is nil */
@property (copy, nonatomic) NSString *title;

/* default is systemFontSize:15 */
@property (strong, nonatomic) UIFont *titleFont;

/* default is blueColor */
@property (strong, nonatomic) UIColor *tintColor;

/* default is NO */
@property (assign, nonatomic, getter=isSelected) BOOL selected;

- (void)addTarget:(id)target action:(SEL)action;

@end
