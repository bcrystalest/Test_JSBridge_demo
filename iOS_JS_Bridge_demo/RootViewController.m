//
//  RootViewController.m
//  MenuCreateProduct
//
//  Created by 陈威利 on 2018/7/24.
//  Copyright © 2018年 陈威利. All rights reserved.
//

#import "RootViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface RootViewController ()<UIWebViewDelegate,navBarViewDelegate>

@property (nonatomic, strong)UIWebView *mainWebView;
@property WebViewJavascriptBridge *bridge;
@property (nonatomic, strong)NSMutableArray *historyArray;
@property (nonatomic, strong)NSString *jsString;
@end

@implementation RootViewController
- (NSMutableArray *)historyArray{
    if (_historyArray == nil) {
        _historyArray = [NSMutableArray new];
    }
    return _historyArray;
}

- (NavbarView *)navBarView{
    if (_navBarView == nil) {
        _navBarView = [NavbarView new];
        _navBarView.barViewDelegate = self;
    }
    return _navBarView;
}

- (UIWebView *)mainWebView{
    if (_mainWebView == nil) {
        _mainWebView = [UIWebView new];
        _mainWebView.delegate = self;
        if (KIsiPhoneX) {
            _mainWebView.frame = CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-44);
        }else{
            _mainWebView.frame = CGRectMake(0, 20+40, ScreenWidth, ScreenHeight-64);
        }
        
    }
    return _mainWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
//    [self.historyArray removeAllObjects];
    // Do any additional setup after loading the view.
}
- (void)configUI{
    [self.view addSubview:self.mainWebView];
    [self.view addSubview:self.navBarView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_needReload == NO) {
        if (self.webViewUrl) {
            [self loadExamplePage];
            [self jsBridgeStart];
        }
        _needReload = YES;
    }else{
        //        [self.mainWebView reload];
    }
}

- (void)jsBridgeStart{
    bridgeDemoWeakSelf;
    if (_bridge != nil) {
        return;
    }
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_mainWebView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"======ObjC received message from JS: %@=======", data);
        [weakSelf addDataToArray:data];
        
    }];
    
}
        

- (void)pushAction{
    RootViewController *vc = [RootViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadExamplePage
{
    NSLog(@"showWebViewURL======================%@",_webViewUrl);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_webViewUrl]];    
    _mainWebView.delegate = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [request setValue:@"https://www.sonystyle.com.cn/" forHTTPHeaderField:@"referer"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [_mainWebView setScalesPageToFit:YES];
    [_mainWebView loadRequest:request];
//    responseData = [NSMutableData data];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

- (void)addDataToArray:(NSString *)dataString{
    bridgeDemoWeakSelf;
    
    JS_Bridge_model *model = [JS_Bridge_model new];
    model.timeLine = [weakSelf getCurrentTimes];
    
    if ([dataString isKindOfClass:[NSString class]]) {
        model.connectData = dataString;
    }else{
        model.connectData = @"非json字符串";
    }
    
    [weakSelf.historyArray addObject:model];
    
}

#pragma mark - webviewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [self addDataToArray:@"开始加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
     [self addDataToArray:@"加载结束"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self addDataToArray:@"加载错误"];
}
#pragma mark - 页面内处理
- (void)removeBasicViews{
    [self.navBarView removeFromSuperview];
    [self.mainWebView removeFromSuperview];
}

#pragma mark - navBarViewDelegate

- (void)clickQuitBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickBackBtn{
    if ([self.mainWebView canGoBack]) {
        [self.mainWebView goBack];
    }
}

- (void)clickHistoryBtn{
    JS_HistoryVCViewController *vc = [JS_HistoryVCViewController new];
    NSMutableArray *newArr = [NSMutableArray new];
    [newArr addObjectsFromArray:self.historyArray];
    vc.dataArray = newArr;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jsInsert{
    [self showJSInsertView];
}

- (void)showJSInsertView{
    bridgeDemoWeakSelf;
    self.jsString = @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请注入JS" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *tfd = alertController.textFields.firstObject;
        weakSelf.jsString = tfd.text;
        [self performSelectorOnMainThread:@selector(insertJS) withObject:nil waitUntilDone:NO];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"OC调用JS方法";
    }];
    [self presentViewController:alertController animated:true completion:nil];
}



- (void)insertJS{
    bridgeDemoWeakSelf;
    JSContext *context=[weakSelf.mainWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSLog(@"jsString =========%@",weakSelf.jsString);
    [context evaluateScript:weakSelf.jsString];
    [weakSelf addDataToArray:[NSString stringWithFormat:@"JS注入:%@",weakSelf.jsString]];
}


@end
