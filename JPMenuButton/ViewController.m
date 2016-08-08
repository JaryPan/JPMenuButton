//
//  ViewController.m
//  JPMenuButton
//
//  Created by ovopark_iOS on 16/8/8.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import "ViewController.h"
#import "JPMenuButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JPMenuButton *menuButton = [[JPMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 20, 100, 40)];
    menuButton.title = @"向下";
    menuButton.tintColor = [UIColor orangeColor];
    [menuButton addTarget:self action:@selector(menuButtonAction:)];
    [self.view addSubview:menuButton];
}

- (void)menuButtonAction:(JPMenuButton *)sender
{
    sender.selected = !sender.isSelected;
    
    if (sender.isSelected) {
        sender.title = @"向上";
    } else {
        sender.title = @"向下";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
