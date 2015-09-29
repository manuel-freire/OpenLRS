FROM maven

ENV APP_NAME="openlrs" \
    REPO_URL="https://github.com/e-ucm/OpenLRS" \
    REPO_TAG="master" \
    USER_NAME="user" \
    WORK_DIR="/app"

# setup user & group
RUN groupadd -r "$USER_NAME" \
    && useradd -r -g "$USER_NAME" "$USER_NAME"

# retrieve sources & setup workdir
RUN mkdir ${WORK_DIR} \
    && git clone -b "$REPO_TAG" --single-branch ${REPO_URL} ${WORK_DIR}
WORKDIR ${WORK_DIR}

# get dependencies sorted out
RUN mvn clean package

# run (may lookup env. variables to make links work)
EXPOSE 8080
CMD [ "run.sh" ]

# EXPECTS: Mongo at 27017, Redis at 6379
