build:
	docker build -t toolcase .

run:
	docker run -it toolcase

bash:
	docker run -it --entrypoint '' toolcase bash
