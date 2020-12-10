
/* 角色 类型*/
enum JJRoleType {
  unknown,
  matron,
  nurse,
}

/* 值 转 枚举 */
JJRoleType jjRoleType(int value) {
  return JJRoleType.values.firstWhere((element) => element.index == value);
}