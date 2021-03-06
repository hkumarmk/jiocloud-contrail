#
# Class: contrail::repo::apt
#
class contrail::repo::apt (
  $location    = 'http://ppa.launchpad.net/opencontrail/ppa/ubuntu',
  $release     = 'trusty',
  $repos       = 'main',
  $include_src = false,
  $key         = '6839FE77',
  $key_content = '-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.4
Comment: Hostname: keyserver.ubuntu.com

mQINBFNf1fEBEAC/IQL0qp/qjJRMvHra+kgKP6ou9KHV4ryiyKDBlXrKI3sPAfhsdru/Slc5
PshbbdjrV9MCT0SjklFNwU/Q7iwE9PusxuObZ8DHm1+8QmCve/pPPvRoYiT8I/5tZxRzv27p
0fln9dQp5FGCZp2yXxFIyrI6iKn7Z+i0InC+ly4ApQhoa5/gJH/7YnAob7mjufodY1UWyPN8
mBdXIMtmCmPAa+YMsdAysMPi3ksgLU8F8lZzw3RAPZgdqYJSxXveFuv7zYl6ZXTFGKi2rtqL
/BbStyWrCNy6LRXS5PxThqAwWzdyvSfoV1f61hNBsT1nDkecgz7tEEbqUt80qh6J1wt+APy1
6dC3Soc24s+3X19ZK1mn68VOiId+DGYOMQI5iruy1CL4RsXmYlvlCY67UzyDbSqpf6VLghC+
DPtaVVgQPMb3tV7zKQmWN4gzI2r2F7pi0MDzqs95roFdbniBpCx9ljMhWhL6m5wFUL4ijl3Y
6eLLUXsW7F5N5Jxlx/BdnRinbuxHVosJA7tysT4NU0mTSYtx3JLQCVsmWHk0l5MkGwzkiX8E
mnPPoyQ91SPCeoYXljrWbOVHcVTWz9Q2s/hVim9N10WUGms0nsRj/RDFjxbVBgRsqHpRD4A8
ZtzTwS8yvFKWQGAhREFlapXIfRynRHTbaGQgJyC97mnGI3OohQARAQABtB5MYXVuY2hwYWQg
UFBBIGZvciBPcGVuQ29udHJhaWyJAjgEEwECACIFAlNf1fECGwMGCwkIBwMCBhUIAgkKCwQW
AgMBAh4BAheAAAoJEBa9g1BoOf53FnoQAKQIDdxligU6emQ1rYk4H8hkh7k+gWTGdlPCbAdZ
fMLTArtx0wKhTGfwh2YoZQXN7g+OnM2DboXNfLD9qoZZFlKhyOrKKnnHS0IXvdeWDJ82z6v4
+cKq13yxLGauJFWZbFp9qsgSuEFT5T/+AmBvjLyux23qprAyTLCGpY1B7qoIGuDrl6ibuoc4
U60TsYZHlNeXRXn+p8fV3xnfSkki0hQElCQmeKrVUM/5bweWZM0qwcjyD/yRF8cgnW0rYR7Q
Zk2ppj42XNdS8y8ZvjlBCeCI19+Lxuh5oDsFUH0M71hS0Qh+ELEm5Z+fqLesrnLgGl9w5AHV
OlVYaxPtv/k6FacAgB2ADIT8RTJ6gm9oivshPC/Bkd9vnhV56gdarty4LGa9nekGVW4IGHTb
v+OXV2v50+gCRtii82BH7dyuLwT/wkv0fnV4rgzGcEe+pMurdWNYl/0zzk7RyqT7XD7G7Ryd
uLkN2GG8MNGuQL+xY36eBTR/NU+LpsBThqTH8L6EnvbjRpmjo6n1WE1+mVlxXbdcsZlHz0W2
0RCVt6pHFPELSOY8iq+e2ixbLYakB6LPalTngVnmBkm+lKhK47+pcNtT2i5dVWnR28JqNrLX
RwQOupXOWC3/YXfgEZ9JryJXSI1C8cVEUiCp4XMr9TEeCaQQnDAmg53hK3swQ23AdWeV
=XJUq
-----END PGP PUBLIC KEY BLOCK-----'
){

  ::apt::source { 'opencontrail':
    location    => $location,
    release     => $release,
    repos       => $repos,
    include_src => $include_src,
    key         => $key,
    key_content => $key_content,
  }
}
