﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ТабДок = Новый ТабличныйДокумент;
	Имя = Экспортировать(ТабДок, ПараметрКоманды);

	ТабДок.ОтображатьСетку = Ложь;
	ТабДок.Защита = Ложь;
	ТабДок.ТолькоПросмотр = Ложь;
	ТабДок.ОтображатьЗаголовки = Ложь; 	
	
	П = Новый Структура;
	П.Вставить("Таблица",ТабДок);
	П.Вставить("Имя",Имя);
	
	ОткрытьФорму("Документ.ЕГИССО.Форма.ФормаЭкспорта",П);
КонецПроцедуры

&НаСервере
Функция Экспортировать(ТабДок, ПараметрКоманды)
	Имя = Документы.ЕГИССО.Экспортировать(ТабДок, ПараметрКоманды);
	Возврат Имя;
КонецФункции
