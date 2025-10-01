
# La Taberna de Roly

Este es un proyecto de E-commerce para una tienda de vinos y licores.

## Cómo ejecutar la aplicación

Para ejecutar esta aplicación Spring Boot, sigue estos pasos:

1.  Abre una terminal en la raíz del proyecto.
2.  Ejecuta el siguiente comando:

    ```bash
    mvn spring-boot:run
    ```

3.  Una vez que la aplicación se haya iniciado, puedes acceder a ella en tu navegador web en la siguiente dirección: [http://localhost:8080](http://localhost:8080)

### Posible problema: El puerto 8080 ya está en uso

Si recibes un error indicando que el puerto 8080 ya está en uso, significa que otra aplicación (posiblemente una instancia anterior de esta misma aplicación) ya está usando ese puerto.

Para solucionarlo, puedes hacer lo siguiente:

1.  **Cambiar el puerto de la aplicación:**
    *   Abre el archivo `src/main/resources/application.properties`.
    *   Añade la siguiente línea para cambiar el puerto a, por ejemplo, 8081:
        ```properties
        server.port=8081
        ```
    *   Guarda el archivo y vuelve a ejecutar la aplicación. Ahora estará disponible en `http://localhost:8081`.

o

2.  **Detener el proceso que usa el puerto 8080:**
    *   En la terminal, puedes usar el siguiente comando para encontrar el ID del proceso (PID) que está usando el puerto 8080:
        ```bash
        lsof -i :8080
        ```
    *   Una vez que tengas el PID, puedes detener ese proceso con el siguiente comando (reemplaza `PID` con el número que obtuviste):
        ```bash
        kill PID
        ```
    *   Después de detener el proceso, puedes intentar ejecutar tu aplicación de nuevo con `mvn spring-boot:run`.

