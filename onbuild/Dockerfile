FROM jusbrasil/python-web:0.5

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD RUN pip install -r requirements.txt

ONBUILD COPY . /usr/src/app
