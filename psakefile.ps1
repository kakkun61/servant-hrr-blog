Task Format {
    Exec { Get-ChildItem -Filter '*.hs' -Recurse app, src | ForEach-Object { stack exec -- stylish-haskell -c stylish-haskell.yaml -i $_.FullName } }
}

Task Lint {
    Exec { stack exec -- hlint app src }
}
