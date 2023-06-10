//
//  IDEACycleViewCell.m
//  IDEACycleView
//
//  Created by uDoctor on 2019/12/4.
//  Copyright © 2019 UD. All rights reserved.
//

#import "IDEACycleViewCell.h"


@interface IDEACycleViewCell()


@property (nonatomic, strong) UILabel *contentLabs;

@end

static NSCache *cache = nil;

@implementation IDEACycleViewCell

- (instancetype)init {
   
   self = [super init];
   
   if (self) {
      
      [self setupViews];
      
   } /* End if () */
   
   return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
   
   self = [super initWithFrame:frame];
   if (self) {
      [self setupViews];
      
   } /* End if () */
   
   return self;
}

- (void)fillElementWithView:(UIView *)aView {
   
   if (nil != aView) {
            
   } /* End if () */
   else {
            
   } /* End else */

   return;
}

#pragma mark - private
- (void)setupViews {

   return;
}

- (void)setLayout {
   
   return;
}

- (void)layoutSubviews {
   
   [self setLayout];
   
   return;
}

@end
