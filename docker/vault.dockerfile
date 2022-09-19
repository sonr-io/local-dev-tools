FROM golang:1.18 as base
ARG PORT=8888
USER root
RUN useradd -ms /bin/bash sonr-vault-user
ARG SONR_VAULT_CODE
COPY ${SONR_VAULT_CODE} /sonr-vault
RUN chown -R sonr-vault-user /sonr-vault
USER sonr-vault-user
RUN cd /sonr-vault && go mod download && go mod verify && go build -o sonr-vault ./src
WORKDIR /sonr-vault
ENTRYPOINT ["./sonr-vault"]
#ENTRYPOINT ["/bin/ls","-la","."]

