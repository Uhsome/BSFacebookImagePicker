/*
 * Copyright 2013 Brad Smith
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "BSFBEmptyView.h"

static NSString *emptyStateImageName = @"BSFBAlbumPicker.bundle/blankslatePhotos";


@interface BSFBEmptyView (/* private */) {
  UIImageView *imageView;
  UILabel *label;
}
@end



@implementation BSFBEmptyView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      self.backgroundColor = [UIColor colorWithRed:236/255.0 green:238/255.0 blue:248/255.0 alpha:1.0];
      [self setupImageView];
      [self setupLabel];
    }
    return self;
}


- (void) setupImageView {
  imageView = [[UIImageView alloc] init];
  imageView.contentMode = UIViewContentModeCenter;
  imageView.image = [UIImage imageNamed:emptyStateImageName];
  [imageView sizeToFit];
  [self addSubview:imageView];
}


- (void) setupLabel {
  label = [[UILabel alloc] init];
  label.backgroundColor = self.backgroundColor;
  label.font = [UIFont boldSystemFontOfSize:22];
  label.textColor = [UIColor colorWithRed:173/255.0 green:174/255.0 blue:189/255.0 alpha:1.0];
  label.text = Localized(@"NO_PHOTOS_TO_SHOW");
  [label sizeToFit];
  [self addSubview:label];
}


-(void) layoutSubviews {
  imageView.center = CGPointMake(self.center.x, self.center.y - 22);
  label.center = CGPointMake(imageView.center.x, imageView.center.y + (imageView.bounds.size.height * 0.5) + (label.bounds.size.height * 0.5) + 17);
}

@end