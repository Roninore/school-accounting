﻿Процедура вПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)

СтандартнаяОбработка = Ложь;

Настройки = КомпоновщикНастроек.Настройки;

ДанныеРасшифровки = Новый ДанныеРасшифровкиКомпоновкиДанных;

КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);

ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
ПроцессорКомпоновки.Инициализировать(МакетКомпоновки,,ДанныеРасшифровки);

ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
ПроцессорВывода.УстановитьДокумент(ДокументРезультат);

ПроцессорВывода.НачатьВывод();

ВыведенаШапка = Ложь;
ДокументРезультат.ФиксацияСлева = 1;

ЭлементРезультата = ПроцессорКомпоновки.Следующий();

Пока Не ЭлементРезультата = Неопределено Цикл
Если Не ВыведенаШапка И ЭлементРезультата.ЗначенияПараметров.Количество() > 0 Тогда
ВыведенаШапка = Истина;
ДокументРезультат.ФиксацияСверху = ДокументРезультат.ВысотаТаблицы;
КонецЕсли;


ПроцессорВывода.ВывестиЭлемент(ЭлементРезультата);
ЭлементРезультата = ПроцессорКомпоновки.Следующий();
КонецЦикла;

ПроцессорВывода.ЗакончитьВывод();

//Изменение макета оформления

ТабличныйДокумент = ДокументРезультат;

УдаляемаяОбласть = ТабличныйДокумент.Область("R5");
ТабличныйДокумент.УдалитьОбласть(УдаляемаяОбласть, ТипСмещенияТабличногоДокумента.ПоГоризонтали);


КонецПроцедуры

