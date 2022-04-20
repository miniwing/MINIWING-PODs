//
//  SearchBarX+Inner.h
//  SearchBarX
//
//  Created by Harry on 2022/3/27.
//
//  Mail: miniwing.hz@gmail.com
//

#import "SearchBarX.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchBarX ()

@property (nonatomic, strong)                UITextField                         * searchTextField;
@property (nonatomic, assign)                BOOL                                  shouldEndEditing;

@end

@interface SearchBarX ()

- (void)setCancelButtnAttributes;

@end

@interface SearchBarX (Inner)

@end

NS_ASSUME_NONNULL_END
