# ========== #
# Simples OS #
# ========== #

## Configurações Gerais ##

# Aqui configuramos os nomes das ferramentas
ASSEMBLER_NAME = nasm
COMPILER_NAME = gcc
LINKER_NAME = ld
EMULATOR_NAME = qemu-system-x86_64

# Aqui configuramos os diretórios
TESTS_DIR = tests

# Aqui configuramos os parametros
DOS_IMG = $(TESTS_DIR)/dos.img
EMULATOR_FLAGS = -drive if=floppy,index=0,format=raw,read-only=on,file=$(DOS_IMG)

## Ferramentas ##

# Aqui obtemos os nomes completos das ferramentas
ASSEMBLER = $(shell which $(ASSEMBLER_NAME))
COMPILER = $(shell which $(COMPILER_NAME))
LINKER = $(shell which $(LINKER_NAME))
EMULATOR = $(shell which $(EMULATOR_NAME))
DOS_IMG_FILE = $(shell ls $(DOS_IMG) 2> /dev/null)

## Checagens das ferramentas ##

# Assembler
ifeq ("$(ASSEMBLER)", "")
assembler_error:
	@echo >&2
	@echo >&2 "Não foi possível encontrar o assembler: $(ASSEMBLER_NAME)"
	@echo >&2
	@exit 1
endif

# Compiler
ifeq ("$(COMPILER)", "")
compiler_error:
	@echo >&2
	@echo >&2 "Não foi possível encontrar o compilador: $(COMPILER_NAME)"
	@echo >&2
	@exit 1
endif

# Linker
ifeq ("$(LINKER)", "")
linker_error:
	@echo >&2
	@echo >&2 "Não foi possível encontrar o linker: $(LINKER_NAME)"
	@echo >&2
	@exit 1
endif

# Emulator
ifeq ("$(EMULATOR)", "")
emulator_error:
	@echo >&2
	@echo >&2 "Não foi possível encontrar o emulador: $(EMULATOR_NAME)"
	@echo >&2
	@exit 1
endif

# Arquivo de imagem
ifeq ("$(DOS_IMG_FILE)", "")
dosimg_error:
	@echo >&2
	@echo >&2 "Não foi possível encontrar o arquivo de imagem: $(DOS_IMG)"
	@echo >&2
	@echo >&2 "Faça o download de uma imagem do MS-DOS e renomeie para $(DOS_IMG)"
	@echo >&2
	@exit 1	
endif

.PHONY: all run

all: run

run:
	$(EMULATOR) $(EMULATOR_FLAGS)