FROM python:3.5.2
LABEL MAINTAINER Xavier Bruhiere <xavier.bruhiere@gmail.com>

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# mkdocs port
EXPOSE 3000
