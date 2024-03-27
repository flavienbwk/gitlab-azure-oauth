# Gitlab Azure OAuth

Binding GitLab with Azure Entra ID (formerly Azure Active Directory) with OAuth2.

## Pre-requisites

- Docker >= 24.x
- Compose plugin >= 2.x

## A. Configuring hosts and gitlab

1. Add `gitlab.local` to your `/etc/hosts`

    ```txt
    172.17.0.1 gitlab.local
    ```

2. Copy the compose configuration example

    ```bash
    cp docker-compose.example.yml docker-compose.yml
    ```

3. Generate self-signed certificates

    ```bash
    sudo bash generate-certs.sh
    ```

## B. Configuring Azure

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/)

2. Browse to _Identity_ > _Applications_ > _App registrations_ and select _New registration_

3. Enter a display _Name_ `gitlab` with single tenant

4. Retrieve and set the IDs

    Identify and add your _client ID_ and _tenant ID_ in `docker-compose.yml` respectively for values `OAUTH_AZURE_API_KEY` and `OAUTH_AZURE_TENANT_ID`.

5. Create and set the Secret

    Create a secret going to  _Identity_ > _Applications_ > _App registrations_, select application GitLab and select _Certificates & secrets_.
    
    In the _Client secrets_ tab, click _New client secret_. Add this client secret to `docker-compose.yml`'s `OAUTH_AZURE_API_SECRET` value.

6. Configure the redirect URI

    Go to  _Identity_ > _Applications_ > _App registrations_, select application GitLab and select _Authentication_.

    Click _Add a platform_ > _Web_ and add the following redirect URI : 
    
    - `https://gitlab.local:10443/users/auth/azure_activedirectory_v2/callback`

You might get more information checking the [official documentation](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app).

## C. Start gitlab

```bash
docker compose up -d
```

After some seconds, you should be able to browse to `https://gitlab.local:10443` and click on the _Azure AD v2_ sign in button.
