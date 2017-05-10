recALL Hash Library 16.07
=========================
FreePascal translation of HashLib (C#) with custom modifications.

Copyright (c) 2009-2013 HashLib - http://hashlib.codeplex.com
Copyright (c) 2016 Maciej Kaczkowski - http://keit.co


Changelog
=========

RHL 16.07
---------

Hash:
* Gost
* Gost CryptoPro
* Grindahl256
* Grindahl512
* RadioGatun32
* RadioGatun64
* Snefru
* Panama

Checksum:
* Adler32
* CRC32 (IEEE 802.3, Castagnoli, Koopman, 32Q)
* CRC64 (ISO, ECMA182)

Hash (non-cryptographic):
* TMDPA
* AP
* BKDR
* Bernstein
* Bernstein1
* DEK
* DJB
* ELF
* FNV, FNV64
* FNV1a, FNV1a64
* JS
* Jenkins3
* Murmur2, Murmur2/64
* Murmur3, Murmur3/128
* OneAtTime
* PJW
* Rotating
* RS
* SDBM
* ShiftAndXor
* SuperFast
* SipHash

RHL 16.06
---------

Hash:
* HAS160
* HAVAL(size=128,160,192,224,256)(round=3,4,5)(padding=$01,$80)
* MD2
* MD4
* MD5
* SHA0
* SHA1
* SHA2(size=224,256,384,512,512/224,512/256)
* SHA3 aka Keccak(size=224,256,384,512)
* Tiger(size=128,160,192)(round=3,4)(normal,swap order)
* Tiger2
* RipeMD(size=128,160,256,320)
* Whirlpool

also HMAC, PBKDF1 and PBKDF1 .NET version, PBKDF2 for any from above.