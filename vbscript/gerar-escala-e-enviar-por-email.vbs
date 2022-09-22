'Autor - Leandro Inacio
'Doc: Monta a escala de N1 de segunda a sexta, de acordo com a quantidade de participantes, de forma aleatoria.
'Obs tecnicas.: Para funcionar o UFT-8, tem que salvar o arquivo com o ENCODING = ANSI
'Requisitos: 
'	- Gerar lista aleatoria com os nomes dos participantes da escala de N1
'	- Gerar a lista dos dia(seg a sexta)/mes de acordo com a quantidade dos participantes. 
'	- Montar o corpo do email com: titulo; descrição; a tabela com os dia/mes - hora - N1.
'	- Mostrar o E-mail criado e enviar.
'TODO: Ajustar a data 



GenerateListNameAndSendEmail()


Function GenerateListNameAndSendEmail()

	Randomize

	Dim ArrayListN1

	ArrayListN1 = GenerateRandomListWithNames()

	SendScaleN1ByEmail ArrayListN1

End Function


'========= function's list names ==================================
Function GenerateRandomListWithNames()
	Dim name, ArrayParticipant, ArrayN1Scale
		ArrayParticipant = Array("Bia","Carla","Lucas","Andre","Leandro","Ana","Julia","Joao","Carlos","Jose")
		ArrayN1Scale = Array()
		
	For Iterator = 1 To UBound(ArrayParticipant) + 1 Step 1
		name = RandItemFromArray(ArrayParticipant)
		AddItemArray ArrayN1Scale, name
		ArrayRemoveVal ArrayParticipant, name
	Next		
	
	GenerateRandomListWithNames = ArrayN1Scale
End Function

Function RandItemFromArray(arr)
	RandItemFromArray= arr(RandomWithinRange(LBound(arr), UBound(arr)))
End Function

Function RandomWithinRange(min, max)
	RandomWithinRange = Int((max - min + 1) * Rnd() + min)
End Function

Function AddItemArray(ByRef arr, ByVal val)
	Redim Preserve arr(UBound(arr) + 1)
	arr(UBound(arr)) = val
	AddItemArray = arr
End Function

Sub ArrayRemoveVal(ByRef arr, ByVal val)
  Dim i, j
  If IsArray(arr) Then
    i = 0 : j = -1
    For i = 0 To UBound(arr)
      If arr(i) <> val Then
        j = j + 1
        arr(j) = arr(i)
      End If
    Next
  ReDim Preserve arr(j)
  End If
End Sub

Sub ReverseArray(ByRef arr)
 
  Dim i, j, last, half, temp
  last = UBound(arr)
  half = Int(last/2)
 
  For i = 0 To half
    temp = arr(i)
    arr(i) = arr(last-i)
    arr(last-i) = temp
  Next
 
End Sub


'========= function's email ==================================
Function SendScaleN1ByEmail(ByRef arrayListN1)
    Dim xOutApp
    Dim xOutMail
    Dim xOutMsg
    On Error Resume Next
    Set xOutApp = CreateObject("Outlook.Application")
    Set xOutMail = xOutApp.CreateItem(0)
	
	Dim numberSprint, initTable, bodyTable, endTable
	numberSprint = "105"
	initTable = "Bom dia, segue abaixo escala de N1:<br><br>"&_
				"<style>"&_
					"table, caption, th, td {border:1px solid black;}"&_
					"caption{background-color: Green; color: white; font-weight:bold}"&_
					"th{background-color: ForestGreen; color: white; font-weight:bold}"&_
				"</style>"&_
				"<table>"&_
					"<caption>Sprint " & numberSprint & "</caption>"&_
					"<tr>"&_
						"<th>Dia</th>"&_
						"<th>Horário</th>"&_
						"<th>N1</th>"&_
					"</tr>"
	endTable = "</table><br>Atenciosamente,<br>Time de Automação."
	
	Dim ArrayListDayAndMonthName
	ArrayListDayAndMonthName = Array()
	ArrayListDayAndMonthName = GetListDayAndMonthName(GetListDaysOfMonth(10))
	
	ReverseArray arrayListN1
	
	ReverseArray ArrayListDayAndMonthName
	
	Dim countDay
	countDay = 0
	For Each name in arrayListN1
		'xOutMsg = "<u> " & GenerateDate() & " | "  & GenerateHour() & " | " & name & "<br>" & xOutMsg & "</u>"
	
		bodyTable = "<tr>"&_
						"<td>"& ArrayListDayAndMonthName(countDay) &"</td>"&_
						"<td>"& GetHour() &"</td>"&_
						"<td>"& name &"</td>"&_
					"</tr>" & bodyTable
			
			
		countDay = countDay +1
	Next
	
	xOutMsg = initTable & bodyTable & endTable
	With xOutMail
        .To = "@email.com"
        .CC = ""
        .BCC = ""
        .Subject = "Time de Automação"
        .HTMLBody = xOutMsg
        .Display  '= Mostra a mensagem antes de enviar
		'.Send	'=envia a mensagem
    End With
	
	'WScript.Sleep 3000
	
	Dim rtmsg
    If Err.Number <> 0 Then
        rtmsg = "ERROR " & Err.Number & ": " & Err.Description
    Else
        rtmsg = "Email enviado com sucesso!"
    End If
	
	MsgBox(rtmsg)
	
    Set xOutMail = Nothing
    Set xOutApp = Nothing
	Set xOutMsg = Nothing
