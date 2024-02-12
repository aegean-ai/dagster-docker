from dagster import job, FilesystemIOManager
from dagster_docker import docker_executor
from .ops import my_op, my_graph


@job
def my_pipeline():
    my_op()

my_job = my_graph.to_job(name="my_job")

my_step_isolated_job = my_graph.to_job(
    name="my_step_isolated_job",
    executor_def=docker_executor,
    resource_defs={"io_manager": FilesystemIOManager(base_dir="/tmp/io_manager_storage")},
)


