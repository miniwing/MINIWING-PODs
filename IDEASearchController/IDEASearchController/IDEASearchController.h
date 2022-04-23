//
//  GitHub: https://github.com/iphone5solo/PYSearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <IDEASearchController/IDEASearchConst.h>

#if __has_include(<IDEAUIVendor/IDEAUIVendor.h>)
#  define IDEA_UI_VENDOR                                                (1)
#  import <IDEAUIVendor/IDEAUIVendor.h>
#elif __has_include("IDEAUIVendor/IDEAUIVendor.h")
#  define IDEA_UI_VENDOR                                                (1)
#  import "IDEAUIVendor/IDEAUIVendor.h"
#elif __has_include("IDEAUIVendor.h")
#  define IDEA_UI_VENDOR                                                (1)
#  import "IDEAUIVendor.h"
#else
#  define IDEA_UI_VENDOR                                                (0)
#endif

@class IDEASearchController, IDEASearchSuggestionController;

typedef void(^IDEADidSearchBlock)(IDEASearchController *searchController, UISearchBar *searchBar, NSString *searchText);

/**
 style of popular search
 */
typedef NS_ENUM(NSInteger, IDEAHotSearchStyle)  {
   IDEAHotSearchStyleNormalTag,     // normal tag without border
   IDEAHotSearchStyleColorfulTag,   // colorful tag without border, color of background is randrom and can be custom by `colorPol`
   IDEAHotSearchStyleBorderTag,     // border tag, color of background is `clearColor`
   IDEAHotSearchStyleARCBorderTag,  // broder tag with ARC, color of background is `clearColor`
   IDEAHotSearchStyleRankTag,       // rank tag, color of background can be custom by `rankTagBackgroundColorHexStrings`
   IDEAHotSearchStyleRectangleTag,  // rectangle tag, color of background is `clearColor`
   IDEAHotSearchStyleDefault  = IDEAHotSearchStyleNormalTag // default is `IDEAHotSearchStyleNormalTag`
};

/**
 style of search history
 */
typedef NS_ENUM(NSInteger, IDEASearchHistoryStyle) {
   IDEASearchHistoryStyleCell,         // style of UITableViewCell
   IDEASearchHistoryStyleNormalTag,    // style of IDEAHotSearchStyleNormalTag
   IDEASearchHistoryStyleColorfulTag,  // style of IDEAHotSearchStyleColorfulTag
   IDEASearchHistoryStyleBorderTag,    // style of IDEAHotSearchStyleBorderTag
   IDEASearchHistoryStyleARCBorderTag, // style of IDEAHotSearchStyleARCBorderTag
   IDEASearchHistoryStyleDefault = IDEASearchHistoryStyleCell // default is `IDEASearchHistoryStyleCell`
};

/**
 mode of search result view controller display
 */
typedef NS_ENUM(NSInteger, IDEASearchResultShowMode) {
   IDEASearchResultShowModeCustom,   // custom, can be push or pop and so on.
   IDEASearchResultShowModePush,     // push, dispaly the view of search result by push
   IDEASearchResultShowModeEmbed,    // embed, dispaly the view of search result by embed
   IDEASearchResultShowModeDefault = IDEASearchResultShowModeCustom // defualt is `IDEASearchResultShowModeCustom`
};
/**
 mode of search view controller display
 */
typedef NS_ENUM(NSInteger, IDEASearchControllerShowMode) {
   IDEASearchControllerShowModeModal,  // modal, dispaly the view of searchController by modal
   IDEASearchControllerShowModePush,   // push, dispaly the view of searchController by push
   IDEASearchControllerShowDefault = IDEASearchControllerShowModeModal // defualt is `IDEASearchControllerShowModeModal`
};


/**
 The protocol of data source, you can custom the suggestion view by implement these methods the data scource.
 */
@protocol IDEASearchControllerDataSource <NSObject>

@optional

