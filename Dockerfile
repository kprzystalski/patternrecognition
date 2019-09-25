FROM ubuntu:18.04

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

RUN apt update && apt install -y \
  jupyter-core \
  jupyter-notebook \
  python3-pip \
  wget \
  vim \
  git \
  graphviz


RUN pip3 install \
  seaborn \
  pydot \
  scipy \
  numpy \
  requests \
  matplotlib \
  pandas \
  sklearn \
  pydub\
  six \
  tensorflow \
  tensorlayer \
  keras \
  scipy \
  tensorboard \
  jupyter-tensorboard

EXPOSE 8888
EXPOSE 9000
EXPOSE 5000
EXPOSE 5050
EXPOSE 6006

RUN jupyter-tensorboard enable --system
RUN useradd -ms /bin/bash codete
RUN adduser codete sudo

USER codete
WORKDIR /home/codete/
RUN mkdir /home/codete/workshop/
RUN mkdir /home/codete/workshop/tensorboard/
RUN mkdir /home/codete/workshop/tensorboard/logs/
RUN tensorboard --logdir /home/codete/workshop/tensorboard/logs/ &
CMD jupyter-notebook --ip=0.0.0.0 --NotebookApp.token='' --NotebookApp.password='' --no-browser --notebook-dir=/home/codete/workshop/
