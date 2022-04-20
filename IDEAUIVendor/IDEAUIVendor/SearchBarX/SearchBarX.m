//
//  SearchBarX.m
//  SearchBarX
//
//  Created by Harry on 2022/3/27.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "SearchBarX.h"
#import "SearchBarX+Inner.h"

@interface SearchBarX ()

@end

@implementation SearchBarX

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

   __SUPER_DEALLOC;

   return;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithCoder:aCoder];
   
   if (self) {

   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)awakeFromNib {

   int                            nErr                                     = EFAULT;

   UIButton                      *stCancelButton                           = nil;

   __TRY;

   [super awakeFromNib];
   // Initialization code

   [self.searchBar setBackgroundImage:[UIImage new]];
   
//   [self.searchBar setPlaceholder:__LOCALIZED_STRING(self.class, @"Search")];

   [self.searchBar setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor systemBackground])];
   [self.searchBar setReturnKeyType:UIReturnKeySearch];

   if (@available(iOS 13.0, *)) {
      
      self.searchTextField = self.searchBar.searchTextField;
      
   } /* End if () */
   else {
      
      self.searchTextField = [self.searchBar valueForKey:@"_searchField"];

   } /* End else */

   [self.searchTextField setPlaceholderColorPicker:DKColorPickerWithKey([IDEAColor placeholderText])];
   [self.searchTextField setTextColorPicker:DKColorPickerWithKey([IDEAColor label])];
   [self.searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
   [self.searchTextField setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor tertiarySystemGroupedBackground])];

   [self setCancelButtnAttributes];
   
   __CATCH(nErr);

   return;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)aRect {
   
   // Drawing code

   return;
}
*/

@end