/**
 Return a `UITableViewCell` object.
 
 @param searchSuggestion    view which display search suggestions
 @param indexPath               indexPath of row
 @return a `UITableViewCell` object
 */
- (UITableViewCell *)searchSuggestion:(UITableView *)aSearchSuggestion cellForRowAtIndexPath:(NSIndexPath *)aIndexPath;

/**
 Return number of rows in section.
 
 @param searchSuggestion    view which display search suggestions
 @param section                 index of section
 @return number of rows in section
 */
- (NSInteger)searchSuggestion:(UITableView *)aSearchSuggestion numberOfRowsInSection:(NSInteger)aSection;

/**
 Return number of sections in search suggestion view.
 
 @param searchSuggestion    view which display search suggestions
 @return number of sections
 */
- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)aSearchSuggestion;

/**
 Return height for row.
 
 @param searchSuggestion    view which display search suggestions
 @param indexPath               indexPath of row
 @return height of row
 */
- (CGFloat)searchSuggestion:(UITableView *)aSearchSuggestion heightForRowAtIndexPath:(NSIndexPath *)aIndexPath;

@end


/**
 The protocol of delegate
 */
@protocol IDEASearchControllerDelegate <NSObject, UITableViewDelegate>

@optional

/**
 Called when search begain.
 
 @param searchController    search view controller
 @param searchBar               search bar
 @param searchText              text for search
 */
- (void)searchController:(IDEASearchController *)aSearchController
  didSearchWithSearchBar:(UISearchBar *)aSearchBar
              searchText:(NSString *)aSearchText;

/**
 Called when popular search is selected.
 
 @param searchController    search view controller
 @param index                   index of tag
 @param searchText              text for search
 
 Note: `searchController:didSearchWithSearchBar:searchText:` will not be called when this method is implemented.
 */
- (void)searchController:(IDEASearchController *)aSearchController
didSelectHotSearchAtIndex:(NSInteger)aIndex
              searchText:(NSString *)aSearchText;

/**
 Called when search history is selected.
 
 @param searchController    search view controller
 @param index                   index of tag or row
 @param searchText              text for search
 
 Note: `searchController:didSearchWithSearchBar:searchText:` will not be called when this method is implemented.
 */
- (void)searchController:(IDEASearchController *)aSearchController
didSelectSearchHistoryAtIndex:(NSInteger)aIndex
              searchText:(NSString *)aSearchText;

/**
 Called when search suggestion is selected.
 
 @param searchController    search view controller
 @param index                   index of row
 @param searchText              text for search
 
 Note: `searchController:didSearchWithSearchBar:searchText:` will not be called when this method is implemented.
 */
- (void)searchController:(IDEASearchController *)aSearchController
didSelectSearchSuggestionAtIndex:(NSInteger)aIndex
              searchText:(NSString *)aSearchText IDEASEARCH_DEPRECATED("Use searchController:didSelectSearchSuggestionAtIndexPath:searchText:");

/**
 Called when search suggestion is selected, the method support more custom of search suggestion view.
 
 @param searchController    search view controller
 @param indexPath               indexPath of row
 @param searchBar               search bar
 
 Note: `searchController:didSearchWithSearchBar:searchText:` and `searchController:didSelectSearchSuggestionAtIndex:searchText:` will not be called when this method is implemented.
 Suggestion: To ensure that can cache selected custom search suggestion records, you need to set `searchBar.text` = "custom search text".
 */
- (void)searchController:(IDEASearchController *)aSearchController didSelectSearchSuggestionAtIndexPath:(NSIndexPath *)aIndexPath
               searchBar:(UISearchBar *)aSearchBar;

/**
 Called when search text did change, you can reload data of suggestion view thought this method.
 
 @param searchController    search view controller
 @param searchBar               search bar
 @param searchText              text for search
 */
- (void)searchController:(IDEASearchController *)aSearchController
     searchTextDidChange:(UISearchBar *)aSearchBar
              searchText:(NSString *)aSearchText;

