//
//  MFAPluginManager.m
//  NewMobileFW
//
//  Created by ElandApple02 on 15-4-2.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MFAPluginManager.h"
#import <libxml/tree.h>
#define kConfigFileName @"mfa_plugins"

static MFAPluginManager *_pluginManager=nil;

static NSDictionary* _pluginConfigDictionary=nil;

@implementation MFAPluginManager

+ (MFAPluginManager*) sharedInstance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (_pluginManager == nil)
        {
            _pluginManager=[[self alloc] init];
            NSString *filePath = [[NSBundle mainBundle]pathForResource:kConfigFileName ofType:@"xml"];
        }
    }
    return _pluginManager;
}

+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    @synchronized (self) {
        if (_pluginManager == nil) {
            _pluginManager = [super allocWithZone:zone];
            return _pluginManager;
        }
    }
    return _pluginManager;
}

- (id)init
{
    @synchronized(self) {
        self=[super init];//往往放一些要初始化的变量.
        
        return self;
    }
}

@end
