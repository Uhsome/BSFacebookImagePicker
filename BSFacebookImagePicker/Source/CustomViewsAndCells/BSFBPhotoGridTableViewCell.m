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

#import "BSFBPhotoGridTableViewCell.h"
#import "AFNetworking.h"
#import "BSFBImageCropViewController.h"

static CGFloat kThumbnailLength = 75;
static CGFloat kThumbnailMargin = 4;

@implementation BSFBPhotoGridTableViewCell
@synthesize navigationController;
@synthesize delegate;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)didAddImages:(NSArray*)images {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _imageViews = [[NSMutableArray alloc] initWithCapacity:4];
    for (int c = 0; c < images.count ;c++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kThumbnailMargin*(c+1)) + (kThumbnailLength*c), 2, kThumbnailLength, kThumbnailLength)];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:imageView];
        imageView.tag = c;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPressed:)];
        tap.delegate = self;
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        [_imageViews addObject:imageView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImages:(NSArray *)images {
  _images = images;
  [self didAddImages:images];
  for (int c = 0; c < images.count; c++) {
    [_imageViews[c] setImageWithURL:[NSURL URLWithString:images[c][@"picture"]]];
  }
}

- (void) imageViewPressed:(UITapGestureRecognizer *)recoginizer {
  NSUInteger index = recoginizer.view.tag;
  if (index < _images.count) {
    NSDictionary *photo = _images[recoginizer.view.tag];
    [self.delegate facebookPhotoGridTableViewCell:self didSelectPhoto:photo withPreviewImage:[(UIImageView *)recoginizer.view image]];
  }
}




@end
