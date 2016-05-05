//
//  APLBlocks.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^APLCodeBlock)(void);

void APLDispatchBlockToMainQueue(APLCodeBlock);