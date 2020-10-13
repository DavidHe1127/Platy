# we build a new image on top to be able to inject private key into image from where git operations can work under ssh connection
FROM buildkite/agent

ARG SSH_KEY

RUN mkdir /root/.ssh/

# Dangerous! but ok for this trial
RUN echo "$SSH_KEY" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
