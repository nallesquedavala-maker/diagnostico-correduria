# Base de datos del Diagnóstico (Supabase)

Guía para conectar tu formulario `diagnostico_fase1_v2_iconos_descarga.html`
con una base de datos Supabase. Cualquier persona, desde cualquier
computadora, podrá llenar el formulario y sus datos se guardarán ahí.

Los datos se guardan con **columnas separadas** (nombres, puntajes,
viabilidad, fecha) para consultarlos fácil, más una columna **`datos`**
en formato JSON con el diagnóstico completo como respaldo.

---

## Paso 1 · Crea el proyecto

1. Entra a <https://supabase.com> e inicia sesión.
2. **New project** → elige tu organización, ponle nombre
   (ej. *diagnostico-correduria*), define una contraseña de base de datos
   (guárdala) y la región más cercana (ej. *East US*).
3. Espera ~2 minutos a que el proyecto termine de aprovisionarse.

> Nota free tier: se permiten hasta 2 proyectos activos y los proyectos se
> pausan tras ~1 semana sin uso (se reactivan desde el panel).

## Paso 2 · Crea la tabla

1. En el panel del proyecto, menú izquierdo → **SQL Editor**.
2. Clic en **New query**.
3. Abre el archivo **`supabase-tabla.sql`** (está en esta carpeta), copia
   **todo** su contenido, pégalo y haz clic en **Run** (▶).
4. Debe decir *Success*. Esto crea la tabla `diagnosticos` y la regla de
   seguridad que permite insertar desde el formulario.

## Paso 3 · Copia tus claves

1. Menú izquierdo → **Project Settings** (engrane) → **API**.
2. Copia dos valores:
   - **Project URL** → algo como `https://abcdxyz.supabase.co`
   - **Project API keys → `anon` `public`** → una cadena larga.

> La **anon key es pública** y está pensada para usarse en el navegador.
> Con la regla del Paso 2 solo permite **insertar**, no leer ni borrar, así
> que es segura para este formulario.

## Paso 4 · Pega las claves en el HTML

1. Abre `diagnostico_fase1_v2_iconos_descarga.html`.
2. Cerca del inicio del `<script>` busca estas líneas:

   ```js
   const SUPABASE_URL='';
   const SUPABASE_ANON_KEY='';
   ```

3. Pega tus valores:

   ```js
   const SUPABASE_URL='https://abcdxyz.supabase.co';
   const SUPABASE_ANON_KEY='eyJhbGciOi....(tu anon key)';
   ```

4. Guarda el archivo.

## Paso 5 · Pruébalo

1. Abre el formulario, llena al menos un formulario (Corredor, Colaborador o
   Administrador) y dale **Guardar**.
2. Baja al tablero y haz clic en **Enviar a base de datos**.
3. Debe aparecer *"Diagnóstico enviado correctamente"*.
4. En Supabase: menú izquierdo → **Table Editor** → tabla **diagnosticos**.
   Verás una fila nueva por cada envío.

---

## Notas

- **Cada clic en "Enviar"** crea una fila nueva (un envío = una fila).
- `created_at` guarda la fecha y hora exacta de cada envío.
- La columna `datos` (JSON) contiene TODO el detalle del diagnóstico, por si
  algún dato no quedó en una columna propia.
- A diferencia de un archivo, aquí los datos quedan centralizados: varias
  personas en distintas PCs envían a la misma base.
- Si el envío falla, el formulario te mostrará el error exacto (código HTTP),
  útil para diagnosticar (claves mal pegadas, tabla no creada, etc.).
