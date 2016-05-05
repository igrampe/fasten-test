//
//  APLBlocks.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "APLBlocks.h"

void APLDispatchBlockToMainQueue(APLCodeBlock block)
{
    if ([NSThread isMainThread])
    {
        if (block)
        {
            block();
        }
    } else
    {
        dispatch_async(dispatch_get_main_queue(),
        ^
        {
            if (block)
            {
                block();
            }
        });
    }
}
