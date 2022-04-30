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

#import "IDEAPalettes.h"
#import "private/IDEAPaletteExpansions.h"
#import "private/IDEAPaletteNames.h"

const IDEAPaletteTint   IDEAPaletteTint50Name      = IDEA_PALETTE_TINT_50_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint100Name     = IDEA_PALETTE_TINT_100_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint200Name     = IDEA_PALETTE_TINT_200_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint300Name     = IDEA_PALETTE_TINT_300_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint400Name     = IDEA_PALETTE_TINT_400_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint500Name     = IDEA_PALETTE_TINT_500_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint600Name     = IDEA_PALETTE_TINT_600_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint700Name     = IDEA_PALETTE_TINT_700_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint800Name     = IDEA_PALETTE_TINT_800_INTERNAL_NAME;
const IDEAPaletteTint   IDEAPaletteTint900Name     = IDEA_PALETTE_TINT_900_INTERNAL_NAME;

const IDEAPaletteAccent IDEAPaletteAccent100Name   = IDEA_PALETTE_ACCENT_100_INTERNAL_NAME;
const IDEAPaletteAccent IDEAPaletteAccent200Name   = IDEA_PALETTE_ACCENT_200_INTERNAL_NAME;
const IDEAPaletteAccent IDEAPaletteAccent400Name   = IDEA_PALETTE_ACCENT_400_INTERNAL_NAME;
const IDEAPaletteAccent IDEAPaletteAccent700Name   = IDEA_PALETTE_ACCENT_700_INTERNAL_NAME;

// Creates a UIColor from a 24-bit RGB color encoded as an integer.
static inline UIColor *ColorFromRGB(uint32_t rgbValue) {
   return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                          green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                           blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                          alpha:1];
}

@interface IDEAPalette () {
   NSDictionary<IDEAPaletteTint, UIColor *> *_tints;
   NSDictionary<IDEAPaletteAccent, UIColor *> *_accents;
}

@end

@implementation IDEAPalette

