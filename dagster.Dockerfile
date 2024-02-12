# syntax=docker/dockerfile:1.4

FROM mcr.microsoft.com/devcontainers/python:dev-3.10-bullseye as base


RUN pip install \
    dagster \
    dagster-graphql \
    dagster-webserver \
    dagster-postgres \
    dagster-docker

ENV DAGSTER_HOME=/opt/dagster/dagster_home/

RUN mkdir -p $DAGSTER_HOME

COPY dagster.yaml workspace.yaml $DAGSTER_HOME
RUN chown -R vscode:vscode /opt/dagster

WORKDIR $DAGSTER_HOME
