FROM kalilinux/kali-rolling

# Update and apt install programs
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get install -y \
 exploitdb \
 exploitdb-bin-sploits \
 git \
 gdb \
 gobuster \
 hashcat \
 hydra \
 man-db \
 minicom \
 nasm \
 nmap \
 sqlmap \
 sslscan \
 wordlists

RUN apt install -y curl

RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew \
&& mkdir ~/.linuxbrew/bin \
&& ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin \
&& eval $(~/.linuxbrew/bin/brew shellenv) \
&& brew --version

RUN export PATH=$HOME/.linuxbrew/bin:$PATH



# Create known_hosts for git cloning
RUN mkdir /root/.ssh/
RUN touch /root/.ssh/known_hosts

# Add host keys
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Clone git repos
RUN git clone https://github.com/danielmiessler/SecLists.git /opt/seclists
RUN git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/powersploit


RUN apt -y install kali-linux-large