+ (IDEAPalette *)redPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xFFEBEE),
         IDEAPaletteTint100Name : ColorFromRGB(0xFFCDD2),
         IDEAPaletteTint200Name : ColorFromRGB(0xEF9A9A),
         IDEAPaletteTint300Name : ColorFromRGB(0xE57373),
         IDEAPaletteTint400Name : ColorFromRGB(0xEF5350),
         IDEAPaletteTint500Name : ColorFromRGB(0xF44336),
         IDEAPaletteTint600Name : ColorFromRGB(0xE53935),
         IDEAPaletteTint700Name : ColorFromRGB(0xD32F2F),
         IDEAPaletteTint800Name : ColorFromRGB(0xC62828),
         IDEAPaletteTint900Name : ColorFromRGB(0xB71C1C)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xFF8A80),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xFF5252),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0xFF1744),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0xD50000)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)pinkPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xFCE4EC),
         IDEAPaletteTint100Name : ColorFromRGB(0xF8BBD0),
         IDEAPaletteTint200Name : ColorFromRGB(0xF48FB1),
         IDEAPaletteTint300Name : ColorFromRGB(0xF06292),
         IDEAPaletteTint400Name : ColorFromRGB(0xEC407A),
         IDEAPaletteTint500Name : ColorFromRGB(0xE91E63),
         IDEAPaletteTint600Name : ColorFromRGB(0xD81B60),
         IDEAPaletteTint700Name : ColorFromRGB(0xC2185B),
         IDEAPaletteTint800Name : ColorFromRGB(0xAD1457),
         IDEAPaletteTint900Name : ColorFromRGB(0x880E4F)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xFF80AB),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xFF4081),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0xF50057),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0xC51162)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)purplePalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xF3E5F5),
         IDEAPaletteTint100Name : ColorFromRGB(0xE1BEE7),
         IDEAPaletteTint200Name : ColorFromRGB(0xCE93D8),
         IDEAPaletteTint300Name : ColorFromRGB(0xBA68C8),
         IDEAPaletteTint400Name : ColorFromRGB(0xAB47BC),
         IDEAPaletteTint500Name : ColorFromRGB(0x9C27B0),
         IDEAPaletteTint600Name : ColorFromRGB(0x8E24AA),
         IDEAPaletteTint700Name : ColorFromRGB(0x7B1FA2),
         IDEAPaletteTint800Name : ColorFromRGB(0x6A1B9A),
         IDEAPaletteTint900Name : ColorFromRGB(0x4A148C)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xEA80FC),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xE040FB),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0xD500F9),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0xAA00FF)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)deepPurplePalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xEDE7F6),
         IDEAPaletteTint100Name : ColorFromRGB(0xD1C4E9),
         IDEAPaletteTint200Name : ColorFromRGB(0xB39DDB),
         IDEAPaletteTint300Name : ColorFromRGB(0x9575CD),
         IDEAPaletteTint400Name : ColorFromRGB(0x7E57C2),
         IDEAPaletteTint500Name : ColorFromRGB(0x673AB7),
         IDEAPaletteTint600Name : ColorFromRGB(0x5E35B1),
         IDEAPaletteTint700Name : ColorFromRGB(0x512DA8),
         IDEAPaletteTint800Name : ColorFromRGB(0x4527A0),
         IDEAPaletteTint900Name : ColorFromRGB(0x311B92)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xB388FF),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0x7C4DFF),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0x651FFF),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0x6200EA)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)indigoPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xE8EAF6),
         IDEAPaletteTint100Name : ColorFromRGB(0xC5CAE9),
         IDEAPaletteTint200Name : ColorFromRGB(0x9FA8DA),
         IDEAPaletteTint300Name : ColorFromRGB(0x7986CB),
         IDEAPaletteTint400Name : ColorFromRGB(0x5C6BC0),
         IDEAPaletteTint500Name : ColorFromRGB(0x3F51B5),
         IDEAPaletteTint600Name : ColorFromRGB(0x3949AB),
         IDEAPaletteTint700Name : ColorFromRGB(0x303F9F),
         IDEAPaletteTint800Name : ColorFromRGB(0x283593),
         IDEAPaletteTint900Name : ColorFromRGB(0x1A237E)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0x8C9EFF),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0x536DFE),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0x3D5AFE),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0x304FFE)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)bluePalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xE3F2FD),
         IDEAPaletteTint100Name : ColorFromRGB(0xBBDEFB),
         IDEAPaletteTint200Name : ColorFromRGB(0x90CAF9),
         IDEAPaletteTint300Name : ColorFromRGB(0x64B5F6),
         IDEAPaletteTint400Name : ColorFromRGB(0x42A5F5),
         IDEAPaletteTint500Name : ColorFromRGB(0x2196F3),
         IDEAPaletteTint600Name : ColorFromRGB(0x1E88E5),
         IDEAPaletteTint700Name : ColorFromRGB(0x1976D2),
         IDEAPaletteTint800Name : ColorFromRGB(0x1565C0),
         IDEAPaletteTint900Name : ColorFromRGB(0x0D47A1)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0x82B1FF),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0x448AFF),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0x2979FF),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0x2962FF)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)lightBluePalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xE1F5FE),
         IDEAPaletteTint100Name : ColorFromRGB(0xB3E5FC),
         IDEAPaletteTint200Name : ColorFromRGB(0x81D4FA),
         IDEAPaletteTint300Name : ColorFromRGB(0x4FC3F7),
         IDEAPaletteTint400Name : ColorFromRGB(0x29B6F6),
         IDEAPaletteTint500Name : ColorFromRGB(0x03A9F4),
         IDEAPaletteTint600Name : ColorFromRGB(0x039BE5),
         IDEAPaletteTint700Name : ColorFromRGB(0x0288D1),
         IDEAPaletteTint800Name : ColorFromRGB(0x0277BD),
         IDEAPaletteTint900Name : ColorFromRGB(0x01579B)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0x80D8FF),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0x40C4FF),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0x00B0FF),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0x0091EA)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)cyanPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xE0F7FA),
         IDEAPaletteTint100Name : ColorFromRGB(0xB2EBF2),
         IDEAPaletteTint200Name : ColorFromRGB(0x80DEEA),
         IDEAPaletteTint300Name : ColorFromRGB(0x4DD0E1),
         IDEAPaletteTint400Name : ColorFromRGB(0x26C6DA),
         IDEAPaletteTint500Name : ColorFromRGB(0x00BCD4),
         IDEAPaletteTint600Name : ColorFromRGB(0x00ACC1),
         IDEAPaletteTint700Name : ColorFromRGB(0x0097A7),
         IDEAPaletteTint800Name : ColorFromRGB(0x00838F),
         IDEAPaletteTint900Name : ColorFromRGB(0x006064)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0x84FFFF),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0x18FFFF),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0x00E5FF),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0x00B8D4)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)tealPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xE0F2F1),
         IDEAPaletteTint100Name : ColorFromRGB(0xB2DFDB),
         IDEAPaletteTint200Name : ColorFromRGB(0x80CBC4),
         IDEAPaletteTint300Name : ColorFromRGB(0x4DB6AC),
         IDEAPaletteTint400Name : ColorFromRGB(0x26A69A),
         IDEAPaletteTint500Name : ColorFromRGB(0x009688),
         IDEAPaletteTint600Name : ColorFromRGB(0x00897B),
         IDEAPaletteTint700Name : ColorFromRGB(0x00796B),
         IDEAPaletteTint800Name : ColorFromRGB(0x00695C),
         IDEAPaletteTint900Name : ColorFromRGB(0x004D40)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xA7FFEB),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0x64FFDA),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0x1DE9B6),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0x00BFA5)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)greenPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xE8F5E9),
         IDEAPaletteTint100Name : ColorFromRGB(0xC8E6C9),
         IDEAPaletteTint200Name : ColorFromRGB(0xA5D6A7),
         IDEAPaletteTint300Name : ColorFromRGB(0x81C784),
         IDEAPaletteTint400Name : ColorFromRGB(0x66BB6A),
         IDEAPaletteTint500Name : ColorFromRGB(0x4CAF50),
         IDEAPaletteTint600Name : ColorFromRGB(0x43A047),
         IDEAPaletteTint700Name : ColorFromRGB(0x388E3C),
         IDEAPaletteTint800Name : ColorFromRGB(0x2E7D32),
         IDEAPaletteTint900Name : ColorFromRGB(0x1B5E20)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xB9F6CA),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0x69F0AE),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0x00E676),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0x00C853)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)lightGreenPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name  : ColorFromRGB(0xF1F8E9),
         IDEAPaletteTint100Name : ColorFromRGB(0xDCEDC8),
         IDEAPaletteTint200Name : ColorFromRGB(0xC5E1A5),
         IDEAPaletteTint300Name : ColorFromRGB(0xAED581),
         IDEAPaletteTint400Name : ColorFromRGB(0x9CCC65),
         IDEAPaletteTint500Name : ColorFromRGB(0x8BC34A),
         IDEAPaletteTint600Name : ColorFromRGB(0x7CB342),
         IDEAPaletteTint700Name : ColorFromRGB(0x689F38),
         IDEAPaletteTint800Name : ColorFromRGB(0x558B2F),
         IDEAPaletteTint900Name : ColorFromRGB(0x33691E)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xCCFF90),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xB2FF59),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0x76FF03),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0x64DD17)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)limePalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xF9FBE7),
         IDEAPaletteTint100Name : ColorFromRGB(0xF0F4C3),
         IDEAPaletteTint200Name : ColorFromRGB(0xE6EE9C),
         IDEAPaletteTint300Name : ColorFromRGB(0xDCE775),
         IDEAPaletteTint400Name : ColorFromRGB(0xD4E157),
         IDEAPaletteTint500Name : ColorFromRGB(0xCDDC39),
         IDEAPaletteTint600Name : ColorFromRGB(0xC0CA33),
         IDEAPaletteTint700Name : ColorFromRGB(0xAFB42B),
         IDEAPaletteTint800Name : ColorFromRGB(0x9E9D24),
         IDEAPaletteTint900Name : ColorFromRGB(0x827717)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xF4FF81),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xEEFF41),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0xC6FF00),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0xAEEA00)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)yellowPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xFFFDE7),
         IDEAPaletteTint100Name : ColorFromRGB(0xFFF9C4),
         IDEAPaletteTint200Name : ColorFromRGB(0xFFF59D),
         IDEAPaletteTint300Name : ColorFromRGB(0xFFF176),
         IDEAPaletteTint400Name : ColorFromRGB(0xFFEE58),
         IDEAPaletteTint500Name : ColorFromRGB(0xFFEB3B),
         IDEAPaletteTint600Name : ColorFromRGB(0xFDD835),
         IDEAPaletteTint700Name : ColorFromRGB(0xFBC02D),
         IDEAPaletteTint800Name : ColorFromRGB(0xF9A825),
         IDEAPaletteTint900Name : ColorFromRGB(0xF57F17)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xFFFF8D),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xFFFF00),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0xFFEA00),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0xFFD600)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)amberPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xFFF8E1),
         IDEAPaletteTint100Name : ColorFromRGB(0xFFECB3),
         IDEAPaletteTint200Name : ColorFromRGB(0xFFE082),
         IDEAPaletteTint300Name : ColorFromRGB(0xFFD54F),
         IDEAPaletteTint400Name : ColorFromRGB(0xFFCA28),
         IDEAPaletteTint500Name : ColorFromRGB(0xFFC107),
         IDEAPaletteTint600Name : ColorFromRGB(0xFFB300),
         IDEAPaletteTint700Name : ColorFromRGB(0xFFA000),
         IDEAPaletteTint800Name : ColorFromRGB(0xFF8F00),
         IDEAPaletteTint900Name : ColorFromRGB(0xFF6F00)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xFFE57F),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xFFD740),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0xFFC400),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0xFFAB00)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)orangePalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xFFF3E0),
         IDEAPaletteTint100Name : ColorFromRGB(0xFFE0B2),
         IDEAPaletteTint200Name : ColorFromRGB(0xFFCC80),
         IDEAPaletteTint300Name : ColorFromRGB(0xFFB74D),
         IDEAPaletteTint400Name : ColorFromRGB(0xFFA726),
         IDEAPaletteTint500Name : ColorFromRGB(0xFF9800),
         IDEAPaletteTint600Name : ColorFromRGB(0xFB8C00),
         IDEAPaletteTint700Name : ColorFromRGB(0xF57C00),
         IDEAPaletteTint800Name : ColorFromRGB(0xEF6C00),
         IDEAPaletteTint900Name : ColorFromRGB(0xE65100)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xFFD180),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xFFAB40),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0xFF9100),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0xFF6D00)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)deepOrangePalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xFBE9E7),
         IDEAPaletteTint100Name : ColorFromRGB(0xFFCCBC),
         IDEAPaletteTint200Name : ColorFromRGB(0xFFAB91),
         IDEAPaletteTint300Name : ColorFromRGB(0xFF8A65),
         IDEAPaletteTint400Name : ColorFromRGB(0xFF7043),
         IDEAPaletteTint500Name : ColorFromRGB(0xFF5722),
         IDEAPaletteTint600Name : ColorFromRGB(0xF4511E),
         IDEAPaletteTint700Name : ColorFromRGB(0xE64A19),
         IDEAPaletteTint800Name : ColorFromRGB(0xD84315),
         IDEAPaletteTint900Name : ColorFromRGB(0xBF360C)
      }
                                    accents:@{
                                       IDEAPaletteAccent100Name : ColorFromRGB(0xFF9E80),
                                       IDEAPaletteAccent200Name : ColorFromRGB(0xFF6E40),
                                       IDEAPaletteAccent400Name : ColorFromRGB(0xFF3D00),
                                       IDEAPaletteAccent700Name : ColorFromRGB(0xDD2C00)
                                    }];
   });
   return palette;
}

