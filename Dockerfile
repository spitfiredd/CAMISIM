FROM python:3.11-buster
ENV PYTHONUNBUFFERED 1

# install perl packages
RUN apt update && apt install -y perl libncursesw5 && apt-get clean
RUN perl -MCPAN -e 'install XML::Simple'

# Setup non system python distribution
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /camisim/
COPY ./requirements.txt /camisim/requirements.txt
RUN python -m pip install -r requirements.txt

COPY . .

# add workdir to path
ENV PATH="/camisim:$PATH"
