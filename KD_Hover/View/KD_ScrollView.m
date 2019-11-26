//
//  KD_ScrollView.m
//  KD_Hover
//
//  Created by paul on 2019/11/26.
//  Copyright © 2019 paul. All rights reserved.
//

#import "KD_ScrollView.h"

@interface KD_ScrollView()<UIGestureRecognizerDelegate>

@end

@implementation KD_ScrollView

//当手势识别器或otherGestureRecognizer的识别被另一个阻止时调用
//返回YES，以允许它们同时识别。 默认实现返回NO（默认情况下，无法同时识别两个手势）
//
//注意：保证返回YES允许同时识别。 不保证返回NO会阻止同时识别，因为另一个手势的代表可能会返回YES
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
