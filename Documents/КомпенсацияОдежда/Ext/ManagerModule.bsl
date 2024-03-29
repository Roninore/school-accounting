﻿Процедура Печать(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	КомпенсацияОдежда.Ссылка КАК Ссылка,
	|	КомпенсацияОдежда.ВерсияДанных КАК ВерсияДанных,
	|	КомпенсацияОдежда.ПометкаУдаления КАК ПометкаУдаления,
	|	КомпенсацияОдежда.Номер КАК Номер,
	|	КомпенсацияОдежда.Дата КАК Дата,
	|	КомпенсацияОдежда.Проведен КАК Проведен,
	|	КомпенсацияОдежда.МесяцВыплаты КАК МесяцВыплаты,
	|	КомпенсацияОдежда.Обучающиеся.(
	|		Ссылка КАК Ссылка,
	|		НомерСтроки КАК НомерСтроки,
	|		Родитель КАК Родитель,
	|		Родитель.ДатаРождения Как РодительДатаРождения,
	|		Банк КАК Банк,
	|		РасчетныйСчет КАК РасчетныйСчет,
	|		Обучающийся КАК Обучающийся,
	|		Класс КАК Класс,
	|		УдостоверениеМногодетныхНомер КАК УдостоверениеМногодетныхНомер,
	|		СрокДействия КАК СрокДействия,
	|		Сумма КАК Сумма
	|	) КАК Обучающиеся
	|ИЗ
	|	Документ.КомпенсацияОдежда КАК КомпенсацияОдежда
	|ГДЕ
	|	КомпенсацияОдежда.Ссылка В(&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	КомпенсацияОдеждаОбучающиеся.Родитель КАК Родитель
	               |ИЗ
	               |	Документ.КомпенсацияОдежда.Обучающиеся КАК КомпенсацияОдеждаОбучающиеся
	               |ГДЕ
	               |	КомпенсацияОдеждаОбучающиеся.Ссылка В(&Ссылка)
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	КомпенсацияОдеждаОбучающиеся.Родитель
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	КомпенсацияОдеждаОбучающиеся.Родитель.Наименование";
	Родители = Запрос.Выполнить().Выбрать();
	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	
	ОбщееКолвоСтрок = 0;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ПерваяСтрока = ОбщееКолвоСтрок + 4;
		КолвоСтрок = ВыводКомпенсацияОдежда(Выборка,ТабДок,Родители) + ОбщееКолвоСтрок;
		
		ОбъединениеНачало = ПерваяСтрока;
		Флаг = ПерваяСтрока+1 <= КолвоСтрок;
		Для Строка=ПерваяСтрока+1 По КолвоСтрок Цикл
			Если ТабДок.Область("R"+Строка+"C3").Текст="" Тогда
				Продолжить;
			Иначе  
				ТабДок.Область("R"+ОбъединениеНачало+"C1"+":"+"R"+Строка(Строка-1)+"C1").Объединить(); //Номер
				ТабДок.Область("R"+ОбъединениеНачало+"C2"+":"+"R"+Строка(Строка-1)+"C8").Объединить(); //Родитель
				ТабДок.Область("R"+ОбъединениеНачало+"C9"+":"+"R"+Строка(Строка-1)+"C12").Объединить(); //Банк
				ТабДок.Область("R"+ОбъединениеНачало+"C13"+":"+"R"+Строка(Строка-1)+"C18").Объединить(); //Расчетный счет
				ТабДок.Область("R"+ОбъединениеНачало+"C31"+":"+"R"+Строка(Строка-1)+"C32").Объединить(); //Номер удост.
				ТабДок.Область("R"+ОбъединениеНачало+"C33"+":"+"R"+Строка(Строка-1)+"C35").Объединить(); //Срок действия
				ОбъединениеНачало=Строка;
			КонецЕсли;
		КонецЦикла;
		
		Если Флаг Тогда //Объединить для последней строки 
			Строка = Строка - 1;
				ТабДок.Область("R"+ОбъединениеНачало+"C1"+":"+"R"+Строка(Строка-1)+"C1").Объединить(); //Номер
				ТабДок.Область("R"+ОбъединениеНачало+"C2"+":"+"R"+Строка(Строка-1)+"C8").Объединить(); //Родитель
				ТабДок.Область("R"+ОбъединениеНачало+"C9"+":"+"R"+Строка(Строка-1)+"C12").Объединить(); //Банк
				ТабДок.Область("R"+ОбъединениеНачало+"C13"+":"+"R"+Строка(Строка-1)+"C18").Объединить(); //Расчетный счет
				ТабДок.Область("R"+ОбъединениеНачало+"C31"+":"+"R"+Строка(Строка-1)+"C32").Объединить(); //Номер удост.
				ТабДок.Область("R"+ОбъединениеНачало+"C33"+":"+"R"+Строка(Строка-1)+"C35").Объединить(); //Срок действия	
		КонецЕсли;
			
		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;  	
	
КонецПроцедуры 
