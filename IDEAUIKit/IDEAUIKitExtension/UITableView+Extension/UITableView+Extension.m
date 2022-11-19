//
//  UITableView+Extension.m
//  UITableView+Extension
//
//  Created by Harry on 15/1/13.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

- (void)unselect:(BOOL)aAnimated {
   
   [self performSelector:@selector(unselectCurrentRow:)
              withObject:@(aAnimated)
              afterDelay:UIATableViewSelectedDefaultDuration];

   return;
}

- (void)unselectCurrentRow:(NSNumber *)aAnimated {
   
   [self deselectRowAtIndexPath:[self indexPathForSelectedRow] animated:aAnimated.boolValue];
   
   return;
}

- (void)clearHeaderView {
   
   self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.01f)];
   
   if (self.tableHeaderView) {
      
      [self.tableHeaderView setBackgroundColor:UIColor.clearColor];
      
   } /* End if () */
   
   return;
}

- (void)clearFooterView {
   
   self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.01f)];
   
   if (self.tableFooterView) {
      
      [self.tableFooterView setBackgroundColor:UIColor.clearColor];
      
   } /* End if () */
   
   return;
}

/**********************************************************************************************/
/**
 Select all rows in tableView.
 
 @param animated YES to animate the transition, NO to make the transition immediate.
 */
- (void)selectedAllRowsAnimated:(BOOL)aAnimated {
   
//   let totalSections = self.numberOfSections
//           for section in 0 ..< totalSections {
//               let totalRows = self.numberOfRows(inSection: section)
//               for row in 0 ..< totalRows {
//                   let indexPath = IndexPath(row: row, section: section)
//                   // call the delegate's willSelect, select the row, then call didSelect
//                   self.delegate?.tableView?(self, willSelectRowAt: indexPath)
//                   self.selectRow(at: indexPath, animated: animated, scrollPosition: .none)
//                   self.delegate?.tableView?(self, didSelectRowAt: indexPath)
//               }
//           }
//       }
   
   NSInteger   nSections   = self.numberOfSections;
   
   for (int nSection = 0; nSection < nSections; ++nSection) {
      
      NSInteger   nRows    = [self numberOfRowsInSection:nSection];
      
      for (int nRow = 0; nRow < nRows; ++nRow) {
         
         NSIndexPath *stIndexPath   = [NSIndexPath indexPathForRow:nRow inSection:nSection];
         
         if (self.delegate && [self.delegate respondsToSelector:@selector(tableView: willSelectRowAtIndexPath:)]) {
            
            [self.delegate tableView:self willSelectRowAtIndexPath:stIndexPath];
            
         } /* End if () */
         
         [self selectRowAtIndexPath:stIndexPath animated:aAnimated scrollPosition:UITableViewScrollPositionNone];

         if (self.delegate && [self.delegate respondsToSelector:@selector(tableView: didSelectRowAtIndexPath:)]) {
            
            [self.delegate tableView:self didSelectRowAtIndexPath:stIndexPath];
            
         } /* End if () */

      } /* End for () */
      
   } /* End for () */

   return;
}
/**********************************************************************************************/

@end
