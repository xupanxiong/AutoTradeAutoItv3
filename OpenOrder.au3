#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         xupanxiong@qq.com
 Create Date:			2014-12-17

 Script Function:
   1���˺������������Ʒ�����ơ����ַ��򡢿����������ڽ��׿ͻ��˽����µ�
   2�����׼۸���ݽ��׿ͻ��˵����¼۸����
   3������Ĭ�Ͻ��׿ͻ����Ѿ���¼����
 Version Information:
   1��2014-12-17 Ver1.0		������������������ַ�������µ�
   2��2014-12-23 Ver2.0		���������Ʒ�֡����ַ��򡢿��ּ۸񡢿������������µ�
 How To Userd:
   1��������Ϊ�Զ��µ�ϵͳ��һ���֣���Ԥ���������Զ���д�µ��ĸ������ݣ�
   2������δ���û�ȷ�ϣ���ֱ���µ���ʹ��ʱ��Ҫ������
#ce ----------------------------------------------------------------------------

#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>
#include <GuiComboBoxEx.au3>
#include <GuiImageList.au3>
#include <MsgBoxConstants.au3>



Func OpenOrder($Variety, $Direction, $OpenPrice, $Hands)

Local $OrderErro = 1;

WinActivate("���������вƽ�ƽ��׿ͻ���")
ControlFocus("���������вƽ�ƽ��׿ͻ���","","[CLASS:Edit; INSTANCE:1]");
ControlSetText("���������вƽ�ƽ��׿ͻ���","","[CLASS:Edit; INSTANCE:1]","��ͨί��");
ControlSend("���������вƽ�ƽ��׿ͻ���","","[CLASS:Edit; INSTANCE:1]","{Enter}");


$hdVariety = ControlGetHandle ("���������вƽ�ƽ��׿ͻ���","��   Լ","[NAME:ksCom_variety_entrust]")
$index = _GUICtrlComboBoxEx_FindStringExact($hdVariety,$Variety)
_GUICtrlComboBoxEx_SetCurSel($hdVariety,$index)

If $Direction ==1 Then
   $hdDirection = ControlGetHandle ("���������вƽ�ƽ��׿ͻ���","��   ��","[CLASS:WindowsForms10.BUTTON.app.0.1e84ccb; INSTANCE:7]")
    _GUICtrlButton_Click($hdDirection)
	$strDirection = "����"
 Else
	If $Direction ==-1 Then
	  $hdDirection = ControlGetHandle ("���������вƽ�ƽ��׿ͻ���","��   ��","[CLASS:WindowsForms10.BUTTON.app.0.1e84ccb; INSTANCE:9]")
	  _GUICtrlButton_Click($hdDirection)
	  $strDirection = "����"
   EndIf
EndIf;

;����
$hdopen = ControlGetHandle ("���������вƽ�ƽ��׿ͻ���","��   ƽ","[CLASS:WindowsForms10.BUTTON.app.0.1e84ccb; INSTANCE:8]")
_GUICtrlButton_Click($hdopen)

$hdprice = ControlGetHandle ("���������вƽ�ƽ��׿ͻ���","��   ��:","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:1]")
$l = 1;
While $l>0
   $l = _GUICtrlEdit_GetTextLen($hdprice)
   ControlFocus("���������вƽ�ƽ��׿ͻ���","��   ��:","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:1]");
   ControlSend("���������вƽ�ƽ��׿ͻ���","��   ��:","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:1]","{BACKSPACE}");
WEnd
_GUICtrlEdit_InsertText($hdprice,$OpenPrice)


$hdhands = ControlGetHandle ("���������вƽ�ƽ��׿ͻ���","��   ��","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:2]")
$l = 1;
While $l>0
   $l = _GUICtrlEdit_GetTextLen($hdhands)
   ControlFocus("���������вƽ�ƽ��׿ͻ���","��   ��","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:2]");
   ControlSend("���������вƽ�ƽ��׿ͻ���","��   ��","[CLASS:WindowsForms10.EDIT.app.0.1e84ccb; INSTANCE:2]","{BACKSPACE}");
   ;ConsoleWrite($l & @Tab)
WEnd
_GUICtrlEdit_InsertText($hdhands,$Hands)

ControlClick("���������вƽ�ƽ��׿ͻ���","�µ�","[CLASS:WindowsForms10.BUTTON.app.0.1e84ccb; INSTANCE:5]","left",40,16);

Sleep(1000)
If WinExists("ί��ȷ��","��Լ") Then
   WinActivate("ί��ȷ��","��Լ")
   $hdOrderText = ControlGetHandle("ί��ȷ��","��Լ","[CLASS:Static; INSTANCE:1]")
   $OrderText = ControlGetText("ί��ȷ��","", $hdOrderText )
   $OrderTip = "ʵ�ʿ�����Ϣ:" &@CRLF &  $OrderText &@CRLF;
   ConsoleWrite($OrderTip)
   ;_FileWriteLog($LogPath & @YEAR &@MON &@MDAY &".log",$OrderTip)

   ;�Ե�����ȷ�Ͽ����ȷ��
   If StringInStr($OrderText,"��Լ��"& $Variety)>0 And StringInStr($OrderText,"�۸�"&$OpenPrice)>0 And _
	  StringInStr($OrderText,"������"&$Hands)>0 And StringInStr($OrderText,$strDirection)>0 And _
	  StringInStr($OrderText,"����")>0 Then

	  ConsoleWrite( $Variety &@TAB & $Direction &@TAB &$OpenPrice&@TAB & $Hands & @CRLF)
	  ConsoleWrite( "�����µ����ݣ�" &$OrderText &@CRLF);
	  Sleep(1000)
	  ControlClick("ί��ȷ��","ȷ��","[CLASS:Button; INSTANCE:1]");
	  $OrderErro = 0;
	  Sleep(1000)

	  If WinExists("��ʾ","ȷ��") Then
		 WinActivate("��ʾ","ȷ��")
		 ControlClick("��ʾ","ȷ��","[CLASS:Button; INSTANCE:1]");
	  EndIf;

	  ControlSetText("���������вƽ�ƽ��׿ͻ���","","[CLASS:Edit; INSTANCE:1]","ί�в�ѯ");
	  ControlSend("���������вƽ�ƽ��׿ͻ���","","[CLASS:Edit; INSTANCE:1]","{Enter}");

	  Return $OrderErro

   Else
	   Sleep(1000)
	   ControlClick("ί��ȷ��","ȡ��","[CLASS:Button; INSTANCE:2]");
	   $OrderErro = 1;
	   Return $OrderErro
   EndIf;
EndIf

Return $OrderErro

EndFunc



