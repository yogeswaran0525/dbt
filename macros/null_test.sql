{% macro not_null(model,columns) %}

    select {{columns}}
    from {{ ref(model) }}
    where {{columns}} is null

{% endmacro %}