+ (IDEAPalette *)brownPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xEFEBE9),
         IDEAPaletteTint100Name : ColorFromRGB(0xD7CCC8),
         IDEAPaletteTint200Name : ColorFromRGB(0xBCAAA4),
         IDEAPaletteTint300Name : ColorFromRGB(0xA1887F),
         IDEAPaletteTint400Name : ColorFromRGB(0x8D6E63),
         IDEAPaletteTint500Name : ColorFromRGB(0x795548),
         IDEAPaletteTint600Name : ColorFromRGB(0x6D4C41),
         IDEAPaletteTint700Name : ColorFromRGB(0x5D4037),
         IDEAPaletteTint800Name : ColorFromRGB(0x4E342E),
         IDEAPaletteTint900Name : ColorFromRGB(0x3E2723)
      }
                                    accents:nil];
   });
   return palette;
}

+ (IDEAPalette *)greyPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xFAFAFA),
         IDEAPaletteTint100Name : ColorFromRGB(0xF5F5F5),
         IDEAPaletteTint200Name : ColorFromRGB(0xEEEEEE),
         IDEAPaletteTint300Name : ColorFromRGB(0xE0E0E0),
         IDEAPaletteTint400Name : ColorFromRGB(0xBDBDBD),
         IDEAPaletteTint500Name : ColorFromRGB(0x9E9E9E),
         IDEAPaletteTint600Name : ColorFromRGB(0x757575),
         IDEAPaletteTint700Name : ColorFromRGB(0x616161),
         IDEAPaletteTint800Name : ColorFromRGB(0x424242),
         IDEAPaletteTint900Name : ColorFromRGB(0x212121)
      }
                                    accents:nil];
   });
   return palette;
}

