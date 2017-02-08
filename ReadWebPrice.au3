#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         xupanxiong@qq.com
 Create Date:			2015-01-07

 Script Function:
   1���˽ű�����Զ����ֽű�,����������ҳ������۸�
 Version Information:
   1��2015-01-08 Ver1.0		�ű��ṩ������۸���ҳ�ļ۸��ȡ���ܣ�����ʱ��ء�ǰ���̼ۡ���ǰ�۵���Ϣ
 How To Userd:
   1����������ҳ�ַ�����ʱ��أ�ǰ���̼ۣ���ǰ�ۣ���ȡ����
   2������һ�����������һ������Ϊֵ�����⣬��������Ϊ��ַ����
   3���������ص�ǰ�۸�ı䶯����
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
