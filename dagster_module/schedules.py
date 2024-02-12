from dagster import schedule
from .jobs import my_job

@schedule(cron_schedule="* * * * *", job=my_job, execution_timezone="US/Eastern")
def my_schedule(_context):
    return {}

