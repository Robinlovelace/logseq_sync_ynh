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

## Client Setup (Mobile & Desktop)

The Logseq DB Beta app allows setting a "Custom Sync Server" in the settings.

1.  **Sync Server URL:** Enter `https://syncls.lovelaces.org/?secret=testing123`.
2.  **Login:** If the app shows a "Login" button, click it. It will hit a dummy endpoint and should automatically mark you as logged in.

## Troubleshooting & Community Tips

### 1. Disable Encryption (Recommended for Beta)
Community members report that **encryption currently breaks synchronization** on Android and sometimes Desktop. 
- **Advice:** When creating or uploading your graph, **do not enable encryption** for now if you need mobile sync. 
- Existing encrypted graphs may fail to load with "Enter remote password" loops.

### 2. Asset Sync (Images/PDFs)
Asset sync is now working in recent builds. This package builds from the `master` branch, which includes the latest fixes for assets. If assets aren't showing up, ensure your client is updated to the latest DB Beta version.

### 3. "Downloading Forever" / Cached Keys
If your client gets stuck "Downloading" or "Preparing snapshot":
- Logseq may be using cached RSA keys from the official server.
- **Fix:** Try clearing your app cache, or delete and re-import the graph into the DB client.

## Development

Built on the excellent prior work by [yshalsager/logseq-selfhost](https://github.com/yshalsager/logseq-selfhost).
This package is maintained by [robinlovelace](https://github.com/robinlovelace).
Contributions are welcome!

