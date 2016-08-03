//
//  CSLoginViewController.m
//  ZJHCodeshare
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CSLoginViewController.h"
#import <Masonry.h>
//这里面封装了一个方法 可以让我们通过一个颜色，生成一张纯色图片
#import "UIImage+Color.h"
#import "UIButton+BackgroundColor.h"
#import "CSForgetViewController.h"
#import "UIControl+ActionBlocks.h"
#import "CSRegisterViewController.h"

@interface CSLoginViewController ()

@end

@implementation CSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"登录";
    
    //一般创建UI 都会写到 viewDidLoad
    //viewDidLoad是控制器的视图已经加载完毕的时候 会自动调用的一个方法
    
    [self setUpViews];
    
}

//界面将要出现
- (void)viewWillAppear:(BOOL)animated {
    
}

//界面已经出现
- (void)viewDidAppear:(BOOL)animated {
    
}

//界面将要消失
- (void)viewWillDisappear:(BOOL)animated {
    
}

//界面已经消失
- (void)viewDidDisappear:(BOOL)animated {
    
}


- (void)setUpViews {
    
    //创建手机号码输入框 密码输入框 登录按钮
    UITextField * phonetext = [[UITextField alloc]init];
    [self.view addSubview:phonetext];
    
    UITextField * passwordtext = [[UITextField alloc]init];
    [self.view addSubview:passwordtext];
    
    
    phonetext.placeholder = @"请输入邮箱或手机号码";
    passwordtext.placeholder = @"请输入密码";
    phonetext.backgroundColor = [UIColor whiteColor];
    passwordtext.backgroundColor = [UIColor whiteColor];
    
    passwordtext.secureTextEntry = YES;
 
    UIImageView * phoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户图标"]];
    UIImageView * passwordLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码图标"]];
    
    UIView * phoneLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    UIView * passLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    [phoneLeft addSubview:phoneLeftImage];
    [passLeft addSubview:passwordLeftImage];
    
    [phoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        //让视图剧中
        make.center.equalTo(@0);
    }];
    [passwordLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(@0);
    }];
    
    
    //添加最左边图片
    phonetext.leftView = phoneLeft;
    passwordtext.leftView = passLeft;
    
    //添加以后不会立即显示 要说明什么时候显示
    phonetext.leftViewMode = UITextFieldViewModeAlways;
    passwordtext.leftViewMode = UITextFieldViewModeAlways;
    
    
    //手写输入框的布局
    //在手写布局的时候，我们添加的所有约束必须能够唯一确定 整个视图的位置和大小
    [phonetext mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //距离左边
//        make.left.equalTo(@0);
//        //距离右边
//        make.right.equalTo(@0);
        //高度
        make.height.equalTo(@64);
        //距离顶部
        make.top.equalTo(@120);
        
        //距离左边右边可以一块写
        make.left.right.equalTo(@0);
        //因为Masonry 在实现的时候，充分考虑到我们写约束的时候越简单越好，所以引入了链式写法,我们在写的时候，可以尽量的将一样的约束一块写
        
    }];
    [passwordtext mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(phonetext.mas_bottom);
        
    }];
    
    
    phonetext.font = [UIFont systemFontOfSize:15 weight:-0.15];
    passwordtext.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
    phonetext.layer.borderColor = [UIColor grayColor].CGColor;
    phonetext.layer.borderWidth = 0.5;
    passwordtext.layer.borderColor = [UIColor grayColor].CGColor;
    passwordtext.layer.borderWidth = 0.5;
    
    
    //写自定义button一定要用这个工厂方法
    UIButton * forgetPass = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPass titleLabel].font = [UIFont systemFontOfSize:14];
    
    //80 64
    //我们用autoLayout时候，就不能再以某个视图的frame当作参数来用（此时，视图的frame是不可靠的）
    [forgetPass setFrame:CGRectMake(self.view.frame.size.width - 80, 250, 80, 64)];
    [self.view addSubview:forgetPass];
    
    
    //登录按钮
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton titleLabel].font = [UIFont systemFontOfSize:15];
    
    [loginButton setFrame:CGRectMake(0, 320, self.view.frame.size.width, 64)];
    [self.view addSubview:loginButton];
    /*如果要让按钮在不同状态的时候显示不同的背景颜色
     1.不同的状态设置不同的图片
     我们需要做很多图片，比较麻烦，图片太多，占用空间
     2.在不同的状态时间下面，设置按钮的背景颜色
     我们需要实现很多方法，很麻烦
     3.使用封装好的分类方法
     */
    
    [loginButton setBackgroundColor:[UIColor colorWithRed:0.586 green:1.000 blue:0.187 alpha:1.000] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor grayColor]forState:UIControlStateDisabled];
    [loginButton setBackgroundColor:[UIColor lightGrayColor]forState:UIControlStateHighlighted];
    
    /*当我们不用antuLayout 的时候，如何去让视图自适应
     
     autoResizing
     
     */
    
    
    
    /*
     UIViewAutoresizingNone                 = 0,
     UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
     UIViewAutoresizingFlexibleWidth        = 1 << 1,
     UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
     UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
     UIViewAutoresizingFlexibleHeight       = 1 << 4,
     UIViewAutoresizingFlexibleBottomMargin = 1 << 5
     */
    
    loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //两个跳转界面
//    [forgetPass setTintColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [forgetPass setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    //设置按钮的动作，跳转到另一个控制器
//    [forgetPass addTarget:self action:@selector(gotoForget) forControlEvents:UIControlEventTouchUpInside];
    
    //我们还可以将按钮的事件与按钮写到一块
    //1.
    [forgetPass handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        //把按钮的事件回调写道block里，便于我们在写界面的时候方便的加入控制事件
        CSForgetViewController * forgetVC = [[CSForgetViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];

    }];
 
    //这里用系统自带的 barButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(gotoRegister)];
    
}

- (void)gotoRegister {
    
    CSRegisterViewController * regisVC = [[CSRegisterViewController alloc]init];
    [self.navigationController pushViewController:regisVC animated:YES];
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
