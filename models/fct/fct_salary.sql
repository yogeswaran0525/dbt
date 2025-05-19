{{
    config(
        materialized = 'incremental',
        unique_key = 'EMPLOYEE_ID',
        incremental_strategy = 'delete+insert',
        tags = ['fct'],
        schema = 'fct'
    )
}}

{% set x = "(select coalesce(max(load_time),'1900-01-01 00:00:00')from "~this~")" %}

SELECT 
    EMP.EMPLOYEE_ID,
    EMP.JOB_ID,
    DEPT.DEPARTMENT_ID,
    LOC.LOCATION_ID,
    CON.COUNTRY_ID,
    REG.REGION_ID,
    SALARY_DATE,
    EMP.SALARY,
    HRA,
    ALLOWANCES,
    PF,
    (EMP.SALARY + HRA + ALLOWANCES + pf) AS GROSS_SALARY,
    (EMP.SALARY + HRA + ALLOWANCES) AS NET_SALARY,
    CURRENT_TIMESTAMP AS LOAD_TIME
FROM {{ ref('stg_salary') }} as sal
LEFT JOIN {{ ref('dim_employees') }} as EMP
ON SAL.EMPLOYEE_ID = EMP.EMPLOYEE_ID
left join {{ ref('dim_departments') }} as DEPT
on EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
LEFT JOIN {{ ref('dim_locations') }} AS LOC
ON LOC.LOCATION_ID = DEPT.LOCATION_ID
LEFT JOIN {{ ref('dim_countries') }} AS CON
ON CON.COUNTRY_ID = LOC.COUNTRY_ID
LEFT JOIN {{ ref('dim_regions') }} AS REG
ON REG.REGION_ID = CON.REGION_ID
LEFT JOIN {{ ref('dim_jobs') }} AS JOBS
ON JOBS.JOB_ID = EMP.JOB_ID

{% if is_incremental() %}

where sal.load_time > {{ x }}
or emp.load_time > {{ x }}
or dept.load_time > {{ x }}
or loc.load_time > {{ x }}
or con.load_time > {{ x }}
or reg.load_time > {{ x }}
or jobs.load_time > {{ x }}

{% endif %}