
Func ErroLog($TradeType, $HavePostion, $OrderErro,$LogPath,$RecordFilePath,$Tip,$LastDay,$IsModify)

   If $HavePostion == 0	Then
	   If $OrderErro== 0 Then		;�µ���ȷ���޷��ش���
		  _FileCreate($RecordFilePath)
		  FileWriteLine($RecordFilePath, $Tip)
		  $OrderTip = _NowCalc() & " �µ���ȷ��" & @CRLF;
	   ElseIf $OrderErro== 1 Then
		 $OrderTip = _NowCalc()  & " �µ�������~ ���ֶ����� " & @CRLF;
	   EndIf;
	   ConsoleWrite($OrderTip);
	   _FileWriteLog($LogPath & @YEAR &@MON &@MDAY & $TradeType &"Pareto.log", $OrderTip )
   else
		If $OrderErro== 0 Then		;ƽ����ȷ���޷��ش���
		   If $IsModify == 0 Then
			  $HistoryCloseTip = FileReadLine($RecordFilePath)  & @TAB & $Tip;
			  FileWriteLine($HisRecordFilePath, $HistoryCloseTip);
			  _FileCreate($RecordFilePath)
			  $OrderTip = _NowCalc() & " ƽ����ȷ��" & @CRLF;
			Else
				_FileCreate($RecordFilePath)
				FileWriteLine($RecordFilePath, $Tip)
				$OrderTip = _NowCalc() & " ��λ������ȷ��" & @CRLF;
			EndIf;
		 ElseIf $OrderErro== 1 Then
			If $IsModify == 0 Then
			   $OrderTip = _NowCalc() & " ƽ�ֳ�����~ ���ֶ��µ� " & @CRLF;
			Else
			   $OrderTip = _NowCalc() & " ��λ����������~ ���ֶ��µ� " & @CRLF;
			EndIf;
	   EndIf;
	   ConsoleWrite($OrderTip);
	   _FileWriteLog($LogPath & @YEAR &@MON &@MDAY & $TradeType &"Pareto.log", $OrderTip )
   EndIf;

EndFunc;