/**
 Called when cancel item did press, default execute `[self dismissViewControllerAnimated:YES completion:nil]`.
 
 @param searchController search view controller
 */
- (void)didClickCancel:(IDEASearchController *)aSearchController;

/**
 Called when back item did press, default execute `[self.navigationController popViewControllerAnimated:YES]`.
 
 @param searchController search view controller
 */
- (void)didClickBack:(IDEASearchController *)aSearchController;

@end

#if IDEA_UI_VENDOR
@interface IDEASearchController : IDEAViewController
#else // #if IDEA_UI_VENDOR
@interface IDEASearchController : UIViewController
#endif // !IDEA_UI_VENDOR

/**
 The delegate
 */
@property (nonatomic, weak) id<IDEASearchControllerDelegate>     delegate;

/**
 The data source
 */
@property (nonatomic, weak) id<IDEASearchControllerDataSource>   dataSource;

/**
 Ranking the background color of the corresponding hexadecimal string (eg: @"#ffcc99") array (just four colors) when `hotSearchStyle` is `IDEAHotSearchStyleRankTag`.
 */
@property (nonatomic, strong) NSArray<NSString *>           * rankTagBackgroundColorHexStrings;

/**
 The pool of color which are use in colorful tag when `hotSearchStyle` is `IDEAHotSearchStyleColorfulTag`.
 */
@property (nonatomic, strong) NSMutableArray<UIColor *>     * colorPol;

/**
 Whether swap the popular search and search history location, default is NO.
 
 Note: It is‘t effective when `searchHistoryStyle` is `IDEASearchHistoryStyleCell`.
 */
@property (nonatomic, assign) BOOL                            swapHotSeachWithSearchHistory;

/**
 The element of popular search
 */
@property (nonatomic, copy)   NSArray<NSString *>           * hotSearches;

/**
 The tags of popular search
 */
@property (nonatomic, copy)   NSArray<UILabel *>            * hotSearchTags;

/**
 The label of popular search header
 */
@property (nonatomic, weak)   UILabel                       * hotSearchHeader;

// HARRY
@property (nonatomic, weak)   UIButton                      * hotSearchRefreshButton;

/**
 Whether show popular search, default is YES.
 */
@property (nonatomic, assign) BOOL                            showHotSearch;

/**
 The title of popular search
 */
@property (nonatomic, copy)   NSString                      * hotSearchTitle;

// HARRY
@property (nonatomic, copy)   NSString                      * hotSearchRefresh;

/**
 The tags of search history
 */
@property (nonatomic, copy)   NSArray<UILabel *>            * searchHistoryTags;

/**
 The label of search history header
 */
@property (nonatomic, weak)   UILabel                       * searchHistoryHeader;

/**
 The title of search history
 */
@property (nonatomic, copy)   NSString                      * searchHistoryTitle;

/**
 Whether show search history, default is YES.
 
 Note: search record is not cache when it is NO.
 */
@property (nonatomic, assign) BOOL                            showSearchHistory;

/**
 The path of cache search record, default is `IDEASEARCH_SEARCH_HISTORY_CACHE_PATH`.
 */
@property (nonatomic, copy)   NSString                      * searchHistoriesCachePath;

/**
 The number of cache search record, default is 20.
 */
@property (nonatomic, assign) NSUInteger                      searchHistoriesCount;

/**
 Whether remove the space of search string, default is YES.
 */
@property (nonatomic, assign) BOOL                            removeSpaceOnSearchString;

/**
 The button of empty search record when `searchHistoryStyle` is’t `IDEASearchHistoryStyleCell`.
 */
@property (nonatomic, weak)   UIButton                      * emptyButton;

/**
 The label od empty search record when `searchHistoryStyle` is `IDEASearchHistoryStyleCell`.
 */
@property (nonatomic, weak)   UILabel                       * emptySearchHistoryLabel;

/**
 The style of popular search, default is `IDEAHotSearchStyleNormalTag`.
 */
@property (nonatomic, assign) IDEAHotSearchStyle              hotSearchStyle;

