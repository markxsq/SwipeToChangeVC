//
//  Animation.m
//  1009_交互式动画2
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 xiaoma. All rights reserved.
//

#import "Animation.h"

@implementation Animation

//协议里的方法
//动画时长
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}


//动画内容
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //当动画时dismiss的时候
    if (self.type == dismiss) {
        
        //拿到上下文的view,相当于一个舞台
        UIView * view = [transitionContext containerView];
        
        //例如从A -> B
        //则 fromeView 就是A,
        //则 toView    就是B
        UIView * fromeView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        
        UIView * toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        
        //根据动画的样式不同,两个view摆放的位置不同,这里的动画时模仿navController pop时候的滑动返回效果
        //所以,把将要出现的view放在自己下边
        [view insertSubview:toView belowSubview:fromeView];
        //开始动画
        [UIView animateWithDuration:1.0 animations:^{
            //让自己走出一个屏幕
            fromeView.transform = CGAffineTransformMakeTranslation(375, 0);
            
            
        } completion:^(BOOL finished) {
            //完成时候一定要调用这个方法,不然会发生意想不到的情况
            //这个方法标志者动画的完成
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            
        }];
    }else if(self.type == present)
    {
        //和上边类似
        UIView * view = [transitionContext containerView];
        
        UIView * fromeView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        
        UIView * toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        
        //这里模仿的是滑动切换的效果
        //先让将要出现的view走出一个屏幕
        //然后把他俩都加到舞台上
        toView.transform = CGAffineTransformMakeTranslation(375, 0);
        [view addSubview:fromeView];
        [view addSubview:toView];
        
        //开始动画
        [UIView animateWithDuration:1.0f animations:^{
            //让将要出现的view的最终位置就是屏幕的位置
            //另一个view从左边退出
            toView.transform = CGAffineTransformMakeTranslation(0, 0);
            fromeView.transform = CGAffineTransformMakeTranslation(-375, 0);
            
        } completion:^(BOOL finished) {
            //重置fromeView
            //自己remove的话,系统就会remove
            fromeView.transform = CGAffineTransformIdentity;
            
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
        
        
        
    }
    

    
    
}

@end
