//
//  bridgeHistoryCell.m
//  iOS_JS_Bridge_demo
//
//  Created by 陈威利 on 2018/7/25.
//  Copyright © 2018年 陈威利. All rights reserved.
//

#import "bridgeHistoryCell.h"

@interface bridgeHistoryCell()
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *historyLabel;
@end

@implementation bridgeHistoryCell
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}

- (UILabel *)historyLabel{
    if (_historyLabel == nil) {
        _historyLabel = [UILabel new];
        _historyLabel.font = [UIFont systemFontOfSize:11];
        _historyLabel.numberOfLines = 0;
    }
    return _historyLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    bridgeDemoWeakSelf;
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).offset(5);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-5);
        make.top.equalTo(weakSelf.contentView.mas_top).offset(5);
    }];
    [self.contentView addSubview:self.historyLabel];
    [self.historyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).offset(5);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-5);
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).offset(5);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-5);
    }];
}

- (void)setData:(JS_Bridge_model *)model{
    
    _timeLabel.text = model.timeLine;
    _historyLabel.text = model.connectData;
    [self layoutSubviews];
}

//- (void)layoutSubviews{
//    bridgeDemoWeakSelf;
//    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.contentView.mas_left).offset(5);
//        make.right.equalTo(weakSelf.contentView.mas_right).offset(-5);
//        make.top.equalTo(weakSelf.contentView.mas_top).offset(5);
//    }];
//    [self.historyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.contentView.mas_left).offset(5);
//        make.right.equalTo(weakSelf.contentView.mas_right).offset(-5);
//        make.top.equalTo(weakSelf.timeLabel.mas_bottom).offset(5);
////        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-5);
//    }];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
