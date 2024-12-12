# Avivas Store
Trabajo Final Integrador para TTPS (Opción Ruby)
* Requisitos técnicos
  - ruby 3.3.5
  - rails 8.0.0
  - sqlite3 3.47.0


## Características Principales

### 1. Sistema de Autenticación   
- **Integración con Devise**: Permite el registro de usuarios, inicio de sesión y cierre de sesión.  
- **Gestión de Roles**: Los roles de usuario (administrador, gerente, empleado) determinan los permisos de acceso en la plataforma. Se definen mediante un campo Role en el
  modelo User.
- **Desactivar usuario**: Los usuarios pueden ser activados o desactivados mediante el campo `active` en el modelo User. Los usuarios desactivados no pueden iniciar sesión ya que se cambia su contraseña, solo el User con role "Admin" puede activarlo. Decidí que al activar el usuario el administrador debe elegir una nueva contraseña para él.
  
### 2. Gestión de Productos  
- **Operaciones CRUD completas**: Crear, ver, actualizar y eliminar logicamente productos. Para el borrado lógico utilicé la gema "Paranoia". Al borrar un producto el stock pasa a 0 y no se muestra en el storefront, se puede volver a habilitar si un usuario edita su stock desde el boton "change stock".
- **Carga de Imágenes**: Se pueden agregar imágenes a los productos utilizando Active Storage.
- **Descripcion de productos**: Para la descripción de productos utilicé Action Text para manejar texto enriquecido.
- **Filtrado y busqueda**: Para la busqueda y filtrado de productos por nombre, descripción y categoria utilicé la gema Ransack.

### 3. Gestión de Ventas  
- **Operaciones CRUD completas**: Administrar ventas con la opción de cancelar y marcar las transacciones como "Canceladas". Las ventas canceladas no pueden ser modificadas ni activadas. 


### 4. Gestión de Usuarios  
- **Privilegios de Adminis y Managers**: Los administradores pueden gestionar usuarios, incluyendo la creación, actualización y desactivación de cuentas. Los managers no pueden desactivar un usuario. El "borrado" es la desactivación.
- **Autogestión de Perfiles**: Los usuarios pueden actualizar su perfil, pero no desactivar su cuenta ni modificar su rol, tampoco pueden cambiar su contraseña ya que me pareció que era mejor que esto lo maneje el administrador y más adelante sea comunicado quizá mediante un envío de mail.



---
## Permisos Basados en Roles

| **Rol**          | **Permisos**                                                                      |
|-------------------|-----------------------------------------------------------------------------------|
| **Admin** | Acceso completo a todas las funcionalidades de la aplicación.                   |
| **Manager**       | Gestiona productos, ventas y usuarios (excepto crear/modificar administradores). |
| **Employee**      | Acceso a la gestión de productos y ventas, sin permisos para gestionar usuarios. |

---


# Pasos para correr el proyecto:
## Clonar el repositorio
- git clone git@github.com:aguscabello/Avivas-Store.git
- cd Avivas-Store
## Instalar dependencias 
- bundle install
## Preparar la base de datos 
- rails db:create
- rails db:migrate
- rails db:seed
## Precompilar los archivos
- rails assets:precompile
## Correr el servidor
- rails server
