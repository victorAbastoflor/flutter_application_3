Manual Técnico de la Aplicación de Parqueos


1. Introducción
Este manual técnico describe la aplicación de parqueos, una solución digital para la gestión y reserva de espacios de estacionamiento. La aplicación permite a los usuarios, tanto clientes como dueños de parqueos, interactuar de manera eficiente, ofreciendo funcionalidades como registro de parqueos, reservas en tiempo real, y control de espacios y costos, como también la funcionalidad completa de un mapa.

2. Descripción del Proyecto
La aplicación ofrece dos roles principales: Cliente y Dueño. Los dueños pueden registrar sus parqueos, gestionar espacios, costos y reservas. Los clientes, por otro lado, pueden visualizar parqueos disponibles, detalles relevantes y realizar reservas. Todo el sistema está controlado por sesiones e IDs para garantizar la seguridad y la pertinencia de la información, es decir que cada dueño/cliente con un “id” en específico podrá visualizar el contenido creado o hecho.

3. Roles / Integrantes
Lucas Lozano Team Leader / Developer
Victor Abastoflor DB Architect / Developer
Renny Salazar Developer / Git Master
4. Arquitectura del Software
Componentes Principales

Autenticación:

Cliente: Representa a las personas que utilizan la aplicación para buscar y reservar parqueos, todo mediante un mapa que es completamente funcional, con marcadores, y detalles de los parqueos registrados en la aplicación.
Dueño: Usuarios con la capacidad de crear nuevos parqueos. Tienen funcionalidades adicionales de administración, y son capaces de ver las reservas hechas en un parqueo en específico creado por un dueño en específico.


Mapa:

