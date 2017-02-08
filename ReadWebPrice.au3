#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         xupanxiong@qq.com
 Create Date:			2015-01-07

 Script Function:
   1、此脚本针对自动开仓脚本,读出所给网页的行情价格
 Version Information:
   1、2015-01-08 Ver1.0		脚本提供对行情价格网页的价格读取功能，包括时间截、前收盘价、当前价等信息
 How To Userd:
   1、参数：网页字符串，时间截，前收盘价，当前价，读取精度
   2、除第一个参数与最后一个参数为值传递外，其他参数为地址传递
   3、函数返回当前价格的变动幅度
#ce ----------------------------------------------------------------------------

#include <Array.au3>

Func ReadWebPrice($sHTML, ByRef $TimeStap, ByRef $PreClosePrice,  ByRef $CurrPrice, $Accuracy)

   Local $aArray = 0, _
			  $iOffset = 1, _
			  $PriceCount = 0, _
			  $b=0, $s=0
   While True
	   $aArray = StringRegExp($sHTML, '(?i)<td>(.*?)</td>', $STR_REGEXPARRAYMATCH, $iOffset)
	   If @error Then ExitLoop
	   $iOffset = @extended
	   For $i = 0 To UBound($aArray) - 1
		   if $PriceCount == 2 Then
			   $PreClosePrice = $aArray[$i];
			EndIf

			If $PriceCount == 3 Then
			   $b= $aArray[$i];
			EndIf

			If $PriceCount == 4 Then
			   $s= $aArray[$i];
			EndIf

			If $PriceCount == 7 Then
			   $TimeStap= $aArray[$i];
			EndIf

		Next
		$PriceCount = $PriceCount+1;
   WEnd

   $CurrPrice = Round(($b+$s)/2, $Accuracy);
   $Chg = ($CurrPrice - $PreClosePrice)/$PreClosePrice *100 ;

   Return $Chg

EndFunc
