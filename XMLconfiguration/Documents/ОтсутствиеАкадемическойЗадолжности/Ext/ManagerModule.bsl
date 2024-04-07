﻿Процедура Печать(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОтсутствиеАкадемическойЗадолжности.Номер КАК Номер,
	|	ОтсутствиеАкадемическойЗадолжности.Дата КАК Дата,
	|	ОтсутствиеАкадемическойЗадолжности.Обучающийся КАК Обучающийся,
	|	ОтсутствиеАкадемическойЗадолжности.Класс КАК Класс,
	|	ОтсутствиеАкадемическойЗадолжности.КлассныйРуководитель КАК КлассныйРуководитель
	|ИЗ
	|	Документ.ОтсутствиеАкадемическойЗадолжности КАК ОтсутствиеАкадемическойЗадолжности
	|ГДЕ
	|	ОтсутствиеАкадемическойЗадолжности.Ссылка В(&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	
	ЗапросКонстанта = Новый Запрос("Выбрать Константы.РуководительОрганизации Как Объект Из Константы");
	Руководитель = ЗапросКонстанта.Выполнить().Выбрать();
	Если Не Руководитель.Следующий() Тогда
		Сообщить("Ошибка: Не удалось получить данные о руководителе организации");
		Возврат;
    КонецЕсли;
	
	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ВыводОтсутствиеАкадемическойЗадолжности(Выборка,ТабДок,Руководитель.Объект);

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	//}}
КонецПроцедуры 





