
/*
*  回调定义
*
* */

/* int型参数回调 */
typedef TDIntCallBack = Function(int index);
/* string型参数回调*/
typedef TDStringCallBack(String msg);
/* {String,int}参数回调*/
typedef TDStringIntCallBack = Function(String value, int index);