Interfaz gráfica que permite a los usuarios visualizar parqueos disponibles y seleccionar uno para su reserva, cada parqueo tiene un marcador en el mapa con detalles del parqueo, nombre, horario de apertura, costo por hora y los espacios disponibles en ese parqueo.
Gestión de Parqueos:
Creación de Parqueos: Funcionalidad para que los dueños creen nuevos parqueos, especificando detalles como el nombre, ubicación, coordenadas(para ser agregados en el mapa),  imágenes de su parqueo, espacios disponibles que todo esto tiene la funcionalidad de un CRUD, es decir que el dueño de dicho parqueo creado por él mismo (manejo de sesiones por id), pueda ver, editar (todos los campos), eliminar si así lo desea.
Visualización en el Mapa: Una vez creado un parqueo, se muestra en el mapa mediante un marcador para que los usuarios puedan identificarlo fácilmente, con los detalles e imágenes del parqueo.
Reservas:
Selección de Parqueo: Permite a los clientes elegir un parqueo disponible en el mapa.
Proceso de Reserva: Después de seleccionar un parqueo, los usuarios pueden realizar la reserva, pero es muy importante recalcar que si un parqueo no tiene espacios disponibles en el momento (control en tiempo-real) no podrá concretar la reserva hasta que este se desocupe. Una vez que haya espacio podrá hacer la reserva sin ningún problema, si la reserva se concreta este le mostrará un recibo con los detalles de la reserva.
El cliente obtendrá un espacio donde tiene una lista de todas sus reservas hechas en uno o más parqueos. Estas reservas se controlan mediante estados que son: pendiente, en curso y finalizado.
Obviamente el dueño es el que tiene el control total de estas reservas hechas en su parqueo… además está la integración de un cronómetro a nivel de aplicación que el dueño decide cuando empezar el conteo del tiempo una vez que el cliente llegue al parqueo. El cliente podrá visualizar en sus detalles de reservas que el tiempo está transcurriendo, pero no tiene el poder de parar o reiniciar el tiempo para evitar mal entendidos.
Interacciones entre Componentes.
Autenticación y Autorización:
La autenticación valida si este es un usuario regular (cliente) o si es un dueño de parqueo(s).
La autorización gestiona los niveles de acceso, permitiendo a los dueños crear, editar y eliminar parqueos, también tiene la posibilidad de ver qué reservas se hicieron en qué parqueo, ya que un dueño puede tener uno o más parqueos(manejo por sesiones: id).
Y el cliente puede visualizar una lista de TODOS los parqueos registrados en la aplicación, permitiendo visualizar las coordenadas, detalles y reservas hecha por él mismo.
Mapa y Selección de Parqueos:
La interfaz del mapa proporciona a todos los usuarios la visualización de los parqueos creados a nivel de aplicación, es decir, hasta los propios dueños pueden ver los parqueos en el mapa, pero no en su lista de parqueos, esto quiere decir que no pueden interactuar con un parqueo si este no les pertenece.
La interacción permite a los clientes seleccionar un parqueo en el mapa para hacer su reserva y en el formulario de reservas tiene la opción de visualizar cuánto se le va a cobrar por las horas de su estadía en el parqueo. 
Gestión de Parqueos y Visualización en el Mapa:
Los dueños utilizan la funcionalidad de creación de parqueos para agregar nuevos espacios al sistema/mapa.
Los parqueos creados se representan visualmente en el mapa para que los usuarios puedan acceder a ellos.
Reservas y Proceso de Reserva:
Después de seleccionar un parqueo, los usuarios primero visualizar los detalles del parqueo, como imágenes, nombre, ubicación y si hay espacios disponibles para poder completar su reserva, también pueden ver el cobro que se les va a hacer por las horas de estadía en el parqueo. Si la reserva es correcta, se le va a mostrar un recibo con los detalles de la reserva.
Patrones de Diseño Utilizados:
(Arquitectura por Módulos)
Pasos para ver los registros en la base de datos en firebase:
Correo: pparqueos@gmail.com
Contraseña: preparqueos2023 
Al ingresar con el correo a la cuenta en firebase, ingresamos a la base de datos llamado Pri-Parqueos, luego ingresamos a la firestore database para visualizar los registros en la base de datos
5. Requisitos del Sistema
Usuario:
Requerimientos de Hardware: Dispositivo móvil o computadora con acceso a Internet.
Requerimientos de Software: Sistema operativo – Android 8+
Servidor / Hosting / BD
Requerimientos de Hardware: Ya que la base de datos está alojada en Firebase(en tiempo real) no hace falta un servidor como tal, con una computadora, laptop, pc regular basta para poder gestionar la base de datos.
Requerimientos de Software: Firebase, con reglas de autenticación, manejo por sesiones(id), colecciones y alojamiento de imágenes en Firebase Storage.
6. Instalación y Configuración
Primero se debe tener acceso a la carpeta del proyecto, es obligatorio tener un entorno de desarrollo Visual Code (Recomendado), abrir la terminal de comandos, darle un flutter pub get, para que se instalen las dependencias necesarias, luego se puede proceder con un flutter run(emulador o dispositivo conectado a la pc) o un flutter build apk para construir el ejecutable.
Luego ya es una instalación normal, la forma de ejecutar es muy sencilla, ya que el servidor(base de datos) está alojada en la nube. El usuario simplemente debe crear una cuenta válida con correo para acceder al sistema. Este tendrá la posibilidad de elegir entre si es un Cliente o Dueño. Y luego proceder a iniciar sesión con esas credenciales.
7. Procedimiento de Hosteado / Hosting
Nuestro hosting es netamente Firebase, usando los servicios de Firestore, Firebase Auth, Firebase Storage. 
8. GIT
•	Versión Final Entregada.
•	Entrega de Compilados Ejecutables.
9. Personalización y Configuración
No es necesario configurar o personalizar algún aspecto dentro de la aplicación, si se quiere modificar algo dentro del código o la base de datos, es necesario que un “experto” lo haga para evitar problemas futuros con la aplicación.
10. Seguridad
La seguridad del software y los datos son con las claves Token de Firebase, todo almacenamiento es en el Cloud de FireBase, lo que podemos recomendar es que los usuarios y los clientes no revelen sus credenciales como: nombre de usuario y contraseña a alguien desconocido.
Se recomienda mantener las credenciales de Google(Firebase) en secreto para proteger la integridad de la aplicación.
11. Depuración y Solución de Problemas
La aplicación está desarrollada que mediante bloques de código este te devuelva un resultado esperado (como un mensaje de alerta si algo salió mal) si este falla, no debería hacer algo no debido.
Si este falla como el inicio de sesión, se pide que por favor se revisen bien las credenciales y se vuelva a ingresar la contraseña. Si el error persiste contactarse con el administrador.

12. Glosario de Términos
Parqueo en Tiempo Real:
Definición: La capacidad de visualizar la disponibilidad de espacios de parqueo en tiempo real a través de la aplicación.
Reserva de Parqueo:
Definición: El proceso mediante el cual los usuarios pueden asegurar un espacio de parqueo para un período específico antes de llegar al lugar.
Geolocalización:
Definición: El uso de datos de ubicación para determinar la posición geográfica del usuario y ofrecer servicios basados en la ubicación, todo mediante un buscador funcional.
Notificación de Disponibilidad:
Definición: Alertas push enviadas a los usuarios cuando se detecta la disponibilidad de un espacio de parqueo cercano a su ubicación.
13. Referencias y Recursos Adicionales
Incluídas en la bibliografía.
14. Herramientas de Implementación
Lenguajes de Programación: Flutter/Dart.
APIs de Terceros: APIs de Firebase
15. Bibliografía
Configuraciones del flutter:
https://firebase.flutter.dev/docs/overview/
Manual para el uso de flutter:
https://docs.flutter.dev/?gclid=CjwKCAiAmZGrBhAnEiwAo9qHiZl07z55VyohzngTH3d-ABCCuUHMqx0tVRThlJpFY4u6g_UyzRVKvxoC0bgQAvD_BwE&gclsrc=aw.ds
Pasos para agregar firebase a la aplicación flutter:
https://firebase.google.com/docs/flutter/setup?hl=es-419&platform=ios
Guias para la programación en Dart:
https://www.udemy.com/course/programacion-en-dart/
