/* 我的优惠券 */
import 'package:date_format/date_format.dart';
import 'package:demo/common/common.dart';

class MyCouponBean {
  String id;
  String userId;
  String couponItemId;
  String startTime;
  String endTime;
  String money;
  String status;
  String createAt;
  CouponInfoBean info;

  MyCouponBean(this.id, this.userId, this.couponItemId, this.startTime,
      this.endTime, this.money, this.status, this.createAt, this.info
  );

  factory MyCouponBean.fromJson(Map<String, dynamic> json) {

    var endTime = (int.parse(json['end_time'].toString()) ?? 0)*1000;
    var time = DateTime.fromMillisecondsSinceEpoch(endTime);
    String endTimeStr = formatDate(time, [yyyy,'/',mm,'/',dd, ' ', HH,':',nn]);

    return MyCouponBean(
        json['id'],
        json['user_id'],
        json['coupon_item_id'],
        json['start_time'],
        endTimeStr,
        json['money'],
        json['status'],
        json['create_at'],
        CouponInfoBean.fromJson(json['coupon_info'])
    );
  }
}

class CouponInfoBean {
  String id;
  String title;
  String notes;
  String money;
  String couponGroupId;
  String suitIds;

  CouponInfoBean(this.id, this.title, this.notes, this.money,
      this.couponGroupId, this.suitIds);

  factory CouponInfoBean.fromJson(Map<String, dynamic> json) {
    return CouponInfoBean(json['id'], json['title'], json['notes'],
        json['money'], json['coupon_group_id'], json['suit_ids']);
  }
}
