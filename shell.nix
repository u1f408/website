{ pkgs ? import <nixpkgs> {}, lib ? pkgs.lib }:

with lib;

let
  neededLibraries = with pkgs; [
    curl
    libxml2
    libxslt
  ];

in
pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby
    bundler

    pkg-config
    shared-mime-info
    cacert
  ] ++ neededLibraries;

  "LD_LIBRARY_PATH" = makeLibraryPath neededLibraries;
  "SSL_CERT_DIR" = "${pkgs.cacert}/etc/ssl/certs";
  "SSL_CERT_FILE" = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  "FREEDESKTOP_MIME_TYPES_PATH" = "${pkgs.shared-mime-info}/share/mime/packages/freedesktop.org.xml";
}
