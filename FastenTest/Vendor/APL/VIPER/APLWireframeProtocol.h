//
//  APLWireframeProtocol.h
//  gpn
//
//  Created by Semyon Belokovsky on 16/02/16.
//  Copyright © 2016 Hyperboloid. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APLServiceLocator;

@protocol APLWireframeProtocol <NSObject>

@property (nonatomic, strong) APLServiceLocator *serviceLocator;

@end
