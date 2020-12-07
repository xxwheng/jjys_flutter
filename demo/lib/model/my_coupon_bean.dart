/* 我的优惠券 */
class MyCouponBean {
  String id;
  String userId;
  String couponItemId;
  String startTime;
  String endTime;
  String money;
  String status;
  String createAt;

  MyCouponBean(this.id, this.userId, this.couponItemId, this.startTime,
      this.endTime, this.money, this.status, this.createAt);

  factory MyCouponBean.fromJson(Map<String, dynamic> json) {
    return MyCouponBean(
        json['id'],
        json['user_id'],
        json['coupon_item_id'],
        json['start_time'],
        json['end_time'],
        json['money'],
        json['status'],
        json['create_at']);
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