+ (IDEAPalette *)blueGreyPalette {
   static IDEAPalette *palette;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      palette = [[self alloc] initWithTints:@{
         IDEAPaletteTint50Name : ColorFromRGB(0xECEFF1),
         IDEAPaletteTint100Name : ColorFromRGB(0xCFD8DC),
         IDEAPaletteTint200Name : ColorFromRGB(0xB0BEC5),
         IDEAPaletteTint300Name : ColorFromRGB(0x90A4AE),
         IDEAPaletteTint400Name : ColorFromRGB(0x78909C),
         IDEAPaletteTint500Name : ColorFromRGB(0x607D8B),
         IDEAPaletteTint600Name : ColorFromRGB(0x546E7A),
         IDEAPaletteTint700Name : ColorFromRGB(0x455A64),
         IDEAPaletteTint800Name : ColorFromRGB(0x37474F),
         IDEAPaletteTint900Name : ColorFromRGB(0x263238)
      }
                                    accents:nil];
   });
   return palette;
}

+ (instancetype)paletteGeneratedFromColor:(nonnull UIColor *)target500Color {
   NSArray *tintNames = @[
      IDEAPaletteTint50Name, IDEAPaletteTint100Name, IDEAPaletteTint200Name, IDEAPaletteTint300Name,
      IDEAPaletteTint400Name, IDEAPaletteTint500Name, IDEAPaletteTint600Name, IDEAPaletteTint700Name,
      IDEAPaletteTint800Name, IDEAPaletteTint900Name, IDEAPaletteAccent100Name, IDEAPaletteAccent200Name,
      IDEAPaletteAccent400Name, IDEAPaletteAccent700Name
   ];
   
   NSMutableDictionary *tints = [[NSMutableDictionary alloc] init];
   for (IDEAPaletteTint name in tintNames) {
      [tints setObject:IDEAPaletteTintFromTargetColor(target500Color, name) forKey:name];
   }
   
   NSArray *accentNames = @[
      IDEAPaletteAccent100Name, IDEAPaletteAccent200Name, IDEAPaletteAccent400Name,
      IDEAPaletteAccent700Name
   ];
   NSMutableDictionary *accents = [[NSMutableDictionary alloc] init];
   for (IDEAPaletteAccent name in accentNames) {
      [accents setObject:IDEAPaletteAccentFromTargetColor(target500Color, name) forKey:name];
   }
   
   return [self paletteWithTints:tints accents:accents];
}

