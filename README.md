# Docker jusbrasil/python-web

Docker base image for Python web applications in JusBrasil.



### Installed Packages

Python:
  - gunicorn 
  - nose
  - mock
  - pytest
  
Node:
  - lessc@1.3.3
  - phathomjs

## Usage

For example, you can write an `app.py` Flask application:

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello World!\n'

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
```

Then, configure your Python dependencies in `requirements.txt`:

```
Flask==0.10.1
```

Next, up, `Dockerfile`:

```docker
# Dockerfile
FROM jusbrasil/python-web

CMD ['python', 'app.py']
```

