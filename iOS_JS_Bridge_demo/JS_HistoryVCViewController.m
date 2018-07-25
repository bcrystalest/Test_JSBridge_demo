//
//  JS_HistoryVCViewController.m
//  iOS_JS_Bridge_demo
//
//  Created by 陈威利 on 2018/7/25.
//  Copyright © 2018年 陈威利. All rights reserved.
//

#import "JS_HistoryVCViewController.h"
#import "bridgeHistoryCell.h"
@interface JS_HistoryVCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *mainTableView;
@end

@implementation JS_HistoryVCViewController
- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(1, 1, 1, 1) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        [_mainTableView registerClass:[bridgeHistoryCell class] forCellReuseIdentifier:@"bridgeHistoryCell"];
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (KIsiPhoneX) {
        self.mainTableView.frame = CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-44);
    }else{
        self.mainTableView.frame = CGRectMake(0, 20+40, ScreenWidth, ScreenHeight-64);
    }
    [self.view addSubview:self.mainTableView];
    self.navBarView.backBtn.hidden = YES;
    self.navBarView.historyBtn.hidden = YES;
    self.navBarView.jsInsertBtn.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"bridgeHistoryCell";
    bridgeHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[bridgeHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JS_Bridge_model *model = self.dataArray[indexPath.row];
    [cell setData:model];
    return cell;
}

//- (void)setDataArray:(NSMutableArray *)dataArray{
//    self.dataArray = dataArray;
//    [_mainTableView reloadData];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
