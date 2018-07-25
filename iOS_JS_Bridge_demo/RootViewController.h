//
//  RootViewController.h
//  MenuCreateProduct
//
//  Created by 陈威利 on 2018/7/24.
//  Copyright © 2018年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavbarView.h"
@interface RootViewController : UIViewController
@property (nonatomic, assign)BOOL needReload;
@property (nonatomic, strong)NavbarView *navBarView;
@property(nonatomic,retain)NSString *webViewUrl;
- (void)removeBasicViews;
@end
