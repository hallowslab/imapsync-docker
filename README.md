# 📨 imapsync — Multi-OS Docker Images

  hallowtechlab/imapsync provides ready-to-use Docker images for the excellent imapsync tool, built for multiple operating systems and imapsync versions.
  Migrate or sync mailboxes between IMAP servers without compiling from source yourself.

# 🚀 Features

- 🐧 Multiple Linux base images — Debian, Ubuntu, Alpine, and more
- 🕰 Multiple imapsync versions — choose the one you need for compatibility
- 📦 Precompiled binaries — no need for heavy build toolchains in your projects
- 🔄 Multi-arch support — amd64 + arm64
- 🧩 Flexible use — run directly or use as a base image

# 📦 Available Tags

Tags are in the format:

`<osfolder>_<baseimage>-<imapsyncversion>`


Examples:
- debian_bookworm-2.229
- debian_bookworm-2.200
- alpine_3.18-2.229
- ubuntu_jammy-2.229

See the Tags tab for the full list.

# 🛠 Usage

- Run directly from the shell:
  `docker run --rm -it hallowtechlab/imapsync:debian_bookworm-2.229 bash`
  `imapsync ....`


- Use in your own Dockerfile:
  ```
  FROM hallowtechlab/imapsync:alpine_3.18-2.229
  # your layers here
  ```

# 🏗 Building Locally

We provide build scripts to recreate these images locally for custom needs.
See the GitHub repo: https://github.com/hallowslab/imapsync-docker

# 📊 Badges






Maintainer: @hallowtechlab
🐳 Built with ❤️ using Docker Buildx