SELECT
		SYSO.name														AS TableName
		,SYST.object_id													AS TriggerObjectId
		,SYST.name														AS TriggerName
		,SYSC.text														AS TriggerText
		,SYST.create_date												AS TriggerCreation
		,SYSO.refdate													AS TriggerRefDate
		,SYSO.version													AS TriggerVersion
		,SYSO.xtype														AS TriggerType
		,SYST.type														AS ObjectType
		,SYST.type_desc													AS TriggerDesc
		,SYST.is_instead_of_trigger										AS IsInsteadOfTrigger
		,OBJECTPROPERTY(SYSOS.object_id, 'ExecIsUpdateTrigger')			AS IsUpdate
		,OBJECTPROPERTY(SYSOS.object_id, 'ExecIsDeleteTrigger')			AS IsDelete
		,OBJECTPROPERTY(SYSOS.object_id, 'ExecIsInsertTrigger')			AS IsInsert
		,OBJECTPROPERTY(SYSOS.object_id, 'ExecIsAfterTrigger')			AS IsAfterTrigger
FROM
		sys.triggers													AS SYST
JOIN
		sysobjects														AS SYSO
ON		SYST.parent_id = SYSO.id
JOIN
		syscomments														AS SYSC
ON		SYSC.id = SYST.[object_id]
JOIN
		sys.objects														AS SYSOS
ON		SYSC.id = SYSOS.object_id
ORDER BY
		TableName
		,TriggerName