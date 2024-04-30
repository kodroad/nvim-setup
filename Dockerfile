FROM alpine:3.19

RUN apk update && \
    apk add make openssh git wget curl build-base unzip gzip ripgrep neovim

# Go compiler
RUN wget https://golang.org/dl/go1.22.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz && \
    rm go1.22.2.linux-amd64.tar.gz

# NvChad
RUN git clone -b v2.0 https://github.com/NvChad/NvChad /root/.config/nvim --depth 1
COPY custom /root/.config/nvim/lua/custom

# Go env
ENV GOROOT /usr/local/go
ENV PATH /usr/local/go/bin:$PATH
ENV GOPATH /go
ENV PATH /go/bin:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

# This automatic setup always ends with errors although the errors aren't critical.
# ENV NVCHAD_EXAMPLE_CONFIG=n
# RUN nvim --headless '+quitall!'

CMD ["/bin/sh"]

#  Manual image build steps:
#  1. podman build . -t neovim-go-ready:1.0
#  2. podman run --name neovim-container -it --rm neovim-go-ready:1.0
#  3. nvim, wait everything installs, quit nvim
#  4. run nvim again to ensure treesitter parsers installed (sometimes they don't install on first nvim run)
#  5. rm -rf /root/.cache/go-build
#  6. rm -r /go/pkg/mod/*
#  7. apk del build-base wget curl
#  8. rm /usr/bin/wget
#  9. podman commit neovim-container neovim-go-ready:1.0
# 10. podman save --compress --format oci-dir -o neovim-go-ready neovim-go-ready:1.0
# 11. tar -czvf neovim-go-ready.tar.gz neovim-go-ready
# 12. deploy neovim-go-ready.tar.gz to somewhere
# 13. tar -xzvf neovim-go-ready.tar.gz
# 14. podman load -i neovim-go-ready
# 15. podman run -it --rm neovim-go-ready:latest
# 16. nvim
