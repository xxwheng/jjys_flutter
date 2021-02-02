//
//  NSString+MatronLevel.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2016/11/24.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "NSString+MatronLevel.h"

@implementation NSString (MatronLevel)

- (NSString *)matronLevel{
	MatronLevel yuesaoLevel = self.integerValue;
	switch (yuesaoLevel) {
		case MatronLevelLV1:{
	  return @"一星月嫂";
  }
  case MatronLevelLV2:{
	  return @"二星月嫂";
  }

  case MatronLevelLV3:{
	  return @"三星月嫂";
  }
			break;
  case MatronLevelLV4:{
	  return @"四星月嫂";
  }
			break;
  case MatronLevelLV5:{
	  return @"五星月嫂";
  }
			break;
  case MatronLevelLV6:{
	  return @"六星月嫂";
  }
			break;
  case MatronLevelGoldBrand:{
	  return @"金牌月嫂";
  }
			break;

		case MatronLevelHouseKeeper: {
			return @"月子管家";
		}
		break;

		case MatronLevelBronzeMedalHouseKeeper:{
	  return @"铜牌月子管家";
  }
			break;
  case MatronLevelSilverMedalHouseKeeper:{
	  return @"银牌月子管家";
  }
			break;
  case MatronLevelGoldMedalHouseKeeper:{
	  return @"金牌月子管家";
  }
			break;
  default:
			return [NSString stringWithFormat:@"%ld星",yuesaoLevel];
			break;
	}
	return nil;
}

- (NSString *)levelLabelText {
	MatronLevel level = self.integerValue;
	switch (level) {
		case MatronLevelLV1: return @"一星月嫂"; break;
		case MatronLevelLV2: return @"二星月嫂"; break;
		case MatronLevelLV3: return @"三星月嫂"; break;
		case MatronLevelLV4: return @"四星月嫂"; break;
		case MatronLevelLV5: return @"五星月嫂"; break;
		case MatronLevelLV6: return @"六星月嫂"; break;
		case MatronLevelGoldBrand: return @"金牌月嫂"; break;
		case MatronLevelHouseKeeper: return @"月子管家"; break;
		case MatronLevelBronzeMedalHouseKeeper: return @"铜牌月子管家"; break;
		case MatronLevelGoldMedalHouseKeeper: return @"银牌月子管家"; break;
		case MatronLevelSilverMedalHouseKeeper: return @"金牌月子管家"; break;
		default: return @""; break;
	}
}

- (UIImage *)levelLabelImage{
	MatronLevel level = self.integerValue;
	switch (level) {
		case MatronLevelLV1: {
			return [UIImage imageNamed:@"Label_LV1"];
		}
			break;

		case MatronLevelLV2: {
			return [UIImage imageNamed:@"Label_LV2"];
		}
			break;


		case MatronLevelLV3: {
			return   [UIImage imageNamed:@"Label_LV3"];
		}
			break;

		case MatronLevelLV4: {
			return   [UIImage imageNamed:@"Label_LV4"];
		}
			break;

		case MatronLevelLV5: {
			return  [UIImage imageNamed:@"Label_LV5"];
		}
			break;

		case MatronLevelLV6: {
			return  [UIImage imageNamed:@"Label_LV6"];
		}
			break;

		case MatronLevelGoldBrand: {
		return   [UIImage imageNamed:@"Label_gold"];
		}
			break;

		case MatronLevelHouseKeeper: {
			return [UIImage imageNamed:@"Label_LV8"];
		}
			break;
		case MatronLevelBronzeMedalHouseKeeper:{
	  return  [UIImage imageNamed:@"Label_LV11"];
  }
			break;
  case MatronLevelSilverMedalHouseKeeper:{
	  return  [UIImage imageNamed:@"Label_LV12"];
  }
			break;
  case MatronLevelGoldMedalHouseKeeper:{
	  return  [UIImage imageNamed:@"Label_LV13"];
  }
			break;

		default:
			return [UIImage imageNamed:@"Label_gold"];
			break;
	}
}


