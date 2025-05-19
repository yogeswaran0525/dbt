{% macro incr() %}

where LOAD_TIME > (select coalesce(max(LOAD_TIME),'1900-01-01 00:00:00')from {{this}})

{% endmacro %}