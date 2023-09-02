FROM ubuntu:latest
RUN apt update && apt install openssh-server sudo -y
# Create a user "sshuser" and group "sshgroup"
RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
# Create sshuser directory in home
RUN mkdir -p /home/sshuser/.ssh
# Copy the ssh public key in the authorized_keys file
COPY sshkey.pub /home/sshuser/.ssh/authorized_keys
# Change ownership and permissions of the key file
RUN chown sshuser:sshgroup /home/sshuser/.ssh/authorized_keys && chmod 600 /home/sshuser/.ssh/authorized_keys
# Add sshuser to the sudo group
RUN usermod -aG sudo sshuser
# set password
ARG SUDO_PASSWORD
RUN echo "sshuser:$SUDO_PASSWORD" | chpasswd
# Start SSH service
RUN service ssh start
# Expose docker port 22
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
