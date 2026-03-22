## Reto QA Backend - API de Usuarios (ServeRest) con Karate DSL

Suite de pruebas automatizadas para `https://serverest.dev`, enfocada en el recurso `usuarios` y organizada por endpoint CRUD.

## Entregables incluidos

1. Proyecto completo con suite Karate DSL.
2. README con configuracion y ejecucion.
3. Informe breve de estrategia en `STRATEGY.md`.

## Cobertura funcional

Se implementan pruebas para:

- `GET /usuarios`
- `POST /usuarios`
- `GET /usuarios/{_id}`
- `PUT /usuarios/{_id}`
- `DELETE /usuarios/{_id}`

Incluye escenarios positivos y negativos, validacion de contratos JSON y generacion dinamica de datos.

## Requisitos

- Java 17 o superior
- Maven 3.8 o superior
- Conexion a internet

## Ejecucion

Ejecutar suite completa:

```bash
mvn clean test
```

Ejecutar por tag funcional:

```bash
mvn test "-Dkarate.options=--tags @smoke"
mvn test "-Dkarate.options=--tags @regression"
mvn test "-Dkarate.options=--tags @negative"
```

Ejecutar por caso de prueba:

```bash
mvn test "-Dkarate.options=--tags @CP001"
mvn test "-Dkarate.options=--tags @CP011"
```

Ejecutar con `baseUrl` personalizada:

```bash
mvn test "-DbaseUrl=https://serverest.dev"
```

## Estructura real del proyecto

- `src/test/java/karate-config.js`: configuracion global (`baseUrl`, `env`, SSL).
- `src/test/java/bdd/users/users-list.feature`: pruebas de listado.
- `src/test/java/bdd/users/users-create.feature`: pruebas de registro.
- `src/test/java/bdd/users/users-read.feature`: pruebas de consulta por id.
- `src/test/java/bdd/users/users-update.feature`: pruebas de actualizacion.
- `src/test/java/bdd/users/users-delete.feature`: pruebas de eliminacion.
- `src/test/java/util/users-utils.js`: utilidades de datos de prueba.
- `src/test/java/responses/users-responses.json`: contratos JSON reutilizables.
- `src/test/java/bdd/QATest.java`: suite paralela ejecutada por Maven Surefire.
- `src/test/java/bdd/users/UsersRunner.java`: runner alternativo para el dominio `users`.

## Matriz de casos CP

- `@CP001`: listar usuarios.
- `@CP002`: listar con query invalido (`limite=-1`).
- `@CP003`: registrar usuario valido.
- `@CP004`: registrar usuario duplicado.
- `@CP005`: registrar usuario sin email.
- `@CP006`: consultar usuario existente por id.
- `@CP007`: consultar usuario inexistente por id.
- `@CP008`: actualizar usuario existente.
- `@CP009`: actualizar con payload invalido.
- `@CP010`: eliminar usuario existente.
- `@CP011`: eliminar usuario inexistente.

## Validaciones implementadas

- Codigo HTTP esperado por operacion.
- Contratos de respuesta con placeholders de Karate (`#string`, `#number`, `#[]`).
- Persistencia del flujo CRUD (create/read/update/delete).
- Manejo de respuestas de error con claves variables por campo.

## Reportes

Los reportes HTML de Karate se generan en:

- `target/karate-reports/karate-summary.html`

## Nota SSL / PKIX

Si aparece `PKIX path building failed`, normalmente es por inspeccion TLS o CA corporativa.

Opciones comunes:

1. Importar la CA corporativa en el truststore de Java.
2. Ejecutar en una red sin inspeccion TLS.
3. Usar el bypass temporal `karate.configure('ssl', true)` (actualmente activo en `karate-config.js`).

## Estrategia

Ver `STRATEGY.md` para enfoque, patrones y trazabilidad.

