{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Nix
    # --------------------------------------------------------------------------
    alejandra # The Uncompromising Nix Code Formatter.
    ############################################################################

    ############################################################################
    # Lua
    # --------------------------------------------------------------------------
    lua # A lightweight and embeddable scripting language.
    lua-language-server # Language server for Lua.
    stylua # An opinionated Lua code formatter.
    ############################################################################

    ############################################################################
    # Rust
    # --------------------------------------------------------------------------
    rustc # A safe, concurrent, practical language.
    cargo # A tool for downloading project's dependencies and building.
    rustfmt # A tool for formatting Rust code according to style guidelines.
    rust-analyzer # A modular compiler frontend for the Rust language.
    ############################################################################

    ############################################################################
    # Gleam
    # --------------------------------------------------------------------------
    gleam # A statically typed language for the Erlang VM.
    ############################################################################

    ############################################################################
    # Erlang
    # --------------------------------------------------------------------------
    erlang # Programming language used for massively scalable real-time systems.
    ############################################################################

    ############################################################################
    # Haskell
    # --------------------------------------------------------------------------
    (ghc.withPackages (ps:
      with ps; [
        cabal-install # A tool to compile and install Haskell libraries.
        cabal2nix # Convert a Cabal file into a Nix build expression.
        stack # A build tool for Haskell.
        fourmolu # A formatter for Haskell source code.
        haskell-language-server # Haskell Language Server Protocol.
      ]))
    ############################################################################

    ############################################################################
    # OCaml
    # --------------------------------------------------------------------------
    ocaml # A functional and statically typed programming language.
    opam # A package manager for OCaml.
    dune_3 # A composable build system.
    ocamlformat # Auto-formatter for OCaml code.
    ocamlPackages.ocaml-lsp # OCaml Language Server Protocol.
    ############################################################################

    ############################################################################
    # JavaScript / TypeScript
    # --------------------------------------------------------------------------
    nodejs # JavaScript runtime built on Chrome's V8 JavaScript engine.
    nodePackages.ts-node # TypeScript execution environment and REPL for nodejs.
    deno # A secure runtime for JavaScript and TypeScript.
    typescript # A superset of JavaScript that compiles to clean JavaScript.
    prettierd # Prettier, as a daemon, for improved formatting speed.
    ############################################################################

    ############################################################################
    # C / C++
    # --------------------------------------------------------------------------
    gcc # GNU Compiler Collection.
    glibc # GNU C Library.
    gnumake # GNU make utility.
    clang # C, C++, and Objective-C compiler.
    cmake # A tool to manage the build process of software.
    libgccjit # Just-In-Time compilation support in GCC.
    clang-tools # Standalone command line tools for C development.
    ############################################################################

    ############################################################################
    # Python
    # --------------------------------------------------------------------------
    (python3.withPackages (ps:
      with ps;
      with python3Packages; [
        pip
        jupyter
        ipython
        pandas
        numpy
        matplotlib
        scikit-learn
        scikit-image
        pyodbc
        sqlalchemy
        tabulate
        xgboost
        torch
        torchvision
        gdown
      ]))
    ############################################################################

    ############################################################################
    # Agda
    # --------------------------------------------------------------------------
    (agda.withPackages [agdaPackages.standard-library]) # A proof assistant.
    ############################################################################

    ############################################################################
    # Lean4
    # --------------------------------------------------------------------------
    elan
    ############################################################################

    ############################################################################
    # TOML
    # --------------------------------------------------------------------------
    taplo # A TOML toolkit written in Rust.
    ############################################################################
  ];
}
