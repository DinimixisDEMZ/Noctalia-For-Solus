# 📦 Noctalia para Solus
### Colección de paquetes experimentales y personales

[![Solus](https://img.shields.io/badge/OS-Solus-blue?style=flat-square&logo=solus&logoColor=white)](https://getsol.us/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

## Propósito
El objetivo principal de este repositorio es garantizar la **disponibilidad de paquetes esenciales** necesarios para el software y herramientas (Ej: `noctalia-qs`) para el ecosistema de Solus.

## Índice de Paquetes
| 📦 Paquete | ⚖️ Licencia | 🏷️ Versión | 📥 Binario | 📅 Revisión |
| :--- | :---: | :---: | :---: | :---: |
| [**brightnessctl**](https://github.com/Hummer12007/brightnessctl) | [![MIT](https://img.shields.io/badge/MIT-gray?style=flat-square)](https://opensource.org/licenses/MIT) | [![v0.5.1](https://img.shields.io/badge/0.5.1-blue?style=flat-square)](https://github.com/Hummer12007/brightnessctl/releases/tag/0.5.1) | [![EOPKG](https://img.shields.io/badge/Download-181717?style=flat-square&logo=solus&logoColor=white)](https://github.com/DinimixisDEMZ/Custom-Solus-Repo/blob/master/brightnessctl/brightnessctl-0.5.1-1-1-x86_64.eopkg) | ![Date](https://img.shields.io/badge/2026--01--28-lightgray?style=flat-square) |
| [**noctalia-qs**](https://github.com/noctalia-dev/noctalia-qs) | [![GPL--3.0](https://img.shields.io/badge/GPL--3.0-gray?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0) | [![v0.0.5](https://img.shields.io/badge/0.0.5-blue?style=flat-square)](https://github.com/noctalia-dev/noctalia-qs/releases/tag/v0.0.5) | [![GitHub](https://img.shields.io/badge/Download-181717?style=flat-square&logo=solus&logoColor=white)](https://github.com/DinimixisDEMZ/Custom-Solus-Repo/blob/master/noctalia-qs/noctalia-qs-0.0.5-1-1-x86_64.eopkg) | ![Date](https://img.shields.io/badge/2026--03--05-lightgray?style=flat-square) |
| [**wlsunset**](https://github.com/kennylevinsen/wlsunset) | [![MIT](https://img.shields.io/badge/MIT-gray?style=flat-square)](https://opensource.org/licenses/MIT) | [![v0.4.0](https://img.shields.io/badge/0.4.0-blue?style=flat-square)](https://github.com/kennylevinsen/wlsunset/releases/tag/0.4.0) | [![GitHub](https://img.shields.io/badge/Download-181717?style=flat-square&logo=solus&logoColor=white)](https://github.com/DinimixisDEMZ/Custom-Solus-Repo/blob/master/wlsunset/wlsunset-0.4.0-1-1-x86_64.eopkg) | ![Date](https://img.shields.io/badge/2026--01--30-lightgray?style=flat-square) |

## Instalación
Para instalar los paquetes manualmente, descarga el archivo `.eopkg` y ejecuta:
```bash
sudo eopkg it ./nombre-del-paquete.eopkg
```

## Construir | Generar EOPKG Manualmente
- **Clonar** el repositorio: `git clone https://github.com/DinimixisDEMZ/Noctalia-For-Solus`
- **Dirigirse** al "directorio" ej: `cd noctalia-qs`
- **Construir** con **solbuild**: `sudo solbuild package.yml`
- Luego **instalar** el .eopkg generado, ej: `sudo eopkg it ./noctalia-qs-0.0.5-1-1-x86_64.eopkg`

