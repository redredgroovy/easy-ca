[ default ]

[ req ]
default_bits            = 4096                  # RSA key size
default_days            = 3650                  # How long to certify for
encrypt_key             = no                    # Protect private key
default_md              = sha512                # MD to use
utf8                    = yes                   # Input is UTF-8
string_mask             = utf8only              # Emit UTF-8 strings
prompt                  = yes                   # Prompt for DN
distinguished_name      = server_dn             # DN template
req_extensions          = sc_reqext             # Desired extensions

[ server_dn ]
countryName			= "1. Country Name (2 letters) "
countryName_max			= 2
countryName_default		= {{CA_CERT_C}}
stateOrProvinceName		= "2. State or Province Name   "
stateOrProvinceName_default	= {{CA_CERT_ST}}
localityName			= "3. Locality Name            "
localityName_default		= {{CA_CERT_L}}
organizationName		= "4. Organization Name        "
organizationName_default	= {{CA_CERT_O}}
organizationalUnitName		= "5. Organizational Unit Name "
organizationalUnitName_default	= {{CA_CERT_OU}}
commonName			= "6. Common Name              "
commonName_max			= 64
commonName_default		= {{CA_HOSTNAME}}

[ sc_reqext ]
keyUsage                = critical,digitalSignature,keyEncipherment
extendedKeyUsage        = serverAuth,clientAuth
subjectKeyIdentifier    = hash
subjectAltName          = ${ENV::SAN}
