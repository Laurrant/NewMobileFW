//
//  MenuTableViewController.h
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-18.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuUserViewController;
@class UserModel;
@interface MenuTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)MenuUserViewController * menuUserView;

-(bool)setUser:(UserModel *)user;

@end
