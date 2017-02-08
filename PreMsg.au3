#include-once
#include<File.au3>

Func PreCloseMsg($TodDayNum,  $TradeType, $HoldDirection, $AuTDCurrPrice, $HoldHands, $HoldOpenPrice, $TimeStap)
	$EarnMoney = Round(($AuTDCurrPrice - $HoldOpenPrice)*$HoldDirection*100/$HoldOpenPrice,2)
	$CloseTip = $TodDayNum& @TAB &$TradeType &@TAB & ($HoldDirection*(-1)) &@TAB &$AuTDCurrPrice &@TAB &$HoldHands &@TAB &$TimeStap &@TAB &$EarnMoney ;
	$Tip = "拟平仓信息：" & @CRLF & $CloseTip &@CRLF ;
	ConsoleWrite($Tip )
	_FileWriteLog($LogPath & @YEAR &@MON &@MDAY & $TradeType &"Pareto.log", $Tip )
	Return $CloseTip
EndFunc;


Func PreOpenMsg($TradeType, $IsTrendTrade, $TodDayNum, $AuTDOpenPrice, $NewDirection, $OpenHands, $StoPrice, $TimeStap)
	$OpenTip = $TradeType& @TAB &$IsTrendTrade &@TAB & $TodDayNum &@TAB &$AuTDOpenPrice &@TAB &$NewDirection &@TAB &$OpenHands &@TAB &$StoPrice &@TAB &$TimeStap ;
	$Tip = "拟开仓信息：" & @CRLF & $OpenTip &@CRLF ;
	ConsoleWrite($Tip )
	_FileWriteLog($LogPath & @YEAR &@MON &@MDAY & $TradeType &"Pareto.log", $Tip)
	Return $OpenTip
 EndFunc;


 Func ModifyOpen($RecordFilePath,$IsTrendTrade)
	$Tip = FileReadLine($RecordFilePath);
	$MTip = StringReplace($Tip,9,$IsTrendTrade);
	_FileCreate($RecordFilePath)
    FileWriteLine($RecordFilePath, $MTip)
 EndFunc;
