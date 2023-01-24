FROM python:latest

COPY hello.py /

CMD [ "python3" , "hello.py" ]
