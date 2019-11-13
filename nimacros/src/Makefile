APP=

ifeq ($(APP),)
abort:
	@echo Usage: make APP=sourceFile
endif

all:
	nim c -o:$(APP).x -d:danger --hints:off --nimcache:xx $(APP).nim

ifeq ($(APP),)
clean:
	@echo Usage: make clean APP=file without extension
else
clean:
	rm -rf $(APP).x lixo
endif

