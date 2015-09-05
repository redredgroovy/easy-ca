# easy-ca
OpenSSL wrapper scripts for managing basic CA functions

A suite of bash scripts for automating very basic OpenSSL CA operations:
* Creating Root CAs
* Creating Intermediate Signing CAs
* Creating Server certificates (with optional subjectAltNames)
* Creating Client certificates
* Revoking certificates and maintaining CRLs



## Usage

### Create a new Root CA

The **create-root-ca** script will initialize a new Root CA directory structure. This script can be run directly from the source repo or from within an existing Easy CA installation. The CA is self-contained within the specified directory tree. It is portable and can be stored on removable media for security.

```
create-root-ca -d $ROOT_CA_DIR
```

**create-root-ca** will prompt for the basic DN configuration to use as defaults for this CA. Optionally, you can edit *defaults.conf* to set this information in advance. The new CA is now ready for use. The CA key, certificate, and CRL are available for review:

```
$ROOT_CA_DIR/ca/ca.crt
$ROOT_CA_DIR/private/ca.key
$ROOT_CA_DIR/crl/ca.crl
```



### (Optional) Create an Intermediate Signing CA

Running **create-signing-ca** from within a Root CA installation will initialize a new Intermediate CA directory structure, indepedent and separate from the Root CA. A Root CA may issue multiple Intermediate CAs.

```
$ROOT_CA_DIR/bin/create-signing-ca -d $SIGNING_CA_DIR
```

**create-signing-ca** will prompt for basic DN configuration, using the Root CA configuration as defaults. The Intermediate Signing CA is now ready for use. The CA key, certificate, chain file, and CRL are available for review:

```
$SIGNING_CA_DIR/ca/ca.crt
$SIGNING_CA_DIR/ca/chain.pem
$SIGNING_CA_DIR/private/ca.key
$SIGNING_CA_DIR/crl/ca.crl
```



### Issue a Server Certificate

Running **create-server** from within any CA installation will issue a new server (serverAuth) certificate:

```
$CA_DIR/bin/create-server -s fqdn.domain.com
```

Optionally, you can specify one (or more) subjectAltNames to accompany the new certificate:

```
$CA_DIR/bin/create-server -s fqdn.server.com -a alt1.domain.com -a alt2.domain.com
```

**create-server** will prompt for basic DN configuration, using the CA configuration as defaults. After the script is completed, the server certificate, key, and CSR are available for review:

```
$CA_DIR/certs/fqdn-domain-com.server.crt
$CA_DIR/private/fqdn-domain-com.server.key
$CA_DIR/csr/fqdn-domain-com.server.csr
```



### Issue a Client Certificate

Running **create-client** from within any CA installation will issue a new client (clientAuth) certificate:

```
$CA_DIR/bin/create-client -c user@domain.com
```

**create-client** will prompt for basic DN configuration, using the CA configuration as defaults. After the script is completed, the client certificate, key, and CSR are available for review:

```
$CA_DIR/certs/user-domain-com.client.crt
$CA_DIR/private/user-domain-com.client.key
$CA_DIR/csr/user-domain-com.client.csr
```



### Revoke a Certificate

Running **revoke-certificate** from within a CA installation allows you to revoke a certificate issued by that CA and update the CRL:

```
$CA_DIR/bin/revoke-certificate -c $CA_DIR/certs/fqdn-domain-com.server.crt
```

**revoke-certificate** will prompt for the revocation reason. After the script is completed, the server CRL is updated and available for review:

```
$CA_DIR/crl/ca.crl
```



## Caveats

These scripts are very simple, and make some hard-coded assumptions about behavior and configuration:
* Root and Intermediate CAs have a 3652-day lifetime
* Root and Intermediate CAs have 4096-bit RSA keys
* Root and Intermediate CA keys are always encrypted
* Only one level of Intermediate CA is supported
* Client and Server certificates have a 730-day lifetime
* Client and Server certificates have 2048-bit RSA keys
* Client and Server keys are never encrypted
* There is no wrapper for renewing certificates