/**
 The style of search histrory, default is `IDEASearchHistoryStyleCell`.
 */
@property (nonatomic, assign) IDEASearchHistoryStyle          searchHistoryStyle;

/**
 The mode of display search result view controller, default is `IDEASearchResultShowModeCustom`.
 */
@property (nonatomic, assign) IDEASearchResultShowMode        searchResultShowMode;

/**
 The mode of display search view controller, default is `IDEASearchControllerShowModeModal`.
 */
@property (nonatomic, assign) IDEASearchControllerShowMode    searchControllerShowMode;

/**
 The search bar
 */
@property (nonatomic, weak)   UISearchBar                   * searchBar;

/**
 The text field of search bar
 */
@property (nonatomic, weak)   UITextField                   * searchTextField;

/**
 The background color of search bar.
 */
@property (nonatomic, strong) UIColor *searchBarBackgroundColor;

/**
 The cornerRadius of `_UISearchBarSearchFieldBackgroundView` which from `self.searchTextField.subviews`, default is 0.0.
 */
@property (nonatomic, assign) CGFloat searchBarCornerRadius;

/**
 The barButtonItem of cancel
 */
@property (nonatomic, strong) UIBarButtonItem *cancelBarButtonItem;

/**
 The customView of cancelBarButtonItem
 */
@property (nonatomic, weak) UIButton *cancelButton;

/**
 The barButtonItem of back
 */
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;

/**
 The customView of backBarButtonItem
 */
@property (nonatomic, weak) UIButton *backButton;

/**
 The search suggestion view
 */
@property (nonatomic, weak, readonly) UITableView *searchSuggestion;

/**
 The block which invoked when search begain.
 */
@property (nonatomic, copy) IDEADidSearchBlock didSearchBlock;

/**
 The element of search suggestions
 
 Note: it is't effective when `searchSuggestionHidden` is NO or cell of suggestion view is custom.
 */
@property (nonatomic, copy) NSArray<NSString *> *searchSuggestions;

/**
 Whether hidden search suggstion view, default is NO.
 */
@property (nonatomic, assign) BOOL searchSuggestionHidden;

/**
 The view controller of search result.
 */
@property (nonatomic, strong) UIViewController *searchResultController;

/**
 Whether show search result view when search text did change, default is NO.
 
 Note: it is effective only when `searchResultShowMode` is `IDEASearchResultShowModeEmbed`.
 */
@property (nonatomic, assign) BOOL showSearchResultWhenSearchTextChanged;

/**
 Whether show search result view when search bar become first responder again.
 
 Note: it is effective only when `searchResultShowMode` is `IDEASearchResultShowModeEmbed`.
 */
@property (nonatomic, assign) BOOL showSearchResultWhenSearchBarRefocused;

/**
 Whether show keyboard when return to search result, default is YES.
 */
@property (nonatomic, assign) BOOL showKeyboardWhenReturnSearchResult;

/**
 Creates an instance of searchViewContoller with popular searches and search bar's placeholder.
 
 @param hotSearches     popular searchs
 @param placeholder     placeholder of search bar
 @return new instance of `IDEASearchController` class
 */
+ (instancetype)searchControllerWithHotSearches:(NSArray<NSString *> *)hotSearches
                           searchBarPlaceholder:(NSString *)placeholder;

/**
 Creates an instance of searchViewContoller with popular searches, search bar's placeholder and the block which invoked when search begain.
 
 @param hotSearches     popular searchs
 @param placeholder     placeholder of search bar
 @param block           block which invoked when search begain
 @return new instance of `IDEASearchController` class
 
 Note: The `delegate` has a priority greater than the `block`, `block` is't effective when `searchController:didSearchWithSearchBar:searchText:` is implemented.
 */
+ (instancetype)searchControllerWithHotSearches:(NSArray<NSString *> *)hotSearches
                           searchBarPlaceholder:(NSString *)placeholder
                                 didSearchBlock:(IDEADidSearchBlock)block;

@end
