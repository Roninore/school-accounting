Функция Экспортировать(ТабДок, Ссылка) Экспорт 
	ЗапросДокумент = Новый Запрос("ВЫБРАТЬ
	                              |	ЕГИССО.Ссылка КАК Ссылка,
	                              |	ЕГИССО.ВерсияДанных КАК ВерсияДанных,
	                              |	ЕГИССО.ПометкаУдаления КАК ПометкаУдаления,
	                              |	ЕГИССО.Номер КАК Номер,
	                              |	ЕГИССО.Дата КАК Дата,
	                              |	ЕГИССО.Проведен КАК Проведен,
	                              |	ЕГИССО.ТипЕГИССО КАК ТипЕГИССО,
	                              |	ЕГИССО.УчебныйГод КАК УчебныйГод,
	                              |	ЕГИССО.Таблица.(
	                              |		Ссылка КАК Ссылка,
	                              |		НомерСтроки КАК НомерСтроки,
	                              |		LMSZID КАК LMSZID,
	                              |		categoryID КАК categoryID,
	                              |		SNILS_recip КАК SNILS_recip,
	                              |		FamilyName_recip КАК FamilyName_recip,
	                              |		Name_recip КАК Name_recip,
	                              |		Patronymic_recip КАК Patronymic_recip,
	                              |		Gender_recip КАК Gender_recip,
	                              |		BirthDate_recip КАК BirthDate_recip,
	                              |		doctype_recip КАК doctype_recip,
	                              |		doc_Series_recip КАК doc_Series_recip,
	                              |		doc_Number_recip КАК doc_Number_recip,
	                              |		doc_IssueDate_recip КАК doc_IssueDate_recip,
	                              |		doc_Issuer_recip КАК doc_Issuer_recip,
	                              |		SNILS_reason КАК SNILS_reason,
	                              |		FamilyName_reason КАК FamilyName_reason,
	                              |		Name_reason КАК Name_reason,
	                              |		Patronymic_reason КАК Patronymic_reason,
	                              |		Gender_reason КАК Gender_reason,
	                              |		BirthDate_reason КАК BirthDate_reason,
	                              |		doctype_reason КАК doctype_reason,
	                              |		doc_Series_reason КАК doc_Series_reason,
	                              |		doc_Number_reason КАК doc_Number_reason,
	                              |		doc_IssueDate_reason КАК doc_IssueDate_reason,
	                              |		doc_Issuer_reason КАК doc_Issuer_reason,
	                              |		decision_date КАК decision_date,
	                              |		dateStart КАК dateStart,
	                              |		dateFinish КАК dateFinish,
	                              |		usingSign КАК usingSign,
	                              |		criteria КАК criteria,
	                              |		FormCode КАК FormCode,
	                              |		amount КАК amount,
	                              |		measuryCode КАК measuryCode,
	                              |		monetization КАК monetization,
	                              |		content КАК content,
	                              |		comment КАК comment,
	                              |		equivalentAmount КАК equivalentAmount
	                              |	) КАК Таблица,
	                              |	ЕГИССО.Представление КАК Представление,
	                              |	ЕГИССО.МоментВремени КАК МоментВремени
	                              |ИЗ
	                              |	Документ.ЕГИССО КАК ЕГИССО
	                              |ГДЕ
	                              |	ЕГИССО.Ссылка В(&Ссылка)");	
	ЗапросДокумент.УстановитьПараметр("Ссылка",Ссылка);
	Документ = ЗапросДокумент.Выполнить().Выбрать();
		
	ТабДок.Очистить();
	Макет = ПолучитьОбщийМакет("ЕГИССО");
	Шапка = Макет.ПолучитьОбласть("ОбластьШапка");
	Данные = Макет.ПолучитьОбласть("ОбластьДанные"); 
	ТабДок.Вывести(Шапка,Документ.Уровень());
	
	
	ВставлятьРазделительСтраниц = Ложь;
	Пока Документ.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		Таблица = Документ.Таблица.Выбрать();
		
		Пока Таблица.Следующий() Цикл
			Данные.Параметры.Заполнить(Таблица);  
			Данные.Параметры.SNILS_recip = СтрЗаменить(СтрЗаменить(Таблица.SNILS_recip,"-","")," ","");
			Данные.Параметры.SNILS_reason = СтрЗаменить(СтрЗаменить(Таблица.SNILS_reason,"-","")," ","");
			Данные.Параметры.BirthDate_recip = Формат(Таблица.BirthDate_recip,"ДФ=dd.MM.yyyy");
			Данные.Параметры.doc_IssueDate_recip = Формат(Таблица.doc_IssueDate_recip,"ДФ=dd.MM.yyyy");
			Данные.Параметры.decision_date = Формат(Таблица.decision_date,"ДФ=dd.MM.yyyy");
			Данные.Параметры.dateStart = Формат(Таблица.dateStart,"ДФ=dd.MM.yyyy");
			Данные.Параметры.dateFinish = Формат(Таблица.dateFinish,"ДФ=dd.MM.yyyy");
			Данные.Параметры.BirthDate_reason = Формат(Таблица.BirthDate_reason,"ДФ=dd.MM.yyyy");
			Данные.Параметры.doc_IssueDate_reason = Формат(Таблица.doc_IssueDate_reason,"ДФ=dd.MM.yyyy");
			ТабДок.Вывести(Данные,Документ.Уровень());
		КонецЦикла;
		
		Возврат "ЕГИССО_" + Документ.ТипЕГИССО.Наименование + "_От_" + Формат(Документ.Дата,"ДФ=dd_MM_yyyy");
	
		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	
	
КонецФункции