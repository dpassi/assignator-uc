----------
Blank: Automatic assignator for classrooms Campus College UC!
===================

## Creators:


| Nombre              | Email     | Github          |
|:--------------------|:--------------|:----------------|
| Diego Passi     | djpassi@uc.cl | @djpassi     |
| David Galemiri     | dagalemiri@uc.cl | @dagalemiri     |
| Gabriel Ulloa     | gsulloa@uc.cl | @gsulloa     |



# Uso

Clone the repository:

```sh
git clone https://github.com/IIC2143-2016-1/Blank
```


Go inside the directory:

```sh
cd Blank/project
```

Install gems:

```sh
bundle install
```

Database migrate:

```sh
rake db:migrate db:seed
```

Join the app:

```sh
rails s
```

Admin details:
```sh
cuenta: admin@admin.com
clave: 12345678

```


###Uso y explicaciones dentro de la aplicación

Translate Soon


La aplicación web consiste en un sistema de manejo de salas dentro de la Universidad. Se puede asignar una sala a una cátedra, ayudantía, interrogación, examen u cualquier otra solicitud. *Se diseñaron tres usuarios:*


 - Administrador
 - Profesor
 - Alumno

    

> Nota:El usuario alumno no requiere registro.

Existe una pestaña llamada ```Herramientas```, la cual solo está disponible para **usuarios registrados.** Las opciones disponibles difieren entre administrador y profesor. 

**El administrador** está capacitado para descargar la base de datos de cursos y salas disponibles. Posteriormente, puede asignar automáticamente una sala a un curso dado las necesidades de este último. Además, el administrador está facultado para asignar un curso a un profesor (los cursos no tienen profesores a menos que el administrador los asigne). 

**El profesor** puede ver los cursos y las respectivas salas que fueron asignadas. Además, puede eliminar o solicitar una asignación de salas. 

La pestaña ```Servicios``` **está disponible para todos los usuarios** (administrador, profesor y alumno). En este apartado se pueden hacer consultas sobre las salas que han sido asignadas, ver en el mapa donde está ubicada, revisar estadísticas, entre otros.

