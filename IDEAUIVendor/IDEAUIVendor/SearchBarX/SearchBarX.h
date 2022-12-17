//
//  SearchBarX.h
//  SearchBarX
//
//  Created by Harry on 2022/3/27.
//
//  Mail: miniwing.hz@gmail.com
//

#import <IDEAUIVendor/IDEAUIVendor.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchBarX : IDEAView <UISearchBarDelegate>

@property (nonatomic, weak)   IBOutlet       UISearchBar                         * searchBar;

@property (nonatomic, strong, readonly)      UITextField                         * searchTextField;
@property (nonatomic, assign)                UITextFieldViewMode                   cancelButtonMode;

@end

@interface SearchBarX ()

@property (nonatomic, copy)                  void                                  (^onBeginSearch)(void);
@property (nonatomic, copy)                  void                                  (^onEndSearch)(void);
@property (nonatomic, copy)                  void                                  (^onTextChange)(NSString *aText);

@end

@interface SearchBarX ()

- (void)setSearchTextFieldBackgroundColor:(UIColor *)aColor;
- (BOOL)resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
