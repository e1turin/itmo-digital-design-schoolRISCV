# schoolRISCV

Tiny RISCV CPU. Originally based on Sarah L. Harris MIPS CPU ("Digital Design
and Computer Arhitecture" by David Money Harris and Sarah L Harris) and
[schoolMIPS](https://github.com/MIPSfpga/schoolMIPS) project. Supports only a
subset of RISCV commands.

![schoolRISCV](https://raw.githubusercontent.com/wiki/zhelnio/schoolRISCV/img/schoolRISCV.gif)

## Docs

[HDL Tools Install](install/readme.md)

[Video (Russian)](https://www.youtube.com/watch?v=w1F6aHfiuZ0&list=PL7J5ZgBGsxn6rquSuWO07kUk_YJrQnXec)

[Slides (Russian)](https://raw.githubusercontent.com/wiki/zhelnio/schoolRISCV/doc/schoolRISCV_slides_ru.pdf)

[New Instruction Example (Russian)](https://raw.githubusercontent.com/wiki/zhelnio/schoolRISCV/doc/schoolRISCV_steps_ru.pdf)

[RISC-V ISA Specification](https://raw.githubusercontent.com/wiki/zhelnio/schoolRISCV/doc/riscv-spec-20191213.pdf)


- - -

# Комментарии по лабе

Репозиторий с исходниками можно форкнуть, и склонить себе на компьютер с любой ОС.
Для Windows потом можно использовать WSL, как предлагает автор репозитория, а можно
настроить себе разработку в Docker через devcontainer в VSCode или просто через терминал 
контейнера, примонтировав директорию с проектом внутрю него.

## Разработка с помощью Docker

Для удобства был составлен докер-файл
([Dockerfile.div-riscv-verilog](./Dockerfile.dev-schoolriscv)) с необходимыми
зависимостями.

### Используя терминал

Образ контейнера (с именем `dev-schoolriscv`) для разработки можно получить из
из докерфала так:

```shell
docker build -t dev-schoolriscv --file Dockerfile.dev-schoolriscv
```

Чтобы потом использовать собранный образ, нужно *создать* контейнер (с именем
`dev-schoolriscv-1`), в который примонтировать директорию с проектом
(например, `D:/Projects/schoolRISCV` на Windows в `/mnt/schoolRISCV` в контейнере):

```shell
docker run -it --name dev-schoolriscv-1 -v D:/Projects/schoolRISCV:/mnt/schoolRISCV/ dev-schoolRISCV /bin/bash
```

Чтобы потом *запустить* созданный контейнер, можно использовать команду:

```shell
docker start -ai dev-schoolriscv-1
```

### Используя devcontainer в VSCode

Настройка девконтейнера описана в мануале от Microsoft:
- https://code.visualstudio.com/docs/devcontainers/containers
    - https://code.visualstudio.com/docs/devcontainers/tutorial

Вкраце процесс выглядит так:

1. Поставить расширение ms-vscode-remote.remote-containers
2. Нажать на правый нижний угол VSCode (символ `><`), далее в выпадающем меню 
    1. выбрать "Reopen in container"
    2. выбрать любое, лучше "Add configuration to workspace"
    3. выбрать составленный Dockerfile "From 'Dockerfile.dev-schoolriscv'"

Дефолтная конфигурация появится в файле `.devcontainer/devcontainer.json`. 
Для удобства можно поставить нужные расширения:
- С/C++: `llvm-vs-code-extensions.vscode-clangd` или `ms-vscode.cpptools`, 
  lldb если нужно: `vadimcn.vscode-lldb`
- Assembler: `zhwu95.riscv`
- Verilog: `eirikpre.systemverilog`
- Makrfile: что-нибудь популярное, либо можно нормально пользоваться `make` из
  всторенного в vscode терминала.

По желанию можно настроить себе выполнения команд по кнопкам в VSCode с помощью конфигов
- `launch.json` (палета команд > создать конфигурацию или типа того либо попытаться 
  запустить по кнопке "Run & Debug")
- и `tasks.json` (палета команд > создать конфигурацию или типа того)
    - заметьте, что в `build` цель для C/C++ приложений нужно добавить ключ `-g` для 
      создания отладочных символов во время компиляции, а иначе не получится 
      использовать дебагер.



При этом важны моменты:
- утилита `sudo` нужна для запуска готовых make-скриптов.

gtkwave
- https://sourceforge.net/projects/gtkwave/
