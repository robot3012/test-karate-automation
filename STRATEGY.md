## Informe breve: estrategia de automatizacion

## Objetivo

Validar la gestion de usuarios en ServeRest (`/usuarios`) con una suite mantenible, trazable y ejecutable en paralelo con Karate DSL.

## Enfoque

Se adopto una estrategia de pruebas API orientada a comportamiento, separando cada operacion CRUD en features independientes para mejorar legibilidad y mantenimiento.

## Patrones aplicados

1. **Organizacion por endpoint (feature por operacion)**
   - `users-list.feature`, `users-create.feature`, `users-read.feature`, `users-update.feature`, `users-delete.feature`.
   - Facilita aislar fallos y ejecutar subconjuntos por tags.

2. **Test data management con utilidades centralizadas**
   - `src/test/java/util/users-utils.js` genera correos e ids aleatorios.
   - Reduce colisiones de datos entre ejecuciones.

3. **Contratos JSON reutilizables**
   - `src/test/java/responses/users-responses.json` centraliza contratos de exito y error.
   - Evita duplicacion y simplifica mantenimiento.

4. **Cobertura positiva y negativa por operacion**
   - Camino feliz para cada endpoint.
   - Escenarios negativos para duplicados, payload invalido y recurso inexistente.

5. **Trazabilidad por tags funcionales y casos**
   - Tags funcionales: `@smoke`, `@regression`, `@negative`.
   - Tags de casos: `@CP001` a `@CP011`.

## Matriz de trazabilidad (CP)

- `CP001`: GET listar usuarios.
- `CP002`: GET listado con parametro invalido.
- `CP003`: POST alta exitosa.
- `CP004`: POST email duplicado.
- `CP005`: POST sin email.
- `CP006`: GET por id existente.
- `CP007`: GET por id inexistente.
- `CP008`: PUT actualizacion exitosa.
- `CP009`: PUT payload invalido.
- `CP010`: DELETE usuario existente.
- `CP011`: DELETE usuario inexistente.

## Ejecucion y reporte

- La ejecucion principal se realiza con Maven (`mvn clean test`), disparando `QATest` en paralelo.
- Karate genera reporte HTML en `target/karate-reports/karate-summary.html`.

## Resultado

La suite cumple los criterios del reto: cobertura CRUD, casos positivos/negativos, validacion de contratos, manejo de datos de prueba y trazabilidad por caso.

