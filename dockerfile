FROM openjdk:17-jdk-slim

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && \
    apt-get install -y python3 python3-pip build-essential curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/local/openjdk-17
ENV PATH=$JAVA_HOME/bin:$PATH
ENV HADOOP_USER_NAME=root


COPY requirements.txt .
RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

COPY . .

EXPOSE 8888 8501

CMD ["bash"]

#  ############################################################

# FROM openjdk:17-slims

# ENV DEBIAN_FRONTEND=noninteractive
# WORKDIR /app

# # Instala dependências
# RUN apt-get update && \
#     apt-get install -y python3 python3-pip curl wget build-essential openjdk-17-jdk-headless && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

# # Define variáveis de ambiente do Java
# ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
# ENV PATH=$JAVA_HOME/bin:$PATH

# # Instala Hadoop (mirror confiável)
# ENV HADOOP_VERSION=3.3.6
# RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
#     tar -xvzf hadoop-${HADOOP_VERSION}.tar.gz && \
#     mv hadoop-${HADOOP_VERSION} /opt/hadoop && \
#     rm hadoop-${HADOOP_VERSION}.tar.gz

# # Variáveis do Hadoop e PySpark
# ENV HADOOP_HOME=/opt/hadoop
# ENV PATH=$HADOOP_HOME/bin:$PATH
# ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
# ENV PYSPARK_PYTHON=python3
# ENV PYSPARK_DRIVER_PYTHON=python3
# ENV HADOOP_USER_NAME=root

# # Copia e instala dependências do Python
# COPY requirements.txt .
# RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# # Copia o restante da aplicação
# COPY . .

# # Exposição de portas para Jupyter e Streamlit
# EXPOSE 8888 8501

# CMD ["bash"]


# ###################################################################
# FROM openjdk:17-jdk-slim

# ENV DEBIAN_FRONTEND=noninteractive

# WORKDIR /app

# RUN apt-get update && \
#     apt-get install -y python3 python3-pip build-essential curl && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

# ENV JAVA_HOME=/usr/local/openjdk-17
# ENV PATH=$JAVA_HOME/bin:$PATH
# ENV HADOOP_USER_NAME=root
# ENV PYSPARK_PYTHON=python3
# ENV PYSPARK_DRIVER_PYTHON=python3


# COPY requirements.txt .
# RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# COPY . .

# EXPOSE 8888 8501

# CMD ["bash"]


# ###################################################################

