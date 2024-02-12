from dagster import Definitions, load_assets_from_modules
from dagster_aws.s3 import S3PickleIOManager, S3Resource


from . import assets

S3_IO_MANAGER_CONFIG = {
    "s3_bucket": {"env": "DAGSTER_S3_BUCKET"},
    "s3_prefix": "io_manager",
}

S3_SESSION_CONFIG = {
    "endpoint_url": {"env": "DAGSTER_S3_ENDPOINT_URL"},
}

all_assets = load_assets_from_modules([assets])

defs = Definitions(
    assets=all_assets,
    resources={
        "io_manager": S3PickleIOManager(
            s3_resource=S3Resource(
                aws_secret_access_key="GIDBgT4TEofJrrWcJa2VlBiNtRV2BxFwbu9T6vx8",
                aws_access_key_id="VsMIbuAOXAqZ4nh0QTok",
                region_name="us-east-1",
                endpoint_url="http://minio:9000",
                # endpoint_url="http://192.168.1.74:9000",
            ),
            s3_bucket="dagster-assets"
        ),
    },
)
