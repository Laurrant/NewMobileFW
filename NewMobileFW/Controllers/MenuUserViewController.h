//
//  MenuUserViewController.h
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-18.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserModel;

@interface MenuUserViewController : UIViewController

@property (nonatomic,strong)NSString *userName;

@property(nonatomic,strong)NSString *userID;

@property(nonatomic,strong)UIImage *userImage;


@property(nonatomic,strong)UIImageView *userImageView;


@property(nonatomic,strong)UILabel *userNameLable;

-(instancetype)initWithUser:(UserModel *)user;

-(bool)setUserInView:(UserModel *)user;

@end
