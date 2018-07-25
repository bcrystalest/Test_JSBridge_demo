
//
//  configurationVC.m
//  iOS_JS_Bridge_demo
//
//  Created by 陈威利 on 2018/7/25.
//  Copyright © 2018年 陈威利. All rights reserved.
//

#import "configurationVC.h"

@interface configurationVC ()<UITextViewDelegate>
@property (nonatomic, strong)UITextView *urlField;
@property (nonatomic, strong)UILabel *noticeUrl;
@property (nonatomic, strong)UITextView *agentField;
@property (nonatomic, strong)UIButton *noticeAgent;
@property (nonatomic, strong)UIButton *startTestBtn;
@property (nonatomic, strong)NSString *webViewUrl;
@end

@implementation configurationVC
- (UIButton *)noticeAgent{
    if (_noticeAgent == nil) {
        _noticeAgent = [[UIButton alloc]initWithFrame:CGRectMake(30, 190, 120, 50)];
        _noticeAgent.titleLabel.font = [UIFont systemFontOfSize:14];
        [_noticeAgent setTitle:@"点击输入Agent" forState:UIControlStateNormal];
        [_noticeAgent setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_noticeAgent addTarget:self action:@selector(showNoticeView) forControlEvents:UIControlEventTouchDown];
    }
    return _noticeAgent;
}

- (UIButton *)startTestBtn{
    if (_startTestBtn == nil) {
        _startTestBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 260, ScreenWidth-60, 50)];
        _startTestBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_startTestBtn setTitle:@"开始测试" forState:UIControlStateNormal];
        [_startTestBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_startTestBtn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchDown];
    }
    return _startTestBtn;
}

- (UITextView *)agentField{
    if (_agentField == nil) {
        _agentField = [[UITextView alloc]initWithFrame:CGRectMake(30, 80, ScreenWidth-60, 100)];
        _agentField.font = [UIFont systemFontOfSize:13];
        _agentField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _agentField.layer.borderWidth = 0.5f;
        _agentField.delegate = self;
    }
    return _agentField;
}
- (UILabel *)noticeUrl{
    if (_noticeUrl == nil) {
        _noticeUrl = [[UILabel alloc]initWithFrame:CGRectMake(30, 70, ScreenWidth-60, 20)];
        _noticeUrl.font = [UIFont systemFontOfSize:13];
        _noticeUrl.text = @"请输入完整的URL,如https://www.baidu.com";
        _noticeUrl.textColor = [UIColor lightGrayColor];
    }
    return _noticeUrl;
}
- (UITextView *)urlField{
    if (_urlField == nil) {
        _urlField = [[UITextView alloc]initWithFrame:CGRectMake(30, 100, ScreenWidth-60, 100)];
        _urlField.font = [UIFont systemFontOfSize:13];
        _urlField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _urlField.layer.borderWidth = 0.5f;
        _urlField.delegate = self;
    }
    return _urlField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self removeBasicViews];
    [self.view addSubview:self.noticeAgent];
    [self.view addSubview:self.noticeUrl];
    [self.view addSubview:self.urlField];
    [self.view addSubview:self.startTestBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showNoticeView{
    NSString *oldAgent = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAgent"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"当前Agent:%@(点击确定后需要重启APP)",oldAgent] message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *txtName = [alert textFieldAtIndex:0];
    txtName.placeholder = @"请输入Agent";
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%@",NSHomeDirectory());
    if (buttonIndex == 1) {
        NSString *oldAgent = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAgent"];
        UITextField *tfd = [alertView textFieldAtIndex:0];

        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@/%@",oldAgent,tfd.text] forKey:@"UserAgent"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    self.webViewUrl = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range

 replacementText:(NSString *)text

{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return FALSE;
    }
    return TRUE;
}

- (void)pushAction{
    if (self.webViewUrl.length != 0) {
        webViewController *vc = [webViewController new];
        vc.webViewUrl = self.webViewUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



@end