End Function

Function GetListDayAndMonthName(ByRef arrayListDaysOfMonth )
	Dim ArrayListDayAndMonthName, currentDayAndMonthName, currentMonthName
	ArrayListDayAndMonthName = Array()
	
	currentMonthName = GetMonthName()
	
	For Each foundDay in arrayListDaysOfMonth
		currentDayAndMonthName = CStr(foundDay) &"/"& currentMonthName
		AddItemArray ArrayListDayAndMonthName, currentDayAndMonthName
    Next

	'GetListDayAndMonthName = " 09:00 às 18:00 "
	GetListDayAndMonthName = ArrayListDayAndMonthName
	
End Function

Function GetHour()
	GetHour = " 09:00 às 18:00 "
End Function

Function GetListDaysOfMonth(ByVal numberParticipant)

	Dim currentDay, currentYear, currentMonth, currentWeekDay, foundDay
	Dim ArrayParticipant, ArrayListDaysOfMonth
	
	ArrayParticipant = Array("Neemias","Cecília","Fábio","Jadeilson","Leandro","Sidne","Danilo","Vinícius","Jean","Sthefany")
	ArrayListDaysOfMonth = Array()
	
	currentDate = GetDate()
	currentWeekDay = Weekday(currentDate, vbSunday)
	currentYear = GetYear(currentDate)
	currentMonth = GetMonth(currentDate) 
	currentDay = GetDay(currentDate)
	
	Dim bool : bool = false
	For Iterator = 1 To numberParticipant Step 1
				
		Do
			If currentWeekDay = 7 Then 'sabado
				currentWeekDay = 2
				currentDay = currentDay +2
				'currentDate = DateAdd("d",2,currentDate)
				currentDate = DateSerial(currentYear,currentMonth,currentDay)
				'currentDay = currentDay +2
			ElseIf currentWeekDay = 1 Then 'domingo
				currentWeekDay = 2
				currentDay = currentDay +1
				'currentDate = DateAdd("d",1,currentDate)
				currentDate = DateSerial(currentYear,currentMonth,currentDay)
				'currentDay = currentDay +1
			Else 'seg a sex
				currentDay = currentDay
				bool = True
				Exit Do
			End If
			
		Loop While bool = False
		foundDay = GetDay(currentDate)
		AddItemArray ArrayListDaysOfMonth, foundDay
		currentDay = currentDay + 1
		currentDate = DateSerial(currentYear,currentMonth,currentDay)
		'currentDay = currentDay + 1
		currentWeekDay = currentWeekDay +1
	Next			
	
	'MsgBox Join(ArrayListDaysOfMonth, vbNewLine)

	GetListDaysOfMonth = ArrayListDaysOfMonth
	
End Function

Function GetDate()
	
	Dim currentDate
	
	currentDate = Date()
		
	'GetDate = CStr(currentDay) & "/" & CStr(currentMonth) 'Padrao: " 29/ago "
	
	GetDate = currentDate
	
End Function

Function GetMonthName()
		
	GetMonthName = MonthName(Month(Now), True)

End Function

Function GetYear(ByVal currentDate)
	
	GetYear = Year(currentDate)
	
End Function

Function GetMonth(ByVal currentDate)
	
	GetMonth = Month(currentDate)
	
End Function

Function GetDay(ByVal currentDate)
	
	GetDay = Day(currentDate)
	
End Function

Function GetDay(ByVal currentDate)
	
	GetDay = Day(currentDate)
	
End Function

