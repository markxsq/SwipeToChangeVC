//
//  Animation.h
//  1009_交互式动画2
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//定义枚举类型,来对应不同的转场
typedef NS_ENUM(NSInteger, AnimationType){
 
    present,
    dismiss
    
};

//遵守动画转场协议
@interface Animation : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)AnimationType type;

@end
