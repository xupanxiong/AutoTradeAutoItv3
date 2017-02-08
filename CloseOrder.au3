#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         xupanxiong@qq.com
 Create Date:			 2014-12-17

 Script Function:
   1、此函数根据输入的品种名称、开仓方向、开仓手数，在交易客户端进行下单
   2、交易价格根据交易客户端的最新价格而定
   3、函数默认交易客户端已经登录开启
 Version Information:
   1、2014-12-17 Ver1.0		根据输入的手数、开仓方向进行下单
   2、2014-12-17 Ver2.0		添加末尾对平仓单元的确认部分
 How To Userd:
   1、函数做为自动下单系统的一部分，在预警发生后自动填写下单的各种数据，
   2、函数未经用户确认直接平仓，使用时需要谨慎。
#ce ----------------------------------------------------------------------------

#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>
#include <GuiComboBoxEx.au3>
#include <GuiImageList.au3>
#include <MsgBoxConstants.au3>



Func CloseOrder($Variety, $Direction, $ClosePrice, $Hands)

Local $OrderErro = 1;

WinActivate("招商银行招财金黄金交易客户端")
ControlFocus("招商银行招财金黄金交易客户端","","[CLASS:Edit; INSTANCE:1]");
ControlSetText("招商银行招财金黄金交易客户端","","[CLASS:Edit; INSTANCE:1]","普通委托");
ControlSend("招商银行招财金黄金交易客户端","","[CLASS:Edit; INSTANCE:1]","{Enter}");


$hdVariety = ControlGetHandle ("招商银行招财金黄金交易客户端","合   约","[NAME:ksCom_variety_entrust]")
$index = _GUICtrlComboBoxEx_FindStringExact($hdVariety,$Variety)
_GUICtrlComboBoxEx_SetCurSel($hdVariety,$index)

If $Direction ==1 Then
   $hdDirection = ControlGetHandle ("招商银行招财金黄金交易客户端","买   卖","[Class:WindowsForms10.BUTTON.app.0.1e84ccb; INSTANCE:7]")
	_GUICtrlButton_Click($hdDirection)
	$strDirection = "买入"
 Else
	If $Direction ==-1 Then
	  $hdDirection = ControlGetHandle ("招商银行招财金黄金交易客户端","买   卖","[CLASS:WindowsForms10.BUTTON.app.0.1e84ccb; INSTANCE:9]")
	  _GUICtrlButton_Click($hdDirection)
	  $strDirection = "卖出"
   EndIf
EndIf;

;平仓
$hdClose = ControlGetHandle ("招商银行招财金黄金交易客户端","开   平","[CLASS:WindowsForms10.BUTTON.app.0.1e84ccb; INSTANCE:6]")
_GUICtrlButton_Click($hdClose)

$hdprice = ControlGetHandle ("招商银行招财金黄金交易客户端","价   格:","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:1]")
$l = 1;
While $l>0
   $l = _GUICtrlEdit_GetTextLen($hdprice)
   ControlFocus("招商银行招财金黄金交易客户端","价   格:","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:1]");
   ControlSend("招商银行招财金黄金交易客户端","价   格:","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:1]","{BACKSPACE}");
WEnd
_GUICtrlEdit_InsertText($hdprice,$ClosePrice)


$hdhands = ControlGetHandle ("招商银行招财金黄金交易客户端","数   量","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:2]")
$l = 1;
While $l>0
   $l = _GUICtrlEdit_GetTextLen($hdhands)
   ControlFocus("招商银行招财金黄金交易客户端","数   量","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:2]");
   ControlSend("招商银行招财金黄金交易客户端","数   量","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:2]","{BACKSPACE}");
   ;ConsoleWrite($l & @Tab)
WEnd
_GUICtrlEdit_InsertText($hdhands,$Hands)

ControlClick("招商银行招财金黄金交易客户端","下单","[CLASS:WindowsForms10.BUTTON.app.0.1e84ccb; INSTANCE:5]","left");

Sleep(1000)
If WinExists("委托确认","合约") Then
   WinActivate("委托确认","合约")
   $hdOrderText = ControlGetHandle("委托确认","合约","[CLASS:Static; INSTANCE:1]")
   $OrderText = ControlGetText("委托确认","", $hdOrderText )
   $OrderTip = "实际平仓信息:" &@CRLF &  $OrderText &@CRLF;
   ConsoleWrite($OrderTip)
   _FileWriteLog($LogPath & @YEAR &@MON &@MDAY &".log",$OrderTip)

   ;对弹出的确认框进行确认
   If StringInStr($OrderText,"合约："& $Variety)>0 And StringInStr($OrderText,"价格："&$ClosePrice)>0 And _
	  StringInStr($OrderText,"数量："&$Hands)>0 And StringInStr($OrderText,$strDirection)>0 And _
	  StringInStr($OrderText,"平仓")>0 Then

	  ConsoleWrite( $Variety &@TAB & $Direction &@TAB &$ClosePrice&@TAB & $Hands & @CRLF)
	  ConsoleWrite( "平仓下单数据：" &$OrderText &@CRLF);
	  Sleep(1000)
	  ControlClick("委托确认","确定","[CLASS:Button; INSTANCE:1]");
	  $OrderErro = 0;
	  Sleep(1000)

	  If WinExists("提示","确定") Then
		 WinActivate("提示","确定")
		 ControlClick("提示","确定","[CLASS:Button; INSTANCE:1]");
	  EndIf;

	  ControlSetText("招商银行招财金黄金交易客户端","","[CLASS:Edit; INSTANCE:1]","委托查询");
	  ControlSend("招商银行招财金黄金交易客户端","","[CLASS:Edit; INSTANCE:1]","{Enter}");

	  Return $OrderErro

   Else
	   Sleep(1000)
	   ControlClick("委托确认","取消","[CLASS:Button; INSTANCE:2]");
	   $OrderErro = 1;
	   Return $OrderErro
   EndIf;
EndIf

Return $OrderErro

EndFunc



