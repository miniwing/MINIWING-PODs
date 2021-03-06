// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "IDEAPaletteNames.h"

BOOL IDEAPaletteIsTintOrAccentName(NSString* _Nonnull name) {
   return [name isEqualToString:IDEA_PALETTE_TINT_50_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_100_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_200_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_300_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_400_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_500_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_600_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_700_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_800_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_TINT_900_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_ACCENT_100_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_ACCENT_200_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_ACCENT_400_INTERNAL_NAME] ||
   [name isEqualToString:IDEA_PALETTE_ACCENT_700_INTERNAL_NAME];
}
