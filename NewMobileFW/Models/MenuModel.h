//
//  MenuModel.h
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-19.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property(strong,nonatomic)NSString *title;

@property(strong,nonatomic)NSString *controllerName;

@property(strong,nonatomic)id<NSObject> menuParam;

@end
