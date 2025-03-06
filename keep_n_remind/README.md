# Keep & Remind

Keep & Remind es una aplicación Flutter diseñada para ayudarte a recordar tus tareas y objetivos utilizando inteligencia artificial. La aplicación sigue un diseño de Figma y utiliza un enfoque de gestión de estado simple.

## Características

- **Gestión de Tareas**: Crea, edita y elimina notas con descripciones cortas y contenido detallado.
- **Recordatorios**: Establece alarmas para tus notas para recibir recordatorios en momentos específicos.
- **Integración con AI**: Utiliza la API de Google Gemini para generar notas y sugerencias de iconos automáticamente.
- **Localización**: Soporte para mensajes localizados basado en archivos arb.
- **Temas**: Cambia entre temas claros, oscuros y del sistema.

## Estructura del Proyecto

- **lib/main.dart**: Punto de entrada de la aplicación. Inicializa las configuraciones y servicios necesarios.
- **lib/src/app.dart**: Configuración principal de la aplicación, incluyendo el enrutamiento y la localización.
- **lib/src/presentation**: Contiene las vistas de la aplicación, como `HomePage` y `SendPage`.
- **lib/src/domain**: Define las entidades y casos de uso, como `Note` y `GenerateNoteUsecase`.
- **lib/src/data**: Maneja la persistencia de datos y la interacción con APIs externas.
- **lib/src/config**: Configuraciones de la aplicación, incluyendo el enrutador y los ajustes de usuario.

## Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tu_usuario/keep_n_remind.git
   cd keep_n_remind
   ```

2. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

3. **Configurar variables de entorno**:
   - Crea un archivo `.env` en la raíz del proyecto.
   - Añade tu clave API de Google Gemini:
     ```
     api_key=TU_CLAVE_API
     ```

4. **Ejecutar la aplicación**:
   ```bash
   flutter run
   ```

## Uso

- **Crear una Nota**: En la página principal, utiliza el campo de texto para escribir tus pensamientos y presiona el botón "Home" para guardar.
- **Ver Recordatorios**: Accede a la página de menú para ver y gestionar tus recordatorios.
- **Generar Notas con AI**: Utiliza la funcionalidad de AI para generar contenido automáticamente basado en tus entradas.

## Contribución

1. Haz un fork del proyecto.
2. Crea una nueva rama (`git checkout -b feature/nueva-caracteristica`).
3. Realiza tus cambios y haz commit (`git commit -am 'Añadir nueva característica'`).
4. Sube tus cambios a la rama (`git push origin feature/nueva-caracteristica`).
5. Abre un Pull Request.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.

## Recursos

- [Documentación de Flutter](https://docs.flutter.dev)
- [Diseño en Figma](https://www.figma.com/design/LUOHDE7HFqFD7eat7Ni1Dn/Keep-Pro-%7C%7C-Keep%26Remind?node-id=0-1&t=5QDAuLhR1w1KTQte-1)
- [API de Google Gemini](https://developers.google.com/gemini)