+ (instancetype)paletteWithTints:(NSDictionary<IDEAPaletteTint, UIColor *> *)tints
                         accents:(NSDictionary<IDEAPaletteAccent, UIColor *> *)accents {
   return [[self alloc] initWithTints:tints accents:accents];
}

- (instancetype)initWithTints:(NSDictionary<IDEAPaletteTint, UIColor *> *)tints
                      accents:(NSDictionary<IDEAPaletteAccent, UIColor *> *)accents {
   self = [super init];
   if (self) {
      _accents = accents ? [accents copy] : @{};
      
      // Check if all the accent colors are present.
      NSDictionary<IDEAPaletteTint, UIColor *> *allTints = tints;
      NSMutableSet<IDEAPaletteAccent> *requiredTintKeys =
      [NSMutableSet setWithSet:[[self class] requiredTintKeys]];
      [requiredTintKeys minusSet:[NSSet setWithArray:[tints allKeys]]];
      if ([requiredTintKeys count] != 0) {
         NSAssert(NO, @"Missing accent colors for the following keys: %@.", requiredTintKeys);
         NSMutableDictionary<IDEAPaletteTint, UIColor *> *replacementTints =
         [NSMutableDictionary dictionaryWithDictionary:_accents];
         for (IDEAPaletteTint tintKey in requiredTintKeys) {
            [replacementTints setObject:UIColor.clearColor forKey:tintKey];
         }
         allTints = replacementTints;
      }
      
      _tints = [allTints copy];
   }
   return self;
}