- (UIImage *)levelStarImage{
	MatronLevel  level = self.integerValue;
	switch (level) {
		case MatronLevelLV1: {
			return [UIImage imageNamed:@"1xing"];
			break;
		}
		case MatronLevelLV2: {
			return [UIImage imageNamed:@"2xing"];
			break;
		}

		case MatronLevelLV3: {
			return [UIImage imageNamed:@"3xing"];
			break;
		}
		case MatronLevelLV4: {
			return [UIImage imageNamed:@"4xing"];
			break;
		}
		case MatronLevelLV5: {
			return [UIImage imageNamed:@"5xing"];
			break;
		}
		case MatronLevelLV6: {
			return [UIImage imageNamed:@"6xing"];
			break;
		}
		case MatronLevelGoldBrand: {
			return [UIImage imageNamed:@"goldBrandXing"];
			break;
		}
		case MatronLevelHouseKeeper: {
			return [UIImage imageNamed:@"8xing"];
			break;
		}
		case MatronLevelBronzeMedalHouseKeeper:{
	  return  [UIImage imageNamed:@"11xing"];
  }
			break;
  case MatronLevelSilverMedalHouseKeeper:{
	  return  [UIImage imageNamed:@"12xing"];
  }
			break;
  case MatronLevelGoldMedalHouseKeeper:{
	  return  [UIImage imageNamed:@"13xing"];
  }
		default:
			return [UIImage imageNamed:@"goldBrandXing"];
			break;
	}
}


- (NSString *)yuYingLevel{
	YuyingLevel level = self.integerValue;
	switch (level) {
  case YuyingLevelPrimaryStage:{
	return @"初级";
  }
			break;
		case YuyingLevelMidStage:{
    return @"中级";
  }
			break;
  case YuyingLevelHighStage:{
    return @"高级";
  }
			break;
  case YuyingLevelStarStage:{
    return @"星级";
  }
			break;
  case YuyingLevelGoldBrandStage:{
	return @"金牌";
  }
			break;
  default:
			return @"金牌";
			break;
	}
}

- (NSString *)yuYingLevelLabelText: (NSString *)careType {
	YuyingLevel level = self.integerValue;
	NSString *text = @"";
	switch (level) {
		case YuyingLevelSecondStage: text = @"二星"; break;
		case YuyingLevelPrimaryStage: text = @"三星"; break;
		case YuyingLevelMidStage: text = @"四星"; break;
		case YuyingLevelHighStage: text = @"五星"; break;
		case YuyingLevelStarStage: text = @"六星"; break;
		case YuyingLevelGoldBrandStage: text = @"金牌"; break;
		default: break;
	}
	if ([careType isEqualToString:@"1"]) {
		text = [NSString stringWithFormat:@"%@育婴护理师", text];
	} else  if ([careType isEqualToString:@"2"]) {
		text = [NSString stringWithFormat:@"%@育儿护理师", text];
	} else if ([careType isEqualToString:@"3"]) {
		text = [NSString stringWithFormat:@"%@幼儿护理师", text];
	} else {
		text = [NSString stringWithFormat:@"%@育婴师", text];
	}
	return text;
}

- (UIImage *)yuYingLabelImage{
	YuyingLevel level = self.integerValue;
	switch (level) {
  case YuyingLevelPrimaryStage:{
	  return [UIImage imageNamed:@"yuying_label_three"];
  }
			break;
		case YuyingLevelMidStage:{
			return [UIImage imageNamed:@"yuying_label_four"];
  }
			break;
  case YuyingLevelHighStage:{
	  return [UIImage imageNamed:@"yuying_label_five"];
  }
			break;
  case YuyingLevelStarStage:{
	  return[UIImage imageNamed:@"yuying_label_six"];
  }
			break;
  case YuyingLevelGoldBrandStage:{
	  return [UIImage imageNamed:@"yuying_label_gold"];
  }
			break;
  default:
			return [UIImage imageNamed:@"yuying_label_gold"];
			break;
	}
}


- (UIImage *)yuYingStarImage{
	YuyingLevel level = self.integerValue;
	switch (level) {
  case YuyingLevelPrimaryStage:{
	  return [UIImage imageNamed:@"yuying_xing_three"];
  }
			break;
		case YuyingLevelMidStage:{
			return [UIImage imageNamed:@"yuying_xing_four"];
  }
			break;
  case YuyingLevelHighStage:{
	  return [UIImage imageNamed:@"yuying_xing_five"];
  }
			break;
  case YuyingLevelStarStage:{
	  return[UIImage imageNamed:@"yuying_xing_six"];
  }
			break;
  case YuyingLevelGoldBrandStage:{
	  return [UIImage imageNamed:@"yuying_xing_gold"];
  }
			break;
  default:
			return [UIImage imageNamed:@"yuying_xing_gold"];
			break;
	}
}

@end
