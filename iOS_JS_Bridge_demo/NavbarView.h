//
//  ViewController.h
//  iOS_JS_Bridge_demo
//
//  Created by 陈威利 on 2018/7/24.
//  Copyright © 2018年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol navBarViewDelegate <NSObject>
@optional

- (void)clickQuitBtn;

- (void)clickBackBtn;

- (void)clickHistoryBtn;

- (void)jsInsert;
@end

@interface NavbarView : UIView
@property (nonatomic, weak) id<navBarViewDelegate> barViewDelegate;
@property (nonatomic, strong)UIButton *jsInsertBtn;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UIButton *quitBtn;
@property (nonatomic, strong)UIButton *historyBtn;
@end


