//
//  MenuUserViewController.m
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-18.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MenuUserViewController.h"
#import "UserModel.h"

@interface MenuUserViewController ()

@end

@implementation MenuUserViewController

-(instancetype)initWithUser:(UserModel *)user;
{
    self=[super init];
    if(user)
    {
        [self setUserID: user.userID];
        [self setUserImage:user.userImage];

        [self setUserName: user.userName];

        self.view.frame=CGRectMake(0, 0, 100, 100);
    
        [self setUserInView:user];
    }
    
    
    return self;
}

-(bool)setUserInView:(UserModel *)user
{
    if(!self.userImageView)
    {
        if(user.userImage)
        {
            UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(259/3, 100/3, 259/3, 100/3)];
            //imv.backgroundColor=[UIColor redColor];
            //[imv sizeToFit];
            imv.contentMode =  UIViewContentModeScaleAspectFill;
            [imv setImage:user.userImage];
            self.userImageView=imv;
            [self.view addSubview:self.userImageView];
        }
    }
    else
    {
        if(user.userImage)
        {
            [self.userImageView setImage:user.userImage];
        }
    }
    
    if(!self.userNameLable)
    {
        UILabel *uil=[[UILabel alloc]initWithFrame:CGRectMake(0, 85, 259, 15)];
        //uil.backgroundColor=[UIColor redColor];
        [uil setText:user.userName];
        uil.textAlignment=NSTextAlignmentCenter;
        self.userNameLable=uil;
        [self.view addSubview:self.userNameLable];
    }
    else
    {
        [self.userNameLable setText:user.userName];
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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

@end
