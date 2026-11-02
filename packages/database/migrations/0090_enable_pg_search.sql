-- Custom SQL migration file, put your code below! --
-- pg_search is deprecated on Neon; skip it instead of failing the migration.
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'pg_search') THEN
    BEGIN
      CREATE EXTENSION IF NOT EXISTS pg_search;
    EXCEPTION WHEN OTHERS THEN
      RAISE NOTICE 'pg_search could not be created (%); skipping BM25 search setup', SQLERRM;
    END;
  ELSE
    RAISE NOTICE 'pg_search is not available on this database; skipping BM25 search setup';
  END IF;
END $$;
