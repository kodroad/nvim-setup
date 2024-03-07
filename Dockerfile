FROM alpine:3.19

RUN apk update && \
    apk add make openssh git wget curl delta lazygit go build-base unzip gzip ripgrep neovim

# NvChad
RUN git clone https://github.com/NvChad/NvChad /root/.config/nvim --depth 1
COPY custom /root/.config/nvim/lua/custom

# lazygit config
COPY lazygit/config.yml /root/.config/lazygit/config.yml

# Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

# This automatic setup always ends with errors although the errors aren't critical.
# ENV NVCHAD_EXAMPLE_CONFIG=n
# RUN nvim --headless '+quitall!'

CMD ["/bin/sh"]

#  Image build process:
#  1. podman build . -t neovim-go-ready:1.0
#  2. podman run --name neovim-container -it --rm neovim-go-ready:1.0
#  3. nvim, wait everything installs, quit nvim
#  4. rm -rf /root/.cache/go-build
#  5. rm -r /go/pkg/mod/*
#  6. apk del build-base wget curl
#  8. rm /usr/bin/wget
#  9. podman commit neovim-container neovim-go-ready:1.0
# 10. podman save --compress --format oci-dir -o neovim-go-ready neovim-go-ready:1.0
# 11. tar -czvf neovim-go-ready.tar.gz neovim-go-ready
# 12. deploy neovim-go-ready.tar.gz to somewhere
# 13. tar -xzvf neovim-go-ready.tar.gz
# 14. podman load -i neovim-go-ready
# 15. podman run -it --rm neovim-go-ready:latest
# 16. nvim
