//
//  UITableView+FSEmptyView.m
//  FSTableViewPlaceholder
//
//  Created by GIKI on 16/5/16.
//  Copyright © 2016年 GIKI. All rights reserved.
//

#import "UITableView+FSEmptyView.h"
#import "FSEmptyTableViewDelegate.h"
#import <objc/runtime.h>

@interface UITableView()

@property(nonatomic,strong)UIView * emptyView;

@property(nonatomic,assign)BOOL scorllDidEnabled;

@end

@implementation UITableView (FSEmptyView)

- (BOOL)scrollDidEnabled{
    NSNumber * scrollDidEnabledObj =objc_getAssociatedObject(self, @selector(scrollDidEnabled));
    return [scrollDidEnabledObj boolValue];
}

- (void)setScorllDidEnabled:(BOOL)scorllDidEnabled{
    NSNumber * scrollDidEnabledObj = [NSNumber numberWithBool:scorllDidEnabled];
    objc_setAssociatedObject(self, @selector(scrollDidEnabled), scrollDidEnabledObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)emptyView{
    return objc_getAssociatedObject(self, @selector(emptyView));
}

- (void)setEmptyView:(UIView *)emptyView{
    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public Method
- (void)fs_emptyReloadData{
    [self reloadData];
    [self loadEmptyDataSource];
}

- (void)loadEmptyDataSource{
    BOOL isEmptyView = YES;
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self];
    }
    for (int i = 0; i<sections; ++i) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];
        if (rows) { //存在
            isEmptyView = NO;
        }
    }
    if (!isEmptyView != !self.emptyView) {
        if (isEmptyView) {
            self.scrollEnabled = self.scrollEnabled;
            BOOL scrollEnabled = NO;
            if ([self respondsToSelector:@selector(fs_emptyViewEnableScoll)]) {
                scrollEnabled = [self performSelector:@selector(fs_emptyViewEnableScoll)];
                if (!scrollEnabled) {
                    NSString *reason = @"设置为不可滚动";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }

            }else if ([self.delegate respondsToSelector:@selector(fs_emptyViewEnableScoll)]){
                scrollEnabled = [self.delegate performSelector:@selector(fs_emptyViewEnableScoll)];
                if (!scrollEnabled) {
                    NSString * reason = @"设置为不可滚动";
                    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
                }
                
            }
            self.scrollEnabled = scrollEnabled;
            if ([self respondsToSelector:@selector(fs_getEmptyView)]) {
                self.emptyView = [self performSelector:@selector(fs_getEmptyView)];
            }else if([self.delegate respondsToSelector:@selector(fs_getEmptyView)]){
                self.emptyView = [self.delegate performSelector:@selector(fs_getEmptyView)];
            }else{
                NSString * selectorName = NSStringFromSelector(_cmd);
                NSString * reason =  [NSString stringWithFormat:@"You must implement makePlaceHolderView method in your custom tableView or its delegate class if you want to use %@", selectorName];
                @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
            }
            self.emptyView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [self addSubview:self.emptyView];
        }else{
        
            self.scrollEnabled = self.scorllDidEnabled;
            [self.emptyView removeFromSuperview];
            self.emptyView = nil;
            
        }
    }else if(isEmptyView){
        [self.emptyView removeFromSuperview];
        [self addSubview:self.emptyView];
    }
}

@end
