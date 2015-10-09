//
//  SecendViewController.m
//  1009_交互式动画2
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 xiaoma. All rights reserved.
//

#import "SecendViewController.h"
#import "Animation.h"
@interface SecendViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong)UIPercentDrivenInteractiveTransition * interactive;

@end

@implementation SecendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    [self.view addGestureRecognizer:pan];
    
    
}


-(void)dismiss:(UIPanGestureRecognizer *)recognizer
{
    self.transitioningDelegate = self;
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactive = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        [self.interactive updateInteractiveTransition:progress];
    }else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (progress > 0.5) {
            [self.interactive finishInteractiveTransition];
        }else
        {
            [self.interactive cancelInteractiveTransition];
        }
        self.interactive = nil;
    }
    
    
    
    
}


-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    Animation * animation = [[Animation alloc]init];
    animation.type = dismiss;
    
    return animation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactive;
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
