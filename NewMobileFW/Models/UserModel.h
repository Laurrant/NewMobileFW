//
//  UserModel.h
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-18.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject

@property (nonatomic,strong)NSString *userName;

@property(nonatomic,strong)NSString *userID;

@property(nonatomic,weak) UIImage *userImage;

@end
