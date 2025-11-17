# Manejo de transacciones y transacciones anidadas

## ¿Qué es una transacción?

Una transacción es una unidad única de trabajo. Si una transacción tiene éxito, todas las modificaciones de los datos realizadas durante la transacción se confirman y se convierten en una parte permanente de la base de datos. Si una transacción encuentra errores y debe cancelarse o revertirse, se borran todas las modificaciones de los datos. Pueden dividirse en:
- **Transacciones explícitas**: cada transacción se inicia explícitamente con la BEGIN TRANSACTION instrucción y finaliza explícitamente con una COMMIT instrucción o ROLLBACK.
- **Transacciones implícitas**: una nueva transacción se inicia implícitamente cuando se completa la transacción anterior, pero cada transacción se completa explícitamente con una COMMIT instrucción o ROLLBACK.

## Propiedades a cumplir

- Atomicidad: se cumplen todas las operaciones o ninguna, Si algo falla, se revierte el proceso. 
- Consistencia: luego de la transacción, los datos deben tener integridad referencial. 
- Aislamiento: una transacción es independiente a otra. Es decir, los cambios en una no son visibles a otra. 
- Durabilidad: una vez hecho el COMMIT, los datos quedan almacenados permanentemente en la base de datos.

## Instrucciones para el control de transacciones

### Begin Transaction

Marca el punto de inicio de una transacción local explícita. Las transacciones explícitas comienzan con la BEGIN TRANSACTION instrucción y terminan con la COMMIT instrucción o ROLLBACK.
```SQL
BEGIN TRANSACTION;
```

También podemos usar la opción **WITH MARK** junto al BEGIN, esto hace que la transacción quede registrada en el sistema, y luego podamos identificarla en el registro o hacer backups.
```SQL
BEGIN TRAN Backup WITH MARK ‘Respaldo general’;
```

### COMMIT TRANSACTION

Marca el final de una transacción correcta, implícita o explícita. Si @@TRANCOUNT es 1, COMMIT TRANSACTION realiza todas las modificaciones de datos desde el inicio de la transacción una parte permanente de la base de datos, libera los recursos de la transacción y disminuye @@TRANCOUNT en 0. Cuando @@TRANCOUNT es mayor que 1, COMMIT TRANSACTION @@TRANCOUNT disminuye solo en 1 y la transacción permanece activa.
```SQL
BEGIN TRANSACTION; --@TRANCOUNT suma 1 y queda igual a 1 
  INSERT… (o alguna otra operación); 
COMMIT TRANSACTION; -- @TRANCOUNT resta 1 y queda en 0. Se completa la transacción
```

> [!IMPORTANT]
> @TRANCOUNT es el conteo de transacciones. El BEGIN suma 1 al contador, y el COMMIT resta 1. Solo al llegar a 0 se puede completar la transacción.

### ROLLBACK TRANSACTION

Esta instrucción revierte una transacción explícita o implícita al principio de la transacción, o a un punto de guardado dentro de la transacción. Puede usar ROLLBACK TRANSACTION para borrar todas las modificaciones de datos realizadas desde el inicio de la transacción o hasta un punto de guardado. También libera los recursos que mantiene la transacción.

Revertir una transacción no incluye cambios realizados en variables locales ni variables de tabla. Esta instrucción no borra estos cambios.
```SQL
BEGIN TRY 
  BEGIN TRANSACTION; --@TRANCOUNT suma 1 y queda igual a 1 
    INSERT… (o alguna otra operación); 
  COMMIT TRANSACTION; -- @TRANCOUNT resta 1 y queda en 0. Se completa la transacción 
END TRY 
BEGIN CATCH 
  IF @TRANCOUNT > 0 
    ROLLBACK TRANSACTION; --Se revierte la transacción 
  THROW; 
END CATCH
```

> [!IMPORTANT]
> Con la instrucción CATCH podremos verificar si el conteo de transacciones es mayor a 0 para realizar el ROLLBACK. En caso contrario, se hace el COMMIT.

### SAVE TRANSACTION

Establece un punto de retorno dentro de una transacción. Así con un ROLLBACK volver a ese punto. Pueden haber varios puntos de guardado en una misma transacción.
```SQL
SAVE TRAN guardado1;
```

## Transacciones anidadas

Se pueden hacer transacciones dentro de otra transacción, pero hay que tener en cuenta que solo la mas externa de estas es la queda en el registro del sistema.
```SQL
BEGIN TRAN PrincipalTran; --@TRANCOUNT = 1 
  INSERT… 
  BEGIN TRAN SegundaTran; --@TRANCOUNT = 2 
    INSERT… 
  BEGIN TRAN TerceraTran; --@TRANCOUNT = 3 
    UPDATE… 
  BEGIN TRAN CuartaTran; --@TRANCOUNT = 4 
    DELETE… 
  COMMIT TRAN CuartaTran; --@TRANCOUNT = 3 
  COMMIT TRAN TerceraTran; --@TRANCOUNT = 2 
  COMMIT TRAN SegundaTran; --@TRANCOUNT = 1 
COMMIT TRAN PrincipalTran; --@TRANCOUNT = 0. Se completa la transacción
```

> [!IMPORTANT]
> El último COMMIT es el que completa la transacción y guarda la nueva información de forma permanente.

## Conclusión

Las transacciones son herramientas muy útiles para modificar datos en la base cuando se requiere que sean tratados de forma consistente y en el caso de que algo falle, volver al punto de partida o donde quiera el usuario.
Además de permitir la recuperación de datos y un seguimiento de la carga de registros en el sistema.
