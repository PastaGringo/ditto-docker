# ditto-docker
⚠️ DEVELOPMENT ⚠️  

Ditto Nostr relay docker deployment.  
Please check [Ditto](https://docs.soapbox.pub/ditto/)'s website for futher information about the project.
## Docker
Install Docker if needed:
```
curl -fsSL https://get.docker.com -o install-docker.sh
```
```
sudo sh install-docker.sh
```
Verify if Docker & Docker compose are installed:
```
docker -v
Docker version 25.0.3, build 4debf41
```
```
docker compose version
Docker Compose version v2.24.6
```
Cloning the repo:
```
git clone https://github.com/PastaGringo/ditto-docker.git && cd ditto-docker
```
Update the .env file with your info:  
- <em>You must have a A DNS record pointing to your VPS external public IP to generate a Let's Encrypt SSL certificate. https://dnschecker.org
- To be able to login as admin in Ditto later, you need to use the npub hex key you configured into your NIP07 web browser extension.</em>

```
nano .env
```
Content:
```
# To convert npub to hex: https://damus.io/key/ 
ADMIN_HEX_KEY=
# Your sentry.io dsn project
SENTRY_DSN=
# Your Ditto instance full domain: ditto.tld or ditto.subdomain.tld
DITTO_DOMAIN=
```
PS: Ditto will start even if you let the variable SENTRY_DSN blank.  

Once done, you can compose the Ditto docker compose stack (CTRL+C to exit docker compose logs) :
```
docker compose up -d && docker compose logs -f 
```
```
docker compose up -d && docker compose logs -f
WARN[0000] The "EMAIL" variable is not set. Defaulting to a blank string. 
WARN[0000] /home/pastadmin/ditto-docker/docker-compose.yml: `version` is obsolete 
[+] Running 2/2
 ✔ Container ditto-docker  Running                                                                                                                                                   0.0s 
 ✔ Container traefik       Started                                                                                                                                                   0.5s 
WARN[0000] The "EMAIL" variable is not set. Defaulting to a blank string. 
WARN[0000] /home/pastadmin/ditto-docker/docker-compose.yml: `version` is obsolete 
ditto-docker  | 
ditto-docker  |   ____  _ _   _        
ditto-docker  |  |  _ \(_) |_| |_ ___  
ditto-docker  |  | | | | | __| __/ _ \ 
ditto-docker  |  | |_| | | |_| || (_) |
ditto-docker  |  |____/|_|\__|\__\___/ 
ditto-docker  |                        
ditto-docker  | Ditto's website: https://docs.soapbox.pub/ditto
ditto-docker  | Ditto's documentation: https://docs.soapbox.pub/ditto
ditto-docker  | Ditto's Nostr: https://njump.me/npub10qdp2fc9ta6vraczxrcs8prqnv69fru2k6s2dj48gqjcylulmtjsg9arpj
ditto-docker  | 
ditto-docker  | Starting Ditto for the first time...
ditto-docker  | Starting Ditto's configuration...
ditto-docker  | 
ditto-docker  | Docker compose variables provided:
ditto-docker  | SENTRY_DSN    : 
ditto-docker  | DITTO_NSEC    : XXX
ditto-docker  | ADMIN_HEX_KEY : XXX
ditto-docker  | 
ditto-docker  | Making user XXX Ditto's admin...
ditto-docker  | 
ditto-docker  | Task admin:role deno run -A scripts/admin-role.ts "XXX" "admin"
ditto-docker  | Downloading https://github.com/denodrivers/sqlite3/releases/download/0.11.1/libsqlite3.so
ditto-docker  | Running migrations...
ditto-docker  | Migrations finished!
ditto-docker  |   - 000_create_events: Success
ditto-docker  |   - 001_add_relays: Success
ditto-docker  |   - 002_events_fts: Success
ditto-docker  |   - 003_events_admin: Success
ditto-docker  |   - 004_add_user_indexes: Success
ditto-docker  |   - 005_rework_tags: Success
ditto-docker  |   - 006_pragma: Success
ditto-docker  |   - 007_unattached_media: Success
ditto-docker  |   - 008_wal: Success
ditto-docker  |   - 009_add_stats: Success
ditto-docker  |   - 010_drop_users: Success
ditto-docker  |   - 011_kind_author_index: Success
ditto-docker  |   - 012_tags_composite_index: Success
ditto-docker  |   - 013_soft_deletion: Success
ditto-docker  |   - 014_stats_indexes.ts: Success
ditto-docker  |   - 015_add_pubkey_domains: Success
ditto-docker  |   - 016_pubkey_domains_updated_at: Success
ditto-docker  |   - 017_rm_relays: Success
ditto-docker  | 
ditto-docker  | Done ✅
ditto-docker  | 
ditto-docker  | 🎉  Ditto has been configured! 🎉
ditto-docker  | 
ditto-docker  | Starting Ditto...
ditto-docker  | 
ditto-docker  | Task dev deno run -A --watch src/server.ts
ditto-docker  | Watcher Process started.
ditto-docker  | Cleaning up old tag usages...
ditto-docker  | Running migrations...
ditto-docker  | Everything up-to-date.
ditto-docker  | pool: connecting to 0 relays.
ditto-docker  | Download https://unpkg.com/nostr-relaypool2@0.6.34/lib/nostr-relaypool.worker.js
ditto-docker  | Listening on http://localhost:8000/
traefik       | 2024-05-04T00:14:51Z INF Traefik version 3.0.0 built on 2024-04-29T14:25:59Z version=3.0.0
traefik       | 2024-05-04T00:14:51Z INF 
traefik       | Stats collection is disabled.
traefik       | Help us improve Traefik by turning this feature on :)
traefik       | More details on: https://doc.traefik.io/traefik/contributing/data-collection/
traefik       | 
traefik       | 2024-05-04T00:14:51Z INF Starting provider aggregator aggregator.ProviderAggregator
traefik       | 2024-05-04T00:14:51Z INF Starting provider *traefik.Provider
traefik       | 2024-05-04T00:14:51Z INF Starting provider *acme.ChallengeTLSALPN
traefik       | 2024-05-04T00:14:51Z INF Starting provider *docker.Provider
traefik       | 2024-05-04T00:14:51Z INF Starting provider *acme.Provider
traefik       | 2024-05-04T00:14:51Z INF Testing certificate renew... acmeCA=https://acme-v02.api.letsencrypt.org/directory providerName=selfhostedservices.acme
traefik       | 2024-05-04T00:14:59Z INF Register... providerName=selfhostedservices.acme
```

You should be able to access Ditto on the Ditto domain you configured into the .env file 🎉

![image](https://github.com/PastaGringo/ditto-docker/assets/16828964/a995084d-f612-46e2-9103-7b1e48685dd8)

Click on the "Log In" button on the top right of the page.

Click on "Sign with extension":

![image](https://github.com/PastaGringo/ditto-docker/assets/16828964/2a1ea6d3-294b-4863-9d16-b7a9b17500e7)

If everthing is OK, you should now be able to access Ditto's settings:

![image](https://github.com/PastaGringo/ditto-docker/assets/16828964/3af3e68e-6fc1-4316-97eb-58eea1a67b0b)

Well done 🎉⚡
