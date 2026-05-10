# Logseq Sync Server for YunoHost

Self-hosted synchronization server for the Logseq DB (Database) version.

Built on the excellent prior work by [yshalsager/logseq-selfhost](https://github.com/yshalsager/logseq-selfhost).

## Features

- Uses an improved multi-stage Docker build based on `yshalsager`'s community images.
- Managed toolchain via `mise` (Node 24, Java 21, Clojure 1.12).
- Supports WebSocket (WSS) for real-time synchronization.
- Data persistence in `/var/www/logseq_sync/data`.
- Authentication via OIDC or Secret Key bypass (with easy query parameter support).
- Automatic "Dummy" OIDC configuration to support the Logseq Beta "Login" button.

## Prerequisites

- **Logseq Client:** You must use the Logseq DB version. 
- **Build Flag:** The client must be built with `ENABLE_DB_SYNC_LOCAL=true`.
- **Custom Sync Server:** In the Logseq settings, you will need to point the sync server to `https://sync.yourdomain.tld`.

## Configuration

### Authentication

1.  **Secret Key (Single User):** Set a secret key during installation. In your Logseq client, use this key to authenticate.
2.  **OIDC:** Requires the YunoHost OIDC app to be installed and configured.

### WebSocket Support

This app automatically configures Nginx to handle WebSocket upgrades, which is essential for the Logseq sync protocol.

## Client Setup (Desktop)

To connect your Logseq desktop client to this server:

1.  Open Logseq.
2.  Go to `Settings` > `Feature Flags` (if available) or ensure you are running a build with `ENABLE_DB_SYNC_LOCAL=true`.
3.  Enter your sync server URL: `https://sync.yourdomain.tld`.
4.  Authenticate using your chosen method.

## Android/iOS Setup

The Logseq DB Beta app allows setting a "Custom Sync Server" in the settings. Enter your URL and credentials there.

## Development

This package is maintained by [robinlovelace](https://github.com/robinlovelace).
Contributions are welcome!
