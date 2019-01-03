SELECT 'Upgrading MetaStore schema from 3.2.0 to 4.0.0' AS MESSAGE;

-- HIVE-19416
ALTER TABLE TBLS ADD WRITE_ID bigint  NOT NULL DEFAULT 0;
ALTER TABLE PARTITIONS ADD WRITE_ID bigint  NOT NULL DEFAULT 0;

-- HIVE-20793
ALTER TABLE WM_RESOURCEPLAN ADD NS nvarchar(128);
UPDATE WM_RESOURCEPLAN SET NS = 'default' WHERE NS IS NULL;
DROP INDEX UNIQUE_WM_RESOURCEPLAN ON WM_RESOURCEPLAN;
CREATE UNIQUE INDEX UNIQUE_WM_RESOURCEPLAN ON WM_RESOURCEPLAN ("NS", "NAME");

-- HIVE-21077
ALTER TABLE DBS ADD CREATE_TIME BIGINT;
ALTER TABLE CTLGS ADD CREATE_TIME BIGINT;
-- These lines need to be last.  Insert any changes above.
UPDATE VERSION SET SCHEMA_VERSION='4.0.0', VERSION_COMMENT='Hive release version 4.0.0' where VER_ID=1;
SELECT 'Finished upgrading MetaStore schema from 3.2.0 to 4.0.0' AS MESSAGE;

