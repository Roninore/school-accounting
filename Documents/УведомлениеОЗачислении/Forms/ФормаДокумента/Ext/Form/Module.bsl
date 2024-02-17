﻿


&НаСервере
Функция ЗагрузитьАктуальныйПриказ(Ссылка)
	Отбор = Новый Структура("Обучающийся", Ссылка);
	Срез = РегистрыСведений.ДвиженияОбучающихся.СрезПоследних(Объект.Дата,Отбор);
	Если Срез.Количество() < 1 Тогда  // Если не найдено данных		
		Возврат Ложь;
	Иначе
		 АктуальныйПриказ = Срез[0].Регистратор;
		 Объект.Класс = Срез[0].Класс; 
		 ЗапросУчебныйГод = Новый Запрос("ВЫБРАТЬ
		                                 |	УчебныеГодаКлассноеРуководство.Класс КАК Класс,
		                                 |	УчебныеГодаКлассноеРуководство.КлассныйРуководитель КАК КлассныйРуководитель
		                                 |ИЗ
		                                 |	Справочник.УчебныеГода.КлассноеРуководство КАК УчебныеГодаКлассноеРуководство
		                                 |ГДЕ
		                                 |	УчебныеГодаКлассноеРуководство.Класс = &Класс
		                                 |	И УчебныеГодаКлассноеРуководство.Ссылка = &УчебныйГод");
		 ЗапросУчебныйГод.УстановитьПараметр("Класс",Объект.Класс);
		 ЗапросУчебныйГод.УстановитьПараметр("УчебныйГод",Срез[0].УчебныйГод);
		 Выборка = ЗапросУчебныйГод.Выполнить().Выбрать();
		 Если Выборка.Следующий() Тогда
			Объект.КлассныйРуководитель = Выборка.КлассныйРуководитель;	 
		Иначе
			Объект.КлассныйРуководитель = Справочники.Сотрудники.ПустаяСсылка();		
		 КонецЕсли;
		 Возврат Истина;
	КонецЕсли
КонецФункции

&НаСервере
Функция ЗагрузитьПриказОЗачислении(Ссылка)
	Отбор = Новый Структура("Обучающийся", Ссылка);
	Отбор.Вставить("ТипДвижения",Перечисления.ТипыДвиженияОбучающегося.ПриемНаОбучение);
	ЗапросПриказ = Новый Запрос("ВЫБРАТЬ
	                            |	ДвиженияОбучающихся.Регистратор КАК Регистратор,
								|	ДвиженияОбучающихся.Класс КАК Класс
	                            |ИЗ
	                            |	РегистрСведений.ДвиженияОбучающихся КАК ДвиженияОбучающихся
	                            |ГДЕ
	                            |	ДвиженияОбучающихся.Обучающийся = &Обучающийся
	                            |	И ДвиженияОбучающихся.ТипДвижения = &ТипДвижения
	                            |
	                            |УПОРЯДОЧИТЬ ПО
	                            |	ДвиженияОбучающихся.Период УБЫВ");
	ЗапросПриказ.Параметры.Вставить("Обучающийся", Ссылка);
	ЗапросПриказ.Параметры.Вставить("ТипДвижения", Перечисления.ТипыДвиженияОбучающегося.ПриемНаОбучение);
	Приказы = ЗапросПриказ.Выполнить().Выбрать();
	Если Приказы.Количество() < 1 Тогда  // Если не найдено данных		
		Возврат Ложь;
	Иначе                                      
		 Приказы.Следующий();
		 Объект.ПриказОЗачислении = Приказы.Регистратор;
		 Объект.КлассЗачисления = Приказы.Класс;
		 Возврат Истина;
	КонецЕсли
КонецФункции

&НаСервере
Функция ЗаполнитьДанные(Ссылка)
	Ответ1 = ЗагрузитьАктуальныйПриказ(Ссылка);
	Ответ2 = ЗагрузитьПриказОЗачислении(Ссылка);
	//Если Ответ1 И Ответ2 Тогда
		//РассчитатьОкончаниеУчебы();		
	//Иначе
	//	Объект.ДатаОкончанияОбучения = Дата(Год(ТекущаяДата()),06,30);	
	//КонецЕсли;
КонецФункции

&НаКлиенте
Процедура ОбучающийсяПриИзменении(Элемент)
	Ответ = ЗаполнитьДанные(Объект.Обучающийся);
КонецПроцедуры

//&НаСервере
//Функция РассчитатьОкончаниеУчебы()
//	ДатаВыпускаЭтогоГода = Дата(Год(Объект.Дата),06,30);
//	ДатаВыпускаГодаЗачисления = Дата(Год(Объект.ПриказОЗачислении.ДатаДействия),06,30);
//	КлассЗачисления = Число(СтрРазделить(Объект.КлассЗачисления.Наименование," ",Ложь)[0]);
//	КлассСейчас = Число(СтрРазделить(Объект.Класс.Наименование," ",Ложь)[0]);
//	НужноУчитьсяЛет = Неопределено;
//	Если КлассЗачисления <= 9 Тогда
//		НужноУчитьсяЛет = 9 - КлассСейчас;
//	Иначе
//		НужноУчитьсяЛет = 11 - КлассСейчас;
//	КонецЕсли;
//	Если Объект.Дата > ДатаВыпускаЭтогоГода Тогда // Если сейчас первое полугодие - прибавляем год
//		НужноУчитьсяЛет = НужноУчитьсяЛет + 1;
//	КонецЕсли;
	
//	Объект.ДатаОкончанияОбучения = Дата(Год(Объект.Дата)+НужноУчитьсяЛет,06,30);
	
	
	
//КонецФункции

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Ответ = ЗаполнитьДанные(Объект.Обучающийся);
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	Ответ = ЗаполнитьДанные(Объект.Обучающийся);
КонецПроцедуры
