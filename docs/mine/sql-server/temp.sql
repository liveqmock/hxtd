# update hxtd.sm_user set is_deleted=0


# update sm_function set url = null where url='';
# CREATE UNIQUE INDEX INDEX_URL ON hxtd.sm_function ( URL );

select url,count(*) as count from sm_function group by url having count>1;