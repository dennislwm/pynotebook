#
# Example:
#   CMD> docker run -v <hostdir>:<dockerdir> --name <customname> -e DISPLAY=$DISPLAY -it <imagename>:<tag>
#

# Assert Anaconda 64-bit
FROM continuumio/anaconda3

RUN \
  apt-get update \
  && apt-get install build-essential --yes

RUN \
  wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
  && tar -xzf ta-lib-0.4.0-src.tar.gz \
  && cd ta-lib \
  && ./configure --prefix=/usr \
  && make \
  && make install \
  && ldconfig

RUN \
  pip install notebook \
  && opt/conda/bin/pip install backtrader[plotting] sklearn ta-lib \
  && opt/conda/bin/conda install statsmodels seaborn

RUN \
  opt/conda/bin/conda update conda \
  && opt/conda/bin/conda update --all \
  && opt/conda/bin/conda init bash

CMD [ "jupyter", "notebook", "--ip=0.0.0.0", "--allow-root" ]

# Assert Open port
EXPOSE 8888