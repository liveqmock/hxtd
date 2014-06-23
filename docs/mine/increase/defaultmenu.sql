ALTER TABLE hxtd.sm_menu ADD DEFAULT_SHOW boolean DEFAULT 0 NOT NULL;
UPDATE hxtd.sm_menu set DEFAULT_SHOW=1 where id=2;