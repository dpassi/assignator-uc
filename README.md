----------
Blank: Asignador de Salas UC!
===================

## Integrantes:


| Nº Alumno    | Nombre              | Email UC      | Github          |
|:-------------|:--------------------|:--------------|:----------------|
| 13637967     | Diego Passi     | djpassi@uc.cl | @djpassi     |
| 13633317     | David Galemiri     | dagalemiri@uc.cl | @dagalemiri     |
| 13634143     | Gabriel Ulloa     | gsulloa@uc.cl | @gsulloa     |



# Uso

Clonar el repositorio:

```sh
git clone https://github.com/IIC2143-2016-1/Blank
```


Entrar a la carpeta del proyecto:

```sh
cd Blank/project
```

Instalar gemas:

```sh
bundle install
```

Migrar base de datos:

```sh
rake db:migrate db:seed
```

Disfrutar de la aplicación:

```sh
rails s
```

Ingresar a:

  [Browser en localhost](http://localhost:3000/)

Datos del administrador(creados gracias al db:seed):
```sh
cuenta: admin@admin.com
clave: 12345678

```


###Uso y explicaciones dentro de la aplicación

La aplicación web consiste en un sistema de manejo de salas dentro de la Universidad. Se puede asignar una sala a una cátedra, ayudantía, interrogación, examen u cualquier otra solicitud. *Se diseñaron tres usuarios:*


 - Administrador
 - Profesor
 - Alumno

    

> Nota:El usuario alumno no requiere registro.

Existe una pestaña llamada ```Herramientas```, la cual solo está disponible para **usuarios registrados.** Las opciones disponibles difieren entre administrador y profesor. 

**El administrador** está capacitado para descargar la base de datos de cursos y salas disponibles. Posteriormente, puede asignar automáticamente una sala a un curso dado las necesidades de este último. Además, el administrador está facultado para asignar un curso a un profesor (los cursos no tienen profesores a menos que el administrador los asigne). 

**El profesor** puede ver los cursos y las respectivas salas que fueron asignadas. Además, puede eliminar o solicitar una asignación de salas. 

La pestaña ```Servicios``` **está disponible para todos los usuarios** (administrador, profesor y alumno). En este apartado se pueden hacer consultas sobre las salas que han sido asignadas, ver en el mapa donde está ubicada, revisar estadísticas, entre otros.

