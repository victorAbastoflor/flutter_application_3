Manual Técnico

Introducción:
El Proyecto de Parqueos nace por la necesidad de poder tener comodidad de tener un parqueo ya reservado, y así poder ir al parqueo y estar ahí, hasta el tiempo que escogió 
1.	Descripción del proyecto:
Pri-Parqueos es una Aplicación dedicada a las reservas de parqueos de la ciudad, la cual quiere hacer que las personas que usen la App, se sientan mas cómodos para poder a cualquier lugar 
2.	Roles / integrantes
Lucas Lozano Team Leader / Developer
Victor Abastoflor DB Architect / Developer
Renny Salazar Developer / Git Master
3.	Arquitectura del software: Explicación de la estructura y organización del software, incluyendo los componentes principales, las interacciones entre ellos y los patrones de diseño utilizados.

Componentes Principales

Autenticación:

Usuario: Representa a los individuos que utilizan la aplicación para buscar y reservar estacionamientos.
Cliente: Usuarios con la capacidad de crear nuevos parqueos. Tienen funcionalidades adicionales de administración.
Mapa:

Interfaz gráfica que permite a los usuarios visualizar parqueos disponibles y seleccionar uno para su reserva.
Gestión de Parqueos:

Creación de Parqueos: Funcionalidad para que los clientes creen nuevos parqueos, especificando detalles como la ubicación, capacidad y tarifas.
Visualización en el Mapa: Una vez creado un parqueo, se muestra en el mapa mediante un marcador para que los usuarios puedan identificarlo.
Reservas:

Selección de Parqueo: Permite a los usuarios elegir un parqueo disponible en el mapa.
Proceso de Reserva: Después de seleccionar un parqueo, los usuarios pueden realizar la reserva, lo que garantiza que el espacio esté disponible cuando lleguen.





Interacciones entre Componentes

Autenticación y Autorización:

La autenticación valida la identidad del usuario y determina si es un usuario regular o un cliente con permisos adicionales.
La autorización gestiona los niveles de acceso, permitiendo a los clientes crear y administrar parqueos.
Mapa y Selección de Parqueos:

La interfaz del mapa proporciona a los usuarios una representación visual de los parqueos disponibles.
La interacción permite a los usuarios seleccionar un parqueo en el mapa para su reserva.
Gestión de Parqueos y Visualización en el Mapa:

Los clientes utilizan la funcionalidad de creación de parqueos para agregar nuevos espacios al sistema.
Los parqueos creados se representan visualmente en el mapa para que los usuarios puedan acceder a ellos.
Reservas y Proceso de Reserva:

Después de seleccionar un parqueo, los usuarios inician el proceso de reserva.
El sistema verifica la disponibilidad y completa la reserva, asegurando que el espacio esté reservado para el usuario.
Patrones de Diseño Utilizados:

Modelo-Vista-Controlador (MVC):

Utilizado para separar la lógica de negocios (controlador), la presentación (vista) y los datos (modelo), facilitando el mantenimiento y la escalabilidad.

Pasos para ver los registros en la base de datos en firebase:
Correo: pparqueos@gmail.com
Contraseña: preparqueos2023
Al ingresar con el correo a la cuenta en firebase,ingresamos a la base de datos llamado Pri-Parqueos, luego ingresamos a la firestore database para visualizar los registros en la base de datos

4.	Requisitos del sistema:
•	Requerimientos de Hardware (mínimo): (cliente)
Celular con 2GB de RAM, 300 MB mínimos de almacenamiento
•	Requerimientos de Software: (cliente)
API 26 - Android 8.0 (Oreo) o IOS 14
•	Requerimientos de Hardware (server/ hosting/BD)

•	Requerimientos de Software (server/ hosting/BD)
FireBase





5.	Instalación y configuración: Instrucciones detalladas sobre cómo instalar el software, configurar los componentes necesarios y establecer la conexión con otros sistemas o bases de datos
Para la instalación del proyecto primero hay que descomprimir el Rar que se proporciono, lo cual se abre ese folder en el Visual Studio Code y tenemos que instalar la extensión de flutter, lo cual después abrimos una nueva terminal y colocamos esta línea de código: flutter pub get / flutter agregate.
Una vez terminada la acción, colocar la siguiente línea, la cual genera el Apk para los dispositivos móviles: flutter build apk.
La instalación de la App va a ser mediante un APK, lo cual al instalarse el APK solo tiene que presionar y va a entrar a la Aplicación

Si llega a haber un error, colocar en la terminal: flutter clean y volver a la colocar flutter pub get  / flutter agregate.


6.	PROCEDIMIENTO DE HOSTEADO / HOSTING (configuración)
•	Sitio Web.
•	B.D.
•	API / servicios Web
•	Otros (firebase, etc.)
Nuestro HOSTING es FireBase, con el Real Time Data Base
Credenciales:

Detalle DETALLADO paso a paso de la puesta en marcha en hosting, tanto para el sitio Web, API, B.D., etc.etc. (incluir scripts BD, Credenciales de acceso server, root BD, Admin, users clientes etc.)

7.	GIT :
Link de Acceso al GIT del Proyecto: https://github.com/victorAbastoflor/flutter_application_3.git
•	Versión final entregada del proyecto.
•	Entrega compilados ejecutables

9.	Personalización y configuración: Información sobre cómo personalizar y configurar el software según las necesidades del usuario, incluyendo opciones de configuración, parámetros y variables.
No se necesita ninguna configuración extra, todo ya esta implementado, y el usuario y el cliente no puede cambiar ninguna configuración

10.	Seguridad: Consideraciones de seguridad y recomendaciones para proteger el software y los datos, incluyendo permisos de acceso, autenticación y prácticas de seguridad recomendadas.
La seguridad del software y los datos son con las claves Token de FireBase, todo almacenamiento es en el Cloud de FireBase, lo que podemos recomendar es que los usuarios y los clientes no revelen sus credenciales como: nombre de usuario y contraseña a alguien desconocido 

11.	Depuración y solución de problemas: Instrucciones sobre cómo identificar y solucionar problemas comunes, mensajes de error y posibles conflictos con otros sistemas o componentes.
Si llegara a haber un problema en cualquier situación, el programa no hará las cosas que debería hacer, lo único que va a hacer es no hacer la transferencia o la carga de datos


12.	Glosario de términos: Un glosario que incluya definiciones de términos técnicos y conceptos utilizados en el manual.

13.	Referencias y recursos adicionales: Enlaces o referencias a otros recursos útiles, como documentación técnica relacionada, tutoriales o foros de soporte.

14.	Herramientas de Implementación:
•	Lenguajes de programación: Dart
•	Frameworks: Flutter Framework
Firebase Authentication API: Para gestionar la autenticación de usuarios de manera segura.
Firebase Cloud Firestore API: Para almacenar y recuperar datos en tiempo real, especialmente útil para la gestión de parqueos y reservas.

15.	Bibliografía

Configuraciones del flutter
https://firebase.flutter.dev/docs/overview/

Manual para el uso de flutter
https://docs.flutter.dev/?gclid=CjwKCAiAmZGrBhAnEiwAo9qHiZl07z55VyohzngTH3d-ABCCuUHMqx0tVRThlJpFY4u6g_UyzRVKvxoC0bgQAvD_BwE&gclsrc=aw.ds

Pasos para agregar firebase a la aplicación flutter
https://firebase.google.com/docs/flutter/setup?hl=es-419&platform=ios

Guias para la programación en Dart
https://www.udemy.com/course/programacion-en-dart/

Grabación del Proyecto en Youtube
https://youtu.be/sTPx6PNLrvk
