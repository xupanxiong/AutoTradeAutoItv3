
Func ErroLog($TradeType, $HavePostion, $OrderErro,$LogPath,$RecordFilePath,$Tip,$LastDay,$IsModify)

   If $HavePostion == 0	Then
	   If $OrderErro== 0 Then		;下单正确，无返回错误
		  _FileCreate($RecordFilePath)
		  FileWriteLine($RecordFilePath, $Tip)
		  $OrderTip = _NowCalc() & " 下单正确。" & @CRLF;
	   ElseIf $OrderErro== 1 Then
		 $OrderTip = _NowCalc()  & " 下单出错啦~ 请手动操作 " & @CRLF;
	   EndIf;
	   ConsoleWrite($OrderTip);
	   _FileWriteLog($LogPath & @YEAR &@MON &@MDAY & $TradeType &"Pareto.log", $OrderTip )
   else
		If $OrderErro== 0 Then		;平仓正确，无返回错误
		   If $IsModify == 0 Then
			  $HistoryCloseTip = FileReadLine($RecordFilePath)  & @TAB & $Tip;
			  FileWriteLine($HisRecordFilePath, $HistoryCloseTip);
			  _FileCreate($RecordFilePath)
			  $OrderTip = _NowCalc() & " 平仓正确。" & @CRLF;
			Else
				_FileCreate($RecordFilePath)
				FileWriteLine($RecordFilePath, $Tip)
				$OrderTip = _NowCalc() & " 仓位调整正确。" & @CRLF;
			EndIf;
		 ElseIf $OrderErro== 1 Then
			If $IsModify == 0 Then
			   $OrderTip = _NowCalc() & " 平仓出错啦~ 请手动下单 " & @CRLF;
			Else
			   $OrderTip = _NowCalc() & " 仓位调整出错啦~ 请手动下单 " & @CRLF;
			EndIf;
	   EndIf;
	   ConsoleWrite($OrderTip);
	   _FileWriteLog($LogPath & @YEAR &@MON &@MDAY & $TradeType &"Pareto.log", $OrderTip )
   EndIf;

EndFunc;