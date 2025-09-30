## :bicyclist: FitTrack :runner:

### Clona este repositorio
git clone https://github.com/AnaGanfornina/Proyecto_Final_Mobile19.git



### ¿Que es FitTrack?

FitTrack es una plataforma diseñada para la creación y gestión de rutinas personalizadas.

Esta plataforma te permite registrar a todos los usuarios de tu gimnasio, clínica o box, asignarles rutinas y/o entrenamientos y centralizar toda su información en un único lugar, lo que facilitará el seguimiento y la progresión de tus deportistas.

### Objetivos de este proyecto 

Esta aplicación se centra en el coach como protagonista, ofreciondo los siguientes puntos:

1. Gestión de clientes: cada coach puede organizar y administrar a todos sus clientes. En una única plataforma dispondrá de los entrenamientos realizados, las métricas y los objetivos.

2. Seguimiento personalizado: poder acceder al historial de entrenamientos, los progresos de los ejercicios y los marcajes de estos 

### ¿Cómo funciona? :iphone:

1. Al iniciar la aplicación encontrarás un menú donde podrás elegir entre iniciar sesión si ya tienes una cuenta creada o registrarse, donde tendrás que añadir tu nombre, tu email y una contraseña.

2. Ambos pasos te llevarán a la pantalla de Home, donde podrás visualizar los próximos entrenamientos que tienes programados con tus clientes, así como:

	- Crear un cliente nuevo: Se facilitará un formulario mas extenso donde se rellenarán métricas, se planteará un objetivo, se reflejará un historial y el nivel actual. 

	- Crear un entrenamiento nuevo: Se mostrará una pantalla donde se seleccionará un cliente, se planteará el objetivo del entrenamiento, se seleccionará la fecha y hora y se confeccionarán los ejercicios.

		-Ejercicios: Al seleccionar ejercicios, se mostrará una pantalla donde aparecerán los ejercicios elegidos a partir del botón "Añadir ejercicios", el cual mostrará el listado de ejercicios disponibles. 
		Podrás confeccionar el numeros de series, el peso, las repeticiones de cada serie y el tiempo estimado. 

	Una vez seleccionado todo, pulsa el botón crear para observar el entrenamiento en la home. 
  
	- Visualizar el calendario completo pulsando en el icono.

	- Visualizar tu perfil pulsando en el icono con tu foto (pendiente de implementar).

3. A parte, desde el momento en que inicies sesión, habrá una tabBar donde podrás visualizar:
	
	-Clientes: Listado de clientes donde poder seleccionar y consultar los datos de cada uno (pendiente de implementar).

	- Ejercicios: Listado de ejercicios por orden alfabético, donde podrás seleccionar y ver en detalle como se realiza cada uno. (Pendiente de implementar).
 
 ![Pantallas de muestra](/imagenes/pantallas.png)
 
### ¿Como funciona el server?
Para el funcionamiento del server se necesita crear un archivo en markdown con nombre ".env.development" que contenga la siguiente linea:

"JWT_KEY=1119ForMeeting"

Importante ejecutar el server antes de iniciar la app en el simulador, ya que ahora mismo el server esta en desarrollo y por tanto se correrá en local. 

![.env.development](/imagenes/JTWKEY.png)

### Tecnologías utilizadas :clipboard:

- Lenguaje empleado: Swift 

- Framework SwiftUI 

- Arquitectura CLEAN

- Patrón MVVM (Model-View-ViewModel)

- Server creado en Vapor + Fluent 


### Testing:
La App cuenta con una convertura del 28%.

