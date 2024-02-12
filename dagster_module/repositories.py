from dagster import Definitions, load_assets_from_modules
from dagster import repository 
import dagster_module
from dagster_module.jobs import my_pipeline
from dagster_module.schedules import my_schedule


# Import other components like schedules and sensors as needed
from dagster_module.jobs import my_job, my_step_isolated_job

@repository
def my_repository():
    return [my_pipeline]
    # You can also return schedules, sensors, and assets here

@repository
def deploy_docker_repository():
    return [my_step_isolated_job]

