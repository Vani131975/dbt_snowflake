{% macro generate_surrogate_key(columns) %}

MD5(
    CONCAT(
        {% for column in columns %}
            COALESCE(CAST({{ column }} AS STRING), '')
            {% if not loop.last %}, '|', {% endif %}
        {% endfor %}
    )
)

{% endmacro %}
