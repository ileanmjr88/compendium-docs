---
title: Preguntas frecuentes (FAQ)
description: Preguntas comunes sobre Compendium y cómo se compara con otras herramientas.
---

Preguntas comunes sobre Compendium y cómo se compara con otras herramientas. Respuestas cortas; la documentación cubre los detalles.

## ¿Por qué no Nix?

Nix es más potente y más general. Puede hacer todo lo que hace Compendium y más: builds herméticos de verdad, gestión completa del sistema operativo, rollbacks atómicos. Pero le pide mucho de entrada: el lenguaje Nix, el modelo de store, los flakes.

Compendium es más acotado a propósito. Un TOML, un binario de Go, se aprende en cinco minutos. Binarios precompilados y seleccionados desde upstream en vez de compilar desde el código fuente. Soporte de primera clase para toolchains embebidos (arm-none-eabi-gcc, OpenOCD, vcpkg), que en Nix son posibles pero dolorosos.

**Versión corta:** Nix si quiere la reproducibilidad más profunda y no le importa la curva. Compendium si quiere a su equipo productivo el mismo día con un TOML y un solo binario.

## ¿Por qué no Docker o Podman?

Los contenedores resuelven un problema distinto, y ambos se combinan bien. Docker es genuinamente excelente para resucitar proyectos viejos donde lo único que puede fijar es "la época de Ubuntu 18.04 y rezar", y para aislamiento a nivel del sistema operativo cuando necesita un artefacto desplegable.

Compendium es para proyectos que está desarrollando activamente hoy, donde quiere un ciclo de desarrollo nativo y rápido, acceso USB para placas, y un TOML en el repositorio que usted en el futuro (o un nuevo compañero de equipo) pueda clonar y con el que sea productivo en cinco minutos sin levantar un contenedor.

**Versión corta:** Docker para revivir proyectos legacy o publicar imágenes. Compendium para gestionar los proyectos activos.

## ¿Por qué no devcontainers?

Un caso de uso justo para Docker. Los devcontainers logran el aislamiento del proyecto a través del contenedor.

Compendium logra el mismo resultado mediante directorios con espacio de nombres por versión y gestión del PATH. El mismo aislamiento por proyecto, sin el overhead del contenedor, acceso USB nativo, velocidad nativa del sistema de archivos, y sin estar acoplado al ecosistema de un solo editor.

**Versión corta:** Devcontainers si su equipo está atado a VS Code y Docker. Compendium si quiere la misma reproducibilidad sin la capa del contenedor ni el lock-in del editor.

## ¿Por qué no asdf o mise?

asdf y mise son excelentes para gestionar runtimes de lenguajes de scripting. Ambos manejan bien Node, Python, Ruby y Go. Si eso cubre todo lo que necesita, son opciones sólidas.

La brecha son los compiladores. Ninguno maneja en serio GCC, Clang, arm-none-eabi-gcc, ni riscv-none-elf-gcc, que es exactamente donde el dolor de configuración es más profundo. Compendium trata los compiladores y los toolchains embebidos como ciudadanos de primera clase, igual que asdf trata a Node.

**Versión corta:** asdf o mise si solo trabaja en lenguajes de scripting. Compendium si su proyecto toca C, C++ o embebidos.

## ¿Por qué no Homebrew?

Homebrew instala la última versión de lo que tenga, en una ruta de todo el sistema, compartida por cada proyecto de su máquina. Eso es lo opuesto a lo que necesitan los entornos reproducibles. Dos proyectos que necesitan versiones distintas de Go, o versiones distintas de CMake, no pueden estar ambos contentos con Homebrew.

Compendium fija por proyecto. Proyectos distintos, toolchains distintos, sin conflictos, sin sudo, nada en `/usr/local/`.

**Versión corta:** Homebrew para herramientas del sistema. Compendium para los toolchains del proyecto.

## ¿Por qué no un Makefile o un script de setup?

Un script de setup es exactamente lo que Compendium está reemplazando. Todo equipo tiene uno y todos se pudren de la misma forma. Instalan lo que el gestor de paquetes tenga hoy, que se desvía de lo que funcionó ayer. Se rompen en una laptop nueva porque la dependencia que el script asumía no está. Están escritos para un sistema operativo y fallan en silencio en otro. Se desactualizan más rápido que el README que los documenta.

Compendium le da el mismo resultado (un entorno funcional desde un clon nuevo), pero las versiones están fijadas, verificadas por checksum y son consistentes en macOS y Linux.

**Versión corta:** Un script de setup es una lista de TODO de cosas por instalar. Compendium es un contrato.

## ¿No entrarán en conflicto los proyectos con dependencias distintas?

No, por diseño.

Cada proyecto fija versiones en su propio `compendium.toml`. Las instalaciones viven bajo `~/.local/compendium/` en carpetas con espacio de nombres por versión (`languages/go/1.26.1/`, `tools/cmake/4.3.1/`). La misma versión entre proyectos significa una sola instalación compartida. Versiones distintas significan carpetas distintas, sin conflicto.

El estado por proyecto (venvs de Python, bibliotecas de vcpkg, workspaces de Go) vive bajo `envs/<project>/`, completamente aislado. Activate antepone las rutas del proyecto actual al PATH; deactivate las restaura. Cambiar de proyecto es `cd` más `source <(compendium activate)`.

## ¿Esto reemplaza mi gestor de versiones actual?

Para los lenguajes y herramientas que Compendium cubre, sí. Para las herramientas que no cubre, no, siga usando lo que funcione. Compendium no intenta ser lo único en su PATH; intenta ser la fuente de verdad para el toolchain del que su proyecto realmente depende.

En la práctica, la mayoría elimina su configuración de nvm, pyenv o asdf para los proyectos que usan Compendium, y los conserva para trabajo ad-hoc en proyectos personales que no tienen un `compendium.toml`. Ambos pueden coexistir.

## ¿Funciona en Windows?

Actualmente no. Solo macOS y Linux. El panorama de toolchains de Windows (MSVC, WSL, MSYS2, el árbol de Windows de vcpkg) es su propio mundo, y soportarlo bien significaría mucho trabajo que no ayuda a los usuarios de C/C++ y embebidos en Linux/macOS que son el foco actual.

WSL debería funcionar ya que por debajo es Linux, aunque todavía no se ha probado. El soporte nativo de Windows es algo para retomar una vez que la historia de Linux y macOS esté más madura.
