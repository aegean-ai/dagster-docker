# syntax=docker/dockerfile:1.4

FROM mcr.microsoft.com/devcontainers/python:dev-3.10-bullseye as base

# Checkout and install dagster libraries needed to run the gRPC server
# exposing your repository to dagster-webserver and dagster-daemon, and to load the DagsterInstance

# Replace these with your actual UID and GID
# id -u  # Returns your UID
# id -g  # Returns your GID
ARG USER_UID=1001
ARG USER_GID=3000

# Install necessary packages for user modification
RUN apt-get update && apt-get install -y sudo

# Change the vscode user's UID and GID
RUN if [ ${USER_UID} -ne 1000 ] && [ ${USER_GID} -ne 1000 ]; then \
        groupmod --gid ${USER_GID} vscode && \
        usermod --uid ${USER_UID} --gid ${USER_GID} vscode && \
        chown -R ${USER_UID}:${USER_GID} /home/vscode; \
    fi
# Add sudo support for the USERNAME user
ENV USERNAME=vscode

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
  && chmod 0440 /etc/sudoers.d/$USERNAME

# Checkout and install dagster libraries needed to run the gRPC server
# exposing your repository to dagster-webserver and dagster-daemon, and to load the DagsterInstance

USER vscode
WORKDIR /workspaces/dagster-docker

COPY --chown=vscode:vscode . . 
#RUN sudo chown -R vscode:vscode /opt/dagster

ENV PATH="/home/vscode/.local/bin:$PATH"

RUN pip install --upgrade pip && \
    pip install pipenv  && \
    pipenv lock && \
    pipenv install  --system --ignore-pipfile && \ 
    # --deploy can be added to pipenv install for production
    pipenv --clear

# Run dagster gRPC server on port 4000
EXPOSE 4000

# CMD allows this to be overridden from run launchers or executors that want
# to run other commands against your repository
CMD ["dagster", "api", "grpc", "-h", "0.0.0.0", "-p", "4000", "-m", "dagster_module"]
