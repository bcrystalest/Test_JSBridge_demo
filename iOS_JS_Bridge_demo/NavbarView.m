//
//  ViewController.m
//  iOS_JS_Bridge_demo
//
//  Created by 陈威利 on 2018/7/24.
//  Copyright © 2018年 陈威利. All rights reserved.
//

#import "NavbarView.h"

@interface NavbarView ()

@end

@implementation NavbarView
- (UIButton *)jsInsertBtn{
    if (_jsInsertBtn == nil) {
        _jsInsertBtn = [UIButton new];
        _jsInsertBtn.frame = CGRectMake(140, 5, 40, 30);
        _jsInsertBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_jsInsertBtn setTitle:@"js注入" forState:UIControlStateNormal];
        [_jsInsertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_jsInsertBtn addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchDown];
    }
    return _jsInsertBtn;
}

- (UIButton *)quitBtn{
    if (_quitBtn == nil) {
        _quitBtn = [UIButton new];
        _quitBtn.frame = CGRectMake(5, 5, 30, 30);
        _quitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_quitBtn setTitle:@"退出" forState:UIControlStateNormal];
        [_quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_quitBtn addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchDown];
    }
    return _quitBtn;
}

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton new];
        _backBtn.frame = CGRectMake(40, 5, 30, 30);
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    }
    return _backBtn;
}

- (UIButton *)historyBtn{
    if (_historyBtn == nil) {
        _historyBtn = [UIButton new];
        _historyBtn.frame = CGRectMake(75, 5, 60, 30);
        _historyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_historyBtn setTitle:@"交互历史" forState:UIControlStateNormal];
        [_historyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_historyBtn addTarget:self action:@selector(historyAction) forControlEvents:UIControlEventTouchDown];
    }
    return _historyBtn;
}

- (instancetype)init{
    if (self == [super init]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    if (KIsiPhoneX) {
        self.frame = CGRectMake(0, 64, ScreenWidth, 40);
    }else{
        self.frame = CGRectMake(0, 20, ScreenWidth, 40);
    }
    self.backgroundColor = [UIColor colorWithRed:0.745 green:0.745 blue:0.745 alpha:1.00];
    [self addSubview:self.quitBtn];
    [self addSubview:self.backBtn];
    [self addSubview:self.historyBtn];
    [self addSubview:self.jsInsertBtn];
}

- (void)quitAction{
    if ([self.barViewDelegate respondsToSelector:@selector(clickQuitBtn)]) {
        [self.barViewDelegate clickQuitBtn];
    }
}

- (void)backAction{
    if ([self.barViewDelegate respondsToSelector:@selector(clickBackBtn)]) {
        [self.barViewDelegate clickBackBtn];
    }
}

- (void)historyAction{
    if ([self.barViewDelegate respondsToSelector:@selector(clickHistoryBtn)]) {
        [self.barViewDelegate clickHistoryBtn];
    }
}

- (void)insertAction{
    if ([self.barViewDelegate respondsToSelector:@selector(jsInsert)]) {
        [self.barViewDelegate jsInsert];
    }
    
}

@end
