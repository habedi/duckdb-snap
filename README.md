# A Snap Package for DuckDB

<img src="logo.jpeg" align="right" width="35%"/>

[![Build](https://github.com/habedi/duckdb-snap/actions/workflows/build.yml/badge.svg)](https://github.com/habedi/duckdb-snap/actions/workflows/build.yml)
[![Snapcraft.io](https://snapcraft.io/duckdb/badge.svg)](https://snapcraft.io/duckdb)
[![License](https://img.shields.io/badge/License-MIT-yellow)](https://github.com/habedi/duckdb-snap/blob/main/LICENSE)

This repository contains the source code for building a Snap package (called a `snap`) from the latest stable
release of [DuckDB](https://github.com/duckdb/duckdb/releases/).

I made this package to make it easier to install DuckDB on different GNU/Linux distributions like Debian, Ubuntu,
Fedora, etc. and to keep it up-to-date.
Currently, the package is built for the `amd64` architecture only.

**Note that this is an unofficial Snap package for DuckDB.**

Please use the [Issues page](https://github.com/habedi/duckdb-snap/issues) to report bugs.

## Installation

```bash
# Install the Snap package from the Snap Store
sudo snap install duckdb --stable
```

```bash
# Manually connect the removable-media interface to access files on removable media

# (if you get `permission denied errors` when trying to access files outside the home directory)
sudo snap connect duckdb:removable-media

# (if you get `error: unable to open database ":memory:": io error: cannot open file...`)
sudo snap connect duckdb:system-observe 
```

## Development

```bash
# Install Snap, Snapcraft, and Multipass
sudo apt install snapd
sudo snap install snapcraft --classic
sudo snap install multipass --classic
```

```bash
# Clone this repository
git clone --depth=1 https://github.com/habedi/duckdb-snap.git
```

```bash
# Build the package
cd duckdb-snap/
bash build.sh
```

```bash
# Install the package manually (optional)
sudo snap install --dangerous duckdb_VER_amd64.snap # Replace VER with the actual version
```

## License

The files in this repository are licensed under the [MIT License](LICENSE).
