# DentalCare — proyecto para IntelliJ IDEA con localhost:8080

## Ejecutar en IntelliJ IDEA

1. Descomprime este archivo ZIP.
2. En IntelliJ IDEA, pulsa **File > Open** y elige la carpeta `ConsultorioDental_Localhost_IntelliJ` (donde está `pom.xml`).
3. Espera a que IntelliJ cargue el proyecto Maven. Configura **Project SDK** con **JDK 17 o posterior** (JDK 21 o 23 también sirve).
4. Abre `src/main/java/com/dentalcare/ServidorDental.java`.
5. Haz clic en el triángulo verde junto a `main` y selecciona **Run 'ServidorDental.main()'**.
6. Abre **http://localhost:8080/** en Chrome o Edge. Mantén en ejecución IntelliJ mientras uses el sitio.

Si el puerto 8080 está ocupado, cierra la otra aplicación que lo esté utilizando, o cambia `8080` por otro puerto en `ServidorDental.java` y abre esa dirección.

## Qué contiene

- `src/main/java/com/dentalcare/ServidorDental.java`: servidor web local hecho en Java, sin librerías externas.
- `src/main/resources/web/index.html`: sitio web.
- `src/main/resources/web/css/styles.css`: estilos.
- `src/main/resources/web/js/app.js`: funcionalidades (pacientes, citas, tratamientos, historial, facturas y pagos).
- `docs/`: diagramas PlantUML y propuesta de tablas SQL como referencia.

## Importante

El sitio ahora abre mediante **localhost:8080**, pero los registros siguen almacenándose mediante **localStorage**, no en una base de datos SQL. El servidor Java entrega la interfaz web; no incluye todavía backend de persistencia, autenticación, notificaciones reales ni facturación fiscal. Es un prototipo académico; no guardes datos clínicos reales.
