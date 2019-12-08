set -e -o verbose

# go

sudo pacman -S --noconfirm go

for package in \
  `# shared by vscode-go and vim-go` \
  github.com/alecthomas/gometalinter \
  github.com/davidrjenni/reftools/cmd/fillstruct \
  github.com/fatih/gomodifytags \
  github.com/josharian/impl \
  github.com/mdempsky/gocode \
  github.com/rogpeppe/godef \
  github.com/zmb3/gogetdoc \
  golang.org/x/lint/golint \
  golang.org/x/tools/cmd/goimports \
  golang.org/x/tools/cmd/gorename \
  golang.org/x/tools/cmd/guru \
  `# just for https://github.com/Microsoft/vscode-go` \
  github.com/acroca/go-symbols \
  github.com/cweill/gotests/... \
  github.com/haya14busa/goplay/cmd/goplay \
  github.com/ramya-rao-a/go-outline \
  github.com/uudashr/gopkgs/cmd/gopkgs \
  golang.org/x/tools/cmd/godoc \
  sourcegraph.com/sqs/goreturns \
  `# just for https://github.com/fatih/vim-go` \
  github.com/fatih/motion \
  github.com/go-delve/delve/cmd/dlv \
  github.com/golangci/golangci-lint/cmd/golangci-lint \
  github.com/jstemmer/gotags \
  github.com/kisielk/errcheck \
  github.com/klauspost/asmfmt/cmd/asmfmt \
  github.com/koron/iferr \
  github.com/stamblerre/gocode \
  golang.org/x/tools/cmd/gopls \
  honnef.co/go/tools/cmd/keyify
do
  echo $package
  go get -u $package
done

~/go/bin/gometalinter --install

