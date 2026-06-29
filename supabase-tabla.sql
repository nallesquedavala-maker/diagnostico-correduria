-- ============================================================
--  Base de datos del Diagnóstico Fase 1 · Supabase
--  Pega TODO esto en el SQL Editor de tu proyecto y ejecútalo.
-- ============================================================

-- 1) Tabla con columnas clave + respaldo JSON completo.
create table if not exists public.diagnosticos (
  id                  bigint generated always as identity primary key,
  created_at          timestamptz not null default now(),
  fecha               text,
  corredor_nombre     text,
  colaborador_nombre  text,
  administrador_nombre text,
  score_corredor      int,
  score_juridico      int,
  score_admin         int,
  viabilidad          int,
  datos               jsonb           -- diagnóstico completo (respaldo)
);

-- 2) Activar seguridad a nivel de fila (Row Level Security).
alter table public.diagnosticos enable row level security;

-- 3) Permitir SOLO insertar (enviar formularios) desde el navegador.
--    No se permite leer/editar/borrar con la anon key: los datos
--    quedan protegidos y solo se ven desde el panel de Supabase.
drop policy if exists "permitir_insertar_anon" on public.diagnosticos;
create policy "permitir_insertar_anon"
  on public.diagnosticos
  for insert
  to anon
  with check (true);
