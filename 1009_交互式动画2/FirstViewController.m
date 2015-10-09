//
//  FirstViewController.m
//  1009_交互式动画2
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 xiaoma. All rights reserved.
//

#import "FirstViewController.h"
#import "SecendViewController.h"
#import "Animation.h"

//遵循协议,
//如果是推出模态视图的话,就是UIViewControllerTransitioningDelegate
//如果是NavController的话,就是UINavigationControllerDelegate
//如果是tabBar点击的话,就是UITabBarControllerDelegate
@interface FirstViewController ()<UIViewControllerTransitioningDelegate>
//当是交互动画的时候,需要这个货
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition * interactive;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor yellowColor];
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(100, 120, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //添加滑动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(next:)];
    [self.view addGestureRecognizer:pan];
    
}

-(void)click
{
    NSLog(@"asdfasdf");
}

//发生滑动手势的时候调用的方法
-(void)next:(UIPanGestureRecognizer *)recognizer
{
    

    //获得滑动的比例 0.0 - 1.0之间的数值
    //从右向左滑动的时候为负数
    //从左向右滑动的时候为整数
    NSLog(@"%@",NSStringFromCGPoint([recognizer locationInView:self.view]));
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    NSLog(@"%f",progress);
    //当滑动开始的时候
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        //初始化交互对象
        self.interactive = [[UIPercentDrivenInteractiveTransition alloc]init];
        //推出的视图
        SecendViewController * sec = [[SecendViewController alloc]init];
        //设置推出的视图的代理为自己,这样的话,就能调用UIViewControllerTransitioningDelegate的代理方法
        sec.transitioningDelegate = self;
        //推出视图
        [self presentViewController:sec animated:YES completion:nil];
    }else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        //当状态改变的时候,更新交互界面,也就是界面随着手指运动,从右向左滑动的时候,时progress是负数,取反
        [self.interactive updateInteractiveTransition:-progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        //当滑动大于一半的时候,完成转场,否则,取消转场
        if (progress < -0.5) {
            [self.interactive finishInteractiveTransition];
        }else
        {
            [self.interactive cancelInteractiveTransition];
        }
        self.interactive = nil;
    }
    
    
}


#pragma mark -- 下边的方法是 UIViewControllerTransitioningDelegate的代理方法,分别是对应的,一个present,一个dismiss, 交互对象也是对应的,一个present 一个dissmiss

#pragma mark -- present 的时候需要的动画
//模态视图的present代理方法,返回一个遵循UIViewControllerAnimatedTransitioning协议的对象
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    Animation * animation = [[Animation alloc]init];
    //设置动画的类型为present
    animation.type = present;
    return animation;
}


#pragma mark -- dissmiss 的时候需要的动画
/*
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
}
*/

//交互对象
#pragma mark -- present 的时候需要的交互对象
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactive;
}


#pragma mark -- 交互dissmiss时的对象
/*
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    
}
*/


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
