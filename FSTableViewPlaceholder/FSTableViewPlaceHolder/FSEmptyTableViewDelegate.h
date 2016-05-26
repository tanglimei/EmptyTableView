//
//  FSEmptyTableViewDelegate.h
//  FSTableViewPlaceholder
//
//  Created by GIKI on 16/5/16.
//  Copyright © 2016年 GIKI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSEmptyTableViewDelegate <NSObject>

@required
- (UIView *)fs_getEmptyView;


@optional
- (BOOL)fs_emptyViewEnableScoll;

@end