- (UIColor *)tint50 {
   return _tints[IDEAPaletteTint50Name];
}

- (UIColor *)tint100 {
   return _tints[IDEAPaletteTint100Name];
}

- (UIColor *)tint200 {
   return _tints[IDEAPaletteTint200Name];
}

- (UIColor *)tint300 {
   return _tints[IDEAPaletteTint300Name];
}

- (UIColor *)tint400 {
   return _tints[IDEAPaletteTint400Name];
}

- (UIColor *)tint500 {
   return _tints[IDEAPaletteTint500Name];
}

- (UIColor *)tint600 {
   return _tints[IDEAPaletteTint600Name];
}

- (UIColor *)tint700 {
   return _tints[IDEAPaletteTint700Name];
}

- (UIColor *)tint800 {
   return _tints[IDEAPaletteTint800Name];
}

- (UIColor *)tint900 {
   return _tints[IDEAPaletteTint900Name];
}

- (UIColor *)accent100 {
   return _accents[IDEAPaletteAccent100Name];
}

- (UIColor *)accent200 {
   return _accents[IDEAPaletteAccent200Name];
}

- (UIColor *)accent400 {
   return _accents[IDEAPaletteAccent400Name];
}

- (UIColor *)accent700 {
   return _accents[IDEAPaletteAccent700Name];
}

#pragma mark - Private methods

+ (nonnull NSSet<IDEAPaletteTint> *)requiredTintKeys {
   return [NSSet setWithArray:@[
      IDEAPaletteTint50Name, IDEAPaletteTint100Name, IDEAPaletteTint200Name, IDEAPaletteTint300Name,
      IDEAPaletteTint400Name, IDEAPaletteTint500Name, IDEAPaletteTint600Name, IDEAPaletteTint700Name,
      IDEAPaletteTint800Name, IDEAPaletteTint900Name
   ]];
}

@end
