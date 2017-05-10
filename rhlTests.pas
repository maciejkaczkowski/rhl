unit rhlTests;

interface

uses
  Classes,

  rhlCore,
  rhlMD2, rhlMD4, rhlMD5,
  rhlHAS160,
  rhlSHA0, rhlSHA1,
  rhlSHA224, rhlSHA256,
  rhlSHA384, rhlSHA512,
  rhlSHA512_224, rhlSHA512_256,
  rhlKeccak,
  rhlRIPEMD, rhlRIPEMD128, rhlRIPEMD160, rhlRIPEMD256, rhlRIPEMD320,
  rhlHAVAL128, rhlHAVAL160, rhlHAVAL192, rhlHAVAL224, rhlHAVAL256,
  rhlTiger, rhlTiger2,
  rhlWhirlpool,
  rhlTMDPA, rhlPanama, rhlGost, rhlGostCryptoPro,
  rhlGrindahl256, rhlGrindahl512,
  rhlRadioGatun32, rhlRadioGatun64,
  rhlSnefru,
  rhlAdler32, rhlCRC32, rhlCRC64,
  rhlAP, rhlBernstein, rhlBernstein1, rhlBKDR, rhlDEK, rhlDJB,
  rhlELF, rhlFNV, rhlFNV1a, rhlJenkins3, rhlJS, rhlMurmur2, rhlMurmur3,
  rhlOneAtTime, rhlPJW, rhlRotating, rhlRS, rhlSDBM, rhlShiftAndXor,
  rhlSuperFast,
  rhlFNV1a64, rhlFNV64, rhlMurmur2_64, rhlSipHash, rhlMurmur3_128;

const
  st: array[0..359] of record
    obj: TrhlHashClass;
    hash: ansistring;
    plain: ansistring;
  end = (
    (obj: TrhlSHA224; hash: 'd14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f'; plain: ''),
    (obj: TrhlSHA224; hash: '23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7'; plain: 'abc'),
    (obj: TrhlSHA224; hash: '75388b16512776cc5dba5da1fd890150b0c6455cb4f58b1952522525'; plain: 'abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq'),

    (obj: TrhlSHA256; hash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855'; plain: ''),
    (obj: TrhlSHA256; hash: 'CA978112CA1BBDCAFAC231B39A23DC4DA786EFF8147C4E72B9807785AFEE48BB'; plain: 'a'),
    (obj: TrhlSHA256; hash: 'BA7816BF8F01CFEA414140DE5DAE2223B00361A396177A9CB410FF61F20015AD'; plain: 'abc'),
    (obj: TrhlSHA256; hash: 'F7846F55CF23E14EEBEAB5B4E1550CAD5B509E3348FBC4EFA3A1413D393CB650'; plain: 'message digest'),
    (obj: TrhlSHA256; hash: '71C480DF93D6AE2F1EFAD1447C66C9525E316218CF51FC8D9ED832F2DAF18B73'; plain: 'abcdefghijklmnopqrstuvwxyz'),
    (obj: TrhlSHA256; hash: '248D6A61D20638B8E5C026930C3E6039A33CE45964FF2167F6ECEDD419DB06C1'; plain: 'abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq'),

    (obj: TrhlSHA384; hash: '38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b'; plain: ''),
    (obj: TrhlSHA384; hash: 'cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7'; plain: 'abc'),
    (obj: TrhlSHA384; hash: '09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039'; plain: 'abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu'),

    (obj: TrhlSHA512; hash: 'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'; plain: ''),
    (obj: TrhlSHA512; hash: 'ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f'; plain: 'abc'),
    (obj: TrhlSHA512; hash: '8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909'; plain: 'abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu'),

    (obj: TrhlSHA512_224; hash: '6ed0dd02806fa89e25de060c19d3ac86cabb87d6a0ddd05c333b84f4'; plain: ''),
    (obj: TrhlSHA512_224; hash: '4634270f707b6a54daae7530460842e20e37ed265ceee9a43e8924aa'; plain: 'abc'),
    (obj: TrhlSHA512_224; hash: '23fec5bb94d60b23308192640b0c453335d664734fe40e7268674af9'; plain: 'abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu'),

    (obj: TrhlSHA512_256; hash: 'c672b8d1ef56ed28ab87c3622c5114069bdd3ad7b8f9737498d0c01ecef0967a'; plain: ''),
    (obj: TrhlSHA512_256; hash: '53048e2681941ef99b2e29b76b4c7dabe4c2d0c634fc6d46e0e2f13107e7af23'; plain: 'abc'),
    (obj: TrhlSHA512_256; hash: '3928e184fb8690f840da3988121d31be65cb9d3ef83ee6146feac861e19b563a'; plain: 'abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu'),

    (obj: TrhlMD2; hash: '8350e5a3e24c153df2275c9f80692773'; plain:''),
    (obj: TrhlMD2; hash: '32ec01ec4a6dac72c0ab96fb34c0b5d1'; plain:'a'),
    (obj: TrhlMD2; hash: 'da853b0d3f88d99b30283a69e6ded6bb'; plain:'abc'),
    (obj: TrhlMD2; hash: 'ab4f496bfb2a530b219ff33031fe06b0'; plain:'message digest'),
    (obj: TrhlMD2; hash: '4e8ddff3650292ab5a4108c3aa47940b'; plain:'abcdefghijklmnopqrstuvwxyz'),
    (obj: TrhlMD2; hash: 'da33def2a42df13975352846c30338cd'; plain:'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
    (obj: TrhlMD2; hash: 'd5976f79d83d3a0dc9806c3c66f3efd8'; plain:'12345678901234567890123456789012345678901234567890123456789012345678901234567890'),

    (obj: TrhlMD4; hash: '31d6cfe0d16ae931b73c59d7e0c089c0'; plain:''),
    (obj: TrhlMD4; hash: 'bde52cb31de33e46245e05fbdbd6fb24'; plain:'a'),
    (obj: TrhlMD4; hash: 'a448017aaf21d8525fc10ae87aa6729d'; plain:'abc'),
    (obj: TrhlMD4; hash: 'd9130a8164549fe818874806e1c7014b'; plain:'message digest'),
    (obj: TrhlMD4; hash: 'd79e1c308aa5bbcdeea8ed63df412da9'; plain:'abcdefghijklmnopqrstuvwxyz'),
    (obj: TrhlMD4; hash: '043f8582f241db351ce627e153e7f0e4'; plain:'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
    (obj: TrhlMD4; hash: 'e33b4ddc9c38f2199c3e7b164fcc0536'; plain:'12345678901234567890123456789012345678901234567890123456789012345678901234567890'),

    (obj: TrhlMD5; hash: 'd41d8cd98f00b204e9800998ecf8427e'; plain:''),
    (obj: TrhlMD5; hash: '0cc175b9c0f1b6a831c399e269772661'; plain:'a'),
    (obj: TrhlMD5; hash: '900150983cd24fb0d6963f7d28e17f72'; plain:'abc'),
    (obj: TrhlMD5; hash: 'f96b697d7cb7938d525a2f31aaf161d0'; plain:'message digest'),
    (obj: TrhlMD5; hash: 'c3fcd3d76192e4007dfb496cca67e13b'; plain:'abcdefghijklmnopqrstuvwxyz'),
    (obj: TrhlMD5; hash: 'd174ab98d277d9f5a5611c2c9f419d9f'; plain:'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
    (obj: TrhlMD5; hash: '57edf4a22be3c955ac49da2e2107b67a'; plain:'12345678901234567890123456789012345678901234567890123456789012345678901234567890'),

    (obj: TrhlHAS160; hash: '307964EF34151D37C8047ADEC7AB50F4FF89762D'; plain: ''),
    (obj: TrhlHAS160; hash: '4872BCBC4CD0F0A9DC7C2F7045E5B43B6C830DB8'; plain: 'a'),
    (obj: TrhlHAS160; hash: '975E810488CF2A3D49838478124AFCE4B1C78804'; plain: 'abc'),
    (obj: TrhlHAS160; hash: '2338DBC8638D31225F73086246BA529F96710BC6'; plain: 'message digest'),
    (obj: TrhlHAS160; hash: '596185C9AB6703D0D0DBB98702BC0F5729CD1D3C'; plain: 'abcdefghijklmnopqrstuvwxyz'),
    (obj: TrhlHAS160; hash: 'CB5D7EFBCA2F02E0FB7167CABB123AF5795764E5'; plain: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
    (obj: TrhlHAS160; hash: '07F05C8C0773C55CA3A5A695CE6ACA4C438911B5'; plain: '12345678901234567890123456789012345678901234567890123456789012345678901234567890'),

    (obj: TrhlSHA0; hash: 'f96cea198ad1dd5617ac084a3d92c6107708c0ef'; plain:''),
    (obj: TrhlSHA0; hash: '0164b8a914cd2a5e74c4f7ff082c4d97f1edf880'; plain:'abc'),
    (obj: TrhlSHA0; hash: 'c1b0f222d150ebb9aa36a40cafdc8bcbed830b14'; plain:'message digest'),
    (obj: TrhlSHA0; hash: 'b40ce07a430cfd3c033039b9fe9afec95dc1bdcd'; plain:'abcdefghijklmnopqrstuvwxyz'),
    (obj: TrhlSHA0; hash: '79e966f7a3a990df33e40e3d7f8f18d2caebadfa'; plain:'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
    (obj: TrhlSHA0; hash: '4aa29d14d171522ece47bee8957e35a41f3e9cff'; plain:'12345678901234567890123456789012345678901234567890123456789012345678901234567890'),

    (obj: TrhlSHA1; hash: 'da39a3ee5e6b4b0d3255bfef95601890afd80709'; plain:''),
    (obj: TrhlSHA1; hash: 'a9993e364706816aba3e25717850c26c9cd0d89d'; plain:'abc'),
    (obj: TrhlSHA1; hash: 'c12252ceda8be8994d5fa0290a47231c1d16aae3'; plain:'message digest'),
    (obj: TrhlSHA1; hash: '32d10c7b8cf96570ca04ce37f2a19d84240d3a89'; plain:'abcdefghijklmnopqrstuvwxyz'),
    (obj: TrhlSHA1; hash: '761c457bf73b14d27e9e9265c46f4b4dda11f940'; plain:'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
    (obj: TrhlSHA1; hash: '50abf5706a150990a08b2c5ea40fa0e585554732'; plain:'12345678901234567890123456789012345678901234567890123456789012345678901234567890'),

    (obj: TrhlRIPEMD; hash: '9F73AA9B372A9DACFB86A6108852E2D9'; plain: ''),
    (obj: TrhlRIPEMD; hash: '34AA8697522EBEC0248EF2428F392B7B'; plain: '@'),
    (obj: TrhlRIPEMD; hash: 'xFFFFFFF0F4BB0FA597BBD7F58AEF7180'; plain: '48DE5F4845276C8F'),

    (obj: TrhlRIPEMD128; hash: 'CDF26213A150DC3ECB610F18F6B38B46'; plain: ''),
    (obj: TrhlRIPEMD128; hash: 'DFED3A8461263CDEC125424D8E646560'; plain: '@'),
    (obj: TrhlRIPEMD128; hash: 'x66C28CD3F685CAC671FA99C9F059D144'; plain: '48DE5F4845276C8F'),

    (obj: TrhlRIPEMD160; hash: '9C1185A5C5E9FC54612808977EE8F548B2258D31'; plain: ''),
    (obj: TrhlRIPEMD160; hash: 'B59A38CB7BC1A6D5AB448CE5DBB8F7F20B95E719'; plain: '@'),
    (obj: TrhlRIPEMD160; hash: 'xEE047999AB7687F2E62F1EDC68B30D12D7229169'; plain: '48DE5F4845276C8F'),

    (obj: TrhlRIPEMD256; hash: '02BA4C4E5F8ECD1877FC52D64D30E37A2D9774FB1E5D026380AE0168E3C5522D'; plain: ''),
    (obj: TrhlRIPEMD256; hash: '39AEE15C5A6B271E6F6204960DFB0A8EC3986D17BD4DF5E1EADF6C18FACE5899'; plain: '@'),
    (obj: TrhlRIPEMD256; hash: 'x1A8CE32A19A34BD3DAD60B911E99ED91403255F2256EF062DBD3606444921264'; plain: '48DE5F4845276C8F'),

    (obj: TrhlRIPEMD320; hash: '22D65D5661536CDC75C1FDF5C6DE7B41B9F27325EBC61E8557177D705A0EC880151C3A32A00899B8'; plain: ''),
    (obj: TrhlRIPEMD320; hash: '25994AF50AF825CA6755F72F1895B503BCFDAF398E189C69188A06878C55C952671EADE03F42DFCB'; plain: '@'),
    (obj: TrhlRIPEMD320; hash: 'x432A4D1C06881198DDF765562125E2EBF52AA84BAEE228BF2FDDA6C9BD8ABFC78D417BBAAF787090'; plain: '48DE5F4845276C8F'),

    (obj: TrhlHAVAL128r3p1; hash: 'c68f39913f901f3ddf44c707357a7d70'; plain: ''),
    (obj: TrhlHAVAL160r3p1; hash: 'd353c3ae22a25401d257643836d7231a9a95f953'; plain: ''),
    (obj: TrhlHAVAL192r3p1; hash: 'e9c48d7903eaf2a91c5b350151efcb175c0fc82de2289a4e'; plain: ''),
    (obj: TrhlHAVAL224r3p1; hash: 'c5aae9d47bffcaaf84a8c6e7ccacd60a0dd1932be7b1a192b9214b6d'; plain: ''),
    (obj: TrhlHAVAL256r3p1; hash: '4f6938531f0bc8991f62da7bbd6f7de3fad44562b8c6f4ebf146d5b4e46f7c17'; plain: ''),
    (obj: TrhlHAVAL128r4p1; hash: 'ee6bbf4d6a46a679b3a856c88538bb98'; plain: ''),
    (obj: TrhlHAVAL160r4p1; hash: '1d33aae1be4146dbaaca0b6e70d7a11f10801525'; plain: ''),
    (obj: TrhlHAVAL192r4p1; hash: '4a8372945afa55c7dead800311272523ca19d42ea47b72da'; plain: ''),
    (obj: TrhlHAVAL224r4p1; hash: '3e56243275b3b81561750550e36fcd676ad2f5dd9e15f2e89e6ed78e'; plain: ''),
    (obj: TrhlHAVAL256r4p1; hash: 'c92b2e23091e80e375dadce26982482d197b1a2521be82da819f8ca2c579b99b'; plain: ''),
    (obj: TrhlHAVAL128r5p1; hash: '184b8482a0c050dca54b59c7f05bf5dd'; plain: ''),
    (obj: TrhlHAVAL160r5p1; hash: '255158cfc1eed1a7be7c55ddd64d9790415b933b'; plain: ''),
    (obj: TrhlHAVAL192r5p1; hash: '4839d0626f95935e17ee2fc4509387bbe2cc46cb382ffe85'; plain: ''),
    (obj: TrhlHAVAL224r5p1; hash: '4a0513c032754f5582a758d35917ac9adf3854219b39e3ac77d1837e'; plain: ''),
    (obj: TrhlHAVAL256r5p1; hash: 'be417bb4dd5cfb76c7126f4f8eeb1553a449039307b1a3cd451dbfdc0fbbe330'; plain: ''),

    (obj: TrhlHAVAL128r3p1; hash: '9e40ed883fb63e985d299b40cda2b8f2'; plain: 'abc'),
    (obj: TrhlHAVAL160r3p1; hash: 'b21e876c4d391e2a897661149d83576b5530a089'; plain: 'abc'),
    (obj: TrhlHAVAL192r3p1; hash: 'a7b14c9ef3092319b0e75e3b20b957d180bf20745629e8de'; plain: 'abc'),
    (obj: TrhlHAVAL224r3p1; hash: '5bc955220ba2346a948d2848eca37bdd5eca6ecca7b594bd32923fab'; plain: 'abc'),
    (obj: TrhlHAVAL256r3p1; hash: '8699f1e3384d05b2a84b032693e2b6f46df85a13a50d93808d6874bb8fb9e86c'; plain: 'abc'),
    (obj: TrhlHAVAL128r4p1; hash: '6f2132867c9648419adcd5013e532fa2'; plain: 'abc'),
    (obj: TrhlHAVAL160r4p1; hash: '77aca22f5b12cc09010afc9c0797308638b1cb9b'; plain: 'abc'),
    (obj: TrhlHAVAL192r4p1; hash: '7e29881ed05c915903dd5e24a8e81cde5d910142ae66207c'; plain: 'abc'),
    (obj: TrhlHAVAL224r4p1; hash: '124c43d2ba4884599d013e8c872bfea4c88b0b6bf6303974cbe04e68'; plain: 'abc'),
    (obj: TrhlHAVAL256r4p1; hash: '8f409f1bb6b30c5016fdce55f652642261575bedca0b9533f32f5455459142b5'; plain: 'abc'),
    (obj: TrhlHAVAL128r5p1; hash: 'd054232fe874d9c6c6dc8e6a853519ea'; plain: 'abc'),
    (obj: TrhlHAVAL160r5p1; hash: 'ae646b04845e3351f00c5161d138940e1fa0c11c'; plain: 'abc'),
    (obj: TrhlHAVAL192r5p1; hash: 'd12091104555b00119a8d07808a3380bf9e60018915b9025'; plain: 'abc'),
    (obj: TrhlHAVAL224r5p1; hash: '8081027a500147c512e5f1055986674d746d92af4841abeb89da64ad'; plain: 'abc'),
    (obj: TrhlHAVAL256r5p1; hash: '976cd6254c337969e5913b158392a2921af16fca51f5601d486e0a9de01156e7'; plain: 'abc'),

    (obj: TrhlHAVAL128r3p128; hash: '1BDC556B29AD02EC09AF8C66477F2A87'; plain: ''),
    (obj: TrhlHAVAL160r3p128; hash: '5E1610FCED1D3ADB0BB18E92AC2B11F0BD99D8ED'; plain: 'a'),
    (obj: TrhlHAVAL192r4p128; hash: '74AA31182FF09BCCE453A7F71B5A7C5E80872FA90CD93AE4'; plain: 'HAVAL'),
    (obj: TrhlHAVAL224r4p128; hash: '144CB2DE11F05DF7C356282A3B485796DA653F6B702868C7DCF4AE76'; plain: '0123456789'),
    (obj: TrhlHAVAL256r5p128; hash: '1A1DC8099BDAA7F35B4DA4E805F1A28FEE909D8DEE920198185CBCAED8A10A8D'; plain: 'abcdefghijklmnopqrstuvwxyz'),
    (obj: TrhlHAVAL256r5p128; hash: 'C5647FC6C1877FFF96742F27E9266B6874894F41A08F5913033D9D532AEDDB39'; plain: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),

    (obj: TrhlTiger128r4; hash: '20b5d50b5a43931546fb8b52c5c42d3a'; plain: '@'),
    (obj: TrhlTiger160r4; hash: '20b5d50b5a43931546fb8b52c5c42d3ae20d223d'; plain: '@'),
    (obj: TrhlTiger192r4; hash: '20B5D50B5A43931546FB8B52C5C42D3AE20D223D2CD7F93D'; plain: '@'),

    (obj: TrhlTiger128r4so; hash: '1593435A0BD5B5203A2DC4C5528BFB46'; plain: '@'),
    (obj: TrhlTiger160r4so; hash: '1593435A0BD5B5203A2DC4C5528BFB463DF9D72C'; plain: '@'),

    (obj: TrhlTiger192r3so; hash: '24F0130C63AC933216166E76B1BB925FF373DE2D49584E7A'; plain: ''),
    (obj: TrhlTiger192r3so; hash: '70E3BEABBFD83AF341B6D8C82F5CBD812EAE6AF4AF2140F9'; plain: '@'),
    (obj: TrhlTiger192r3so; hash: '87FB2A9083851CF7470D2CF810E6DF9EB586445034A5A386'; plain: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-'),
    (obj: TrhlTiger192r3so; hash: '0C410A042968868A1671DA5A3FD29A725EC1E457D3CDB303'; plain: 'Tiger - A Fast New Hash Function, by Ross Anderson and Eli Biham'),

    (obj: TrhlTiger192r4so; hash: '4635FFF6A778CC243DA15C69594E98E79451256E680B4E80'; plain: ''),
    (obj: TrhlTiger192r4so; hash: '1593435A0BD5B5203A2DC4C5528BFB463DF9D72C3D220DE2'; plain: '@'),
    (obj: TrhlTiger192r4so; hash: 'x73A0C8CB154681F9B3B69C65BB02B89CE68C281E4A8E962F'; plain: '48DE5F4845276C8F'),

    (obj: TrhlTiger2; hash: '4441BE75F6018773C206C22745374B924AA8313FEF919F41'; plain: ''),
    (obj: TrhlTiger2; hash: 'D4EE31FD5944E597ED01A4900A6BCD6AF9A367E5758A8849'; plain: '@'),
    (obj: TrhlTiger2; hash: 'xEEFE8BF3B1ABCA7B4F654FF6E8D33D15556CBA2FC42ACF24'; plain: '48DE5F4845276C8F'),

    (obj: TrhlKeccak224; hash: 'F71837502BA8E10837BDD8D365ADB85591895602FC552B48B7390ABD'; plain: ''),
    (obj: TrhlKeccak224; hash: 'DFD04E56166EA802104B1F4E39E90E8DB402B35A185332619F6448F4'; plain: '@'),
    (obj: TrhlKeccak224; hash: 'x9498C25868FB850EDB233D4B861E8DB72FE1F767D9541A50C70FADBC'; plain: '48DE5F4845276C8F'),

    (obj: TrhlKeccak256; hash: 'C5D2460186F7233C927E7DB2DCC703C0E500B653CA82273B7BFAD8045D85A470'; plain: ''),
    (obj: TrhlKeccak256; hash: 'E724D40619441CED66A271E59627B7BCD39C77447A4315561B4D21E7B7C9321C'; plain: '@'),
    (obj: TrhlKeccak256; hash: 'x7D82C1F33F243B107047C0EFCA14645B5960572598248C6F1FE4D4A44D9C5DED'; plain: '48DE5F4845276C8F'),

    (obj: TrhlKeccak384; hash: '2C23146A63A29ACF99E73B88F8C24EAA7DC60AA771780CCC006AFBFA8FE2479B2DD2B21362337441AC12B515911957FF'; plain: ''),
    (obj: TrhlKeccak384; hash: '7EB3824FDB247F5E404D7BBD8AB243D58D1C1E4FF538785CE8EB5723B79076EF280E6B2FBC240E855EB69F01005C4D51'; plain: '@'),
    (obj: TrhlKeccak384; hash: 'x9D894160D3F91066D3C4A6BD2FBCAAD5BD47A7D9C389E7F1133BDA6DAF130E48069920100A63FB39AB55FABD7E36CE68'; plain: '48DE5F4845276C8F'),

    (obj: TrhlKeccak512; hash: '0EAB42DE4C3CEB9235FC91ACFFE746B29C29A8C366B7C60E4E67C466F36A4304C00FA9CAF9D87976BA469BCBE06713B435F091EF2769FB160CDAB33D3670680E'; plain: ''),
    (obj: TrhlKeccak512; hash: '64E501C5ACF2CE6271883AA40939D63AFB632F64E243D46FE9307CE89D25E9F0156A5EC3BEE387C2CA7301DEF64FAC374F6AF95ED99B2911448266E73BDC873C'; plain: '@'),
    (obj: TrhlKeccak512; hash: 'x73208FCE8A27823C459800F753D2DDCEDF76A5FAD7F3689BFC5CAAE156983E54B0B071B8C0FC24221210315A3CD8CD1205BA0E95A579AED8CC16D643BF07BFDE'; plain: '48DE5F4845276C8F'),

    (obj: TrhlWhirlpool; hash: '19FA61D75522A4669B44E39C1D2E1726C530232130D407F89AFEE0964997F7A73E83BE698B288FEBCF88E3E03C4F0757EA8964E59B63D93708B138CC42A66EB3'; plain: ''),
    (obj: TrhlWhirlpool; hash: '818D938EA6C8CEE1BF4CA4192FA5E3EEB107F6891602E29751BD5EC9174FB31DF87CACDD6E81A333A0DB11683763DD55EBE686CA5E1F722398758074805E33AC'; plain: '@'),
    (obj: TrhlWhirlpool; hash: 'x0ECF1574D4C4A1C04B787F9C4A840618129E82BD21AC658994AE628F47B13A0F5ACC23C792310AE65B4E540828D47D4AEA54DFFA13F90F00EBB77466AD6EA649'; plain: '48DE5F4845276C8F'),

    (obj: TrhlTMDPA; hash: '0BD132AA831C56AC1F92E61084A342D2'; plain: ''),
    (obj: TrhlTMDPA; hash: 'D60FDA092A2E5C668499FD8F044E1491'; plain: '@'),
    (obj: TrhlTMDPA; hash: 'EDFA9FA760E7F6E274F83ABDF465CE96'; plain: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
    (obj: TrhlTMDPA; hash: '0FC11CE66D917431F1D63088521A39F0'; plain: '12345678901234567890123456789012345678901234567890123456789012345678901234567890'),

    (obj: TrhlPanama; hash: 'AA0CC954D757D7AC7779CA3342334CA471ABD47D5952AC91ED837ECD5B16922B'; plain: ''),
    (obj: TrhlPanama; hash: 'F1CD0FC6C0284CF1FD491733CA71DA7DB0C47B8F0D1C0DF10C38979B85F50A2C'; plain: '@'),
    (obj: TrhlPanama; hash: 'x6C70B396E8BFC4B023B28C2ABAC149CD91C5599388F0DD73B0BA1FC7FCD7CEB4'; plain: '48DE5F4845276C8F'),

    (obj: TrhlGost; hash: 'CE85B99CC46752FFFEE35CAB9A7B0278ABB4C2D2055CFF685AF4912C49490F8D'; plain: ''),
    (obj: TrhlGost; hash: 'B00F1B1E2A8D2072369F75A0C4BD823D0B098B84BE2139CFC74E1A4E14A15483'; plain: '@'),
    (obj: TrhlGost; hash: 'x2A199A246A114562758362A036F1BF81FC5BB0638B7FB5544D9156B91BB37529'; plain: '48DE5F4845276C8F'),

    (obj: TrhlGostCryptoPro; hash: '981e5f3ca30c841487830f84fb433e13ac1101569b9c13584ac483234cd656c0'; plain: ''),
    (obj: TrhlGostCryptoPro; hash: 'e74c52dd282183bf37af0079c9f78055715a103f17e3133ceff1aacf2f403011'; plain: 'a'),
    (obj: TrhlGostCryptoPro; hash: 'b285056dbf18d7392d7677369524dd14747459ed8143997e163b2986f92fd42c'; plain: 'abc'),
    (obj: TrhlGostCryptoPro; hash: 'bc6041dd2aa401ebfa6e9886734174febdb4729aa972d60f549ac39b29721ba0'; plain: 'message digest'),
    (obj: TrhlGostCryptoPro; hash: '9004294a361a508c586fe53d1f1b02746765e71b765472786e4770d565830a76'; plain: 'The quick brown fox jumps over the lazy dog'),
    (obj: TrhlGostCryptoPro; hash: '73b70a39497de53a6e08c67b6d4db853540f03e9389299d9b0156ef7e85d0f61'; plain: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
    (obj: TrhlGostCryptoPro; hash: '6bc7b38989b28cf93ae8842bf9d752905910a7528a61e5bce0782de43e610c90'; plain: '12345678901234567890123456789012345678901234567890123456789012345678901234567890'),

    (obj: TrhlGrindahl256; hash: '45A7600159AF54AE110FCB6EA0F38AD57875EAC814F74D2CBC247D28C89923E6'; plain: ''),
    (obj: TrhlGrindahl256; hash: '5F361D0E8F41497CCD40EEB2773E3B091EC2055028E04C536CF971986A95EB17'; plain: '@'),
    (obj: TrhlGrindahl256; hash: 'x61BB943A12C620E7CC0EF3523216CB6CE0DA24AEACD7D55FDEC96C2D70477E2E'; plain: '48DE5F4845276C8F'),

    (obj: TrhlGrindahl512; hash: 'EE0BA85F90B6D232430BA43DD0EDD008462591816962A355602ED214FAAE54A9A4607D6F577CE950421FF58AEA53F51A7A9F5CCA894C3776104D43568FEA1207'; plain: ''),
    (obj: TrhlGrindahl512; hash: '5104726C9D699FA0BB1002BD5908FF566DCCDEAB4CD59C2FB01F18E8229AD8516F5DC6D1724F3E1BAEB5366017682DEFD0C71DFCC20A36CCD21CCCC0033C2DDC'; plain: '@'),
    (obj: TrhlGrindahl512; hash: 'x8F799124979EAF92A90B7C63A95C292D8E733EB639BA119C37EB42991E8445949F8A62CD637E60CE963CA1B194B3411CFB66A2852574E0CAC1613E2169F1FD08'; plain: '48DE5F4845276C8F'),

    (obj: TrhlRadioGatun32; hash: 'F30028B54AFAB6B3E55355D277711109A19BEDA7091067E9A492FB5ED9F20117'; plain: ''),
    (obj: TrhlRadioGatun32; hash: '137A45B055A771A7E8C26DA438DD9A3141B29D6050B40EC587704EF01B452ADF'; plain: '@'),
    (obj: TrhlRadioGatun32; hash: 'x12FF40C48ABF3A7FBC1EF1E3FD52AF874D6F78966C7D050E563E5D92BCCF8FA1'; plain: '48DE5F4845276C8F'),

    (obj: TrhlRadioGatun64; hash: '64A9A7FA139905B57BDAB35D33AA216370D5EAE13E77BFCDD85513408311A584'; plain: ''),
    (obj: TrhlRadioGatun64; hash: 'EB1DAF43BB7785A5B743260EE7093000F3A94F7C8BE236B5880B6557449E680D'; plain: '@'),
    (obj: TrhlRadioGatun64; hash: 'x8752C29F30809F30AEF2114A567610167C0A02A1D3E7E62333D2E9A0B87E4932'; plain: '48DE5F4845276C8F'),

    (obj: TrhlSnefru128r4; hash: 'C22A5255C0310CA2FB86286C70FB4434'; plain: ''),
    (obj: TrhlSnefru128r4; hash: 'D1DEE4876CCE6EE39B3703DC3BDCC143'; plain: '@'),
    (obj: TrhlSnefru128r4; hash: 'xE6747E75FF906E2F06F25F57221EF6A4'; plain: '48DE5F4845276C8F'),

    (obj: TrhlSnefru256r4; hash: 'F1B1BCE4285633DBBDCDB34710A469008F958063235CC893D0E281451DB67131'; plain: ''),
    (obj: TrhlSnefru256r4; hash: '49ACC90AD7A151725CC3EBED1137EE3E4465876EFCE3A0D0F8DAA0F70628B557'; plain: '@'),
    (obj: TrhlSnefru256r4; hash: 'x4A9DC879589177F0D426170F7ED4E6DD66F5A8596367E52AC4AE6057BB123ADC'; plain: '48DE5F4845276C8F'),

    (obj: TrhlSnefru128r8; hash: 'AA2532A1422095F6E8DBFF85FD6EF2BC'; plain: ''),
    (obj: TrhlSnefru128r8; hash: 'E77E9F09CC4AF48309614980A1A198B0'; plain: '@'),
    (obj: TrhlSnefru128r8; hash: 'x46B037D10414597DFBD76FD33582526E'; plain: '48DE5F4845276C8F'),

    (obj: TrhlSnefru256r8; hash: 'A4DF4C0A4AF3DAD3B7E9F4200144F74D6F44F875AB32715F5664119D676F8D19'; plain: ''),
    (obj: TrhlSnefru256r8; hash: 'E9EF2666CDB8D94AEBF72A98DB2E03AEFB9531D3798EAC055601F1FD5628EAEA'; plain: '@'),
    (obj: TrhlSnefru256r8; hash: 'xE24F23FCB6A202860B72E40D711920FC1020506EC8F0E244FDF2F6D8616273AE'; plain: '48DE5F4845276C8F'),

    (obj: TrhlAdler32; hash: '01000000'; plain: ''),
    (obj: TrhlAdler32; hash: '41004100'; plain: '@'),
    (obj: TrhlAdler32; hash: 'xC900FB00'; plain: '3197'),
    (obj: TrhlAdler32; hash: 'x4F010D02'; plain: '4D22DF'),
    (obj: TrhlAdler32; hash: 'x24021805'; plain: '6CCD13D7'),

    (obj: TrhlCRC32_IEEE_802_3; hash: '00000000'; plain: ''),
    (obj: TrhlCRC32_IEEE_802_3; hash: '1DAEDEA4'; plain: '@'),
    (obj: TrhlCRC32_IEEE_802_3; hash: 'xAA13EFE9'; plain: '3197'),
    (obj: TrhlCRC32_IEEE_802_3; hash: 'xE44EDD36'; plain: '4D22DF'),
    (obj: TrhlCRC32_IEEE_802_3; hash: 'x51949BB0'; plain: '6CCD13D7'),

    (obj: TrhlCRC32_Koopman; hash: '00000000'; plain: ''),
    (obj: TrhlCRC32_Koopman; hash: '65C0CA4A'; plain: '@'),
    (obj: TrhlCRC32_Koopman; hash: 'x248220B6'; plain: '3197'),
    (obj: TrhlCRC32_Koopman; hash: 'x098B6051'; plain: '4D22DF'),
    (obj: TrhlCRC32_Koopman; hash: 'x9838DBAA'; plain: '6CCD13D7'),

    (obj: TrhlCRC32_Castagnoli; hash: '00000000'; plain: ''),
    (obj: TrhlCRC32_Castagnoli; hash: 'ED4E0613'; plain: '@'),
    (obj: TrhlCRC32_Castagnoli; hash: 'xDA65EFE4'; plain: '3197'),
    (obj: TrhlCRC32_Castagnoli; hash: 'x6125C171'; plain: '4D22DF'),
    (obj: TrhlCRC32_Castagnoli; hash: 'xDD7135FA'; plain: '6CCD13D7'),

    (obj: TrhlCRC32_Q; hash: '00000000'; plain: ''),
    (obj: TrhlCRC32_Q; hash: 'C0C33537'; plain: '@'),
    (obj: TrhlCRC32_Q; hash: 'x1C12DB79'; plain: '3197'),
    (obj: TrhlCRC32_Q; hash: 'x20F4E183'; plain: '4D22DF'),
    (obj: TrhlCRC32_Q; hash: 'x3CC3ADCE'; plain: '6CCD13D7'),

    (obj: TrhlCRC64_ISO; hash: '0000000000000000'; plain: ''),
    (obj: TrhlCRC64_ISO; hash: '0000000000009003'; plain: '@'),
    (obj: TrhlCRC64_ISO; hash: 'x000000000020C3A8'; plain: '3197'),
    (obj: TrhlCRC64_ISO; hash: 'x0000000060F95AC9'; plain: '4D22DF'),
    (obj: TrhlCRC64_ISO; hash: 'x000000D05E91F6C4'; plain: '6CCD13D7'),

    (obj: TrhlCRC64_ECMA182; hash: '0000000000000000'; plain: ''),
    (obj: TrhlCRC64_ECMA182; hash: 'F8B8A48FB98A1B7B'; plain: '@'),
    (obj: TrhlCRC64_ECMA182; hash: 'xD49B3BAEA1F7B8FE'; plain: '3197'),
    (obj: TrhlCRC64_ECMA182; hash: 'xD37446DDE80C16C0'; plain: '4D22DF'),
    (obj: TrhlCRC64_ECMA182; hash: 'xA86E9982AFA6605C'; plain: '6CCD13D7'),

    (obj: TrhlAP; hash: '00000000'; plain: ''),
    (obj: TrhlAP; hash: '40000000'; plain: '@'),
    (obj: TrhlAP; hash: 'x5877FEFF'; plain: '3197'),
    (obj: TrhlAP; hash: 'xBFECC91E'; plain: '4D22DF'),
    (obj: TrhlAP; hash: 'x1C105084'; plain: '6CCD13D7'),

    (obj: TrhlBernstein; hash: '05150000'; plain: ''),
    (obj: TrhlBernstein; hash: 'E5B50200'; plain: '@'),
    (obj: TrhlBernstein; hash: 'x2D715900'; plain: '3197'),
    (obj: TrhlBernstein; hash: 'xB3FF870B'; plain: '4D22DF'),
    (obj: TrhlBernstein; hash: 'xC8B39B7C'; plain: '6CCD13D7'),

    (obj: TrhlBernstein1; hash: '05150000'; plain: ''),
    (obj: TrhlBernstein1; hash: 'E5B50200'; plain: '@'),
    (obj: TrhlBernstein1; hash: 'x83685900'; plain: '3197'),
    (obj: TrhlBernstein1; hash: 'xD5CC870B'; plain: '4D22DF'),
    (obj: TrhlBernstein1; hash: 'x40896D7C'; plain: '6CCD13D7'),

    (obj: TrhlBKDR; hash: '00000000'; plain: ''),
    (obj: TrhlBKDR; hash: '40000000'; plain: '@'),
    (obj: TrhlBKDR; hash: 'xAA190000'; plain: '3197'),
    (obj: TrhlBKDR; hash: 'xFA3B1400'; plain: '4D22DF'),
    (obj: TrhlBKDR; hash: 'x2976AE0E'; plain: '6CCD13D7'),

    (obj: TrhlDEK; hash: '00000000'; plain: ''),
    (obj: TrhlDEK; hash: '60000000'; plain: '@'),
    (obj: TrhlDEK; hash: 'xB70E0000'; plain: '3197'),
    (obj: TrhlDEK; hash: 'x9FB00000'; plain: '4D22DF'),
    (obj: TrhlDEK; hash: 'xB7367500'; plain: '6CCD13D7'),

    (obj: TrhlDJB; hash: '05150000'; plain: ''),
    (obj: TrhlDJB; hash: 'E5B50200'; plain: '@'),
    (obj: TrhlDJB; hash: 'x2D715900'; plain: '3197'),
    (obj: TrhlDJB; hash: 'xB3FF870B'; plain: '4D22DF'),
    (obj: TrhlDJB; hash: 'xC8B39B7C'; plain: '6CCD13D7'),

    (obj: TrhlELF; hash: '00000000'; plain: ''),
    (obj: TrhlELF; hash: '40000000'; plain: '@'),
    (obj: TrhlELF; hash: 'xA7030000'; plain: '3197'),
    (obj: TrhlELF; hash: 'xFF4F0000'; plain: '4D22DF'),
    (obj: TrhlELF; hash: 'x078F0700'; plain: '6CCD13D7'),

    (obj: TrhlFNV; hash: 'C59D1C81'; plain: ''),
    (obj: TrhlFNV; hash: '5F5D0C05'; plain: '@'),
    (obj: TrhlFNV; hash: 'xFDAF7620'; plain: '3197'),
    (obj: TrhlFNV; hash: 'x03892FFB'; plain: '4D22DF'),
    (obj: TrhlFNV; hash: 'x9A5218C6'; plain: '6CCD13D7'),

    (obj: TrhlFNV1a; hash: 'C59D1C81'; plain: ''),
    (obj: TrhlFNV1a; hash: '5FF80BC5'; plain: '@'),
    (obj: TrhlFNV1a; hash: 'xD1BFEB7A'; plain: '3197'),
    (obj: TrhlFNV1a; hash: 'x43EA0C9D'; plain: '4D22DF'),
    (obj: TrhlFNV1a; hash: 'x2C331A24'; plain: '6CCD13D7'),

    (obj: TrhlJenkins3; hash: 'x00000000'; plain: ''),
    (obj: TrhlJenkins3; hash: 'x6ECACBFB'; plain: '40'),
    (obj: TrhlJenkins3; hash: 'x73A267D7'; plain: '3197'),
    (obj: TrhlJenkins3; hash: 'x08E978AF'; plain: '4D22DF'),
    (obj: TrhlJenkins3; hash: 'x1704142A'; plain: '6CCD13D7'),
    (obj: TrhlJenkins3; hash: 'x0661DF9C'; plain: 'D8D9C639AE'),
    (obj: TrhlJenkins3; hash: 'xDE1734CF'; plain: 'FBC4AB9E4B2F'),
    (obj: TrhlJenkins3; hash: 'xB2991C9D'; plain: 'D19BEB74934639'),
    (obj: TrhlJenkins3; hash: 'x80225BAB'; plain: '48DE5F4845276C8F'),
    (obj: TrhlJenkins3; hash: 'x55D6ABD0'; plain: '8E854990BC47A07EAA'),
    (obj: TrhlJenkins3; hash: 'x3C7AC54E'; plain: '4EB0FE433C6B87F34B29'),
    (obj: TrhlJenkins3; hash: 'x53D5BF82'; plain: 'BE497843C5834987519441'),
    (obj: TrhlJenkins3; hash: 'xEFC35F97'; plain: '8331CA2956433A094249FDBE'),
    (obj: TrhlJenkins3; hash: 'x376B8A59'; plain: 'BF62FA2EECBE87D080E92C37EB'),
    (obj: TrhlJenkins3; hash: 'x64DFDF02'; plain: '4A8BAE394046AFBC47D690224CB9'),
    (obj: TrhlJenkins3; hash: 'xF4063FFD'; plain: '78D9CE79AFC1E0C41E2A48278E4B4B'),
    (obj: TrhlJenkins3; hash: 'x54B9346D'; plain: '816B650FB50D8E848DB94034628FC520'),
    (obj: TrhlJenkins3; hash: 'xB3CF81AA'; plain: '629768E3633858B4D23D04773DA28CBCFB'),
    (obj: TrhlJenkins3; hash: 'xEC7BCF2D'; plain: '55462FF88CDF40292838C888B71D16EA5D88'),
    (obj: TrhlJenkins3; hash: 'xBEDAB10B'; plain: 'C69924B3A64312DB5808B1C3AD05C05413E958'),
    (obj: TrhlJenkins3; hash: 'x095853E1'; plain: '5A6462CE04496BA8DCF67799EE4CAB353E337A47'),
    (obj: TrhlJenkins3; hash: 'x7A04804E'; plain: '99F397D1268B57091AA4A299685C3826FC77196E21'),
    (obj: TrhlJenkins3; hash: 'xA30093B9'; plain: '7A78E5E46E36837950F3D53061C0789B90F5374CEC88'),
    (obj: TrhlJenkins3; hash: 'x7DEF29B3'; plain: 'A0DAC9754045558650DA891AFB3EC312CCF85D3300D426'),
    (obj: TrhlJenkins3; hash: 'x8F3195F2'; plain: '0B69E8AA8DEED1859D2B7FF78D07DCEDE826A872E66E0AE1'),
    (obj: TrhlJenkins3; hash: 'x866C0FE4'; plain: '3ECD10659E510DD8F28C8DDABAA5790C640A77C8243F958C9C'),
    (obj: TrhlJenkins3; hash: 'x68959A91'; plain: '2618CDDCA206E42E247BE6474224E5A634377B9AD6C4BAC621D6'),
    (obj: TrhlJenkins3; hash: 'xCB29B29A'; plain: '55314A0198F4C4623A364C3B81F45D079EDA66F50C44BB33E8279F'),
    (obj: TrhlJenkins3; hash: 'xB0F975F3'; plain: 'FCED8CDC4690D5F10121060934800A4B881DE2CA9B1F206C76658D0C'),
    (obj: TrhlJenkins3; hash: 'x07FD2158'; plain: 'C89186812C99D936B8751D6901CA1892C03D8FB0B72B60A7A87BA20A93'),
    (obj: TrhlJenkins3; hash: 'xC672603A'; plain: '1915A470840704DA66E2384473A79AB5D98924B7EDB4FD6329975F0A49D3'),
    (obj: TrhlJenkins3; hash: 'x4C04EEB0'; plain: '3C256BF4BC51F5BD41B1480C641BF721630AC4165B490CA14E324E49136D9F'),
    (obj: TrhlJenkins3; hash: 'xF8A2637F'; plain: '2E86993AA9577E0176DEE507BF649F9358EEBE67CEAFA2D4C10ACE8D4BE895AD'),
    (obj: TrhlJenkins3; hash: 'x364C456E'; plain: '015ECA91AB59E81C9486D97C079CBE1867834BD5B03C3AE3C65A9FBB842643FD84'),
    (obj: TrhlJenkins3; hash: 'x3D2B32D7'; plain: 'EBECF3C5A7476DBB35D348DBEC5A0EB7B3A5499BE07B8FCD489A7B56E07F0A91D196'),
    (obj: TrhlJenkins3; hash: 'x9040BD1A'; plain: '4971FB343551CA6D29F63D2260F4158E2467304ECE74DF2CA1410B338726BF3ED9BB4B'),
    (obj: TrhlJenkins3; hash: 'x32E67B62'; plain: 'F5E91932E0D1AE09905D4680BD42ECC7FBEC8A21C96EB71DFA0C6062BE8E9C6B187E3B81'),
    (obj: TrhlJenkins3; hash: 'x916CA386'; plain: '9C4F0FBE8D3A23204B11E776E474D359626D5BCEEA3F4C9A3F9F939CEA88F7CBF71E99A8D5'),

    (obj: TrhlJS; hash: 'x'+'A7C6674E'; plain: ''),
    (obj: TrhlJS; hash: 'x'+'6E00F5AE'; plain: '40'),
    (obj: TrhlJS; hash: 'x'+'2344A8A4'; plain: '3197'),
    (obj: TrhlJS; hash: 'x'+'65949B1A'; plain: '4D22DF'),
    (obj: TrhlJS; hash: 'x'+'DAF0BB40'; plain: '6CCD13D7'),

    (obj: TrhlOneAtTime; hash: 'x'+'00000000'; plain: ''),
    (obj: TrhlOneAtTime; hash: 'x'+'6DA7BF93'; plain: '40'),
    (obj: TrhlOneAtTime; hash: 'x'+'02D4B205'; plain: '3197'),
    (obj: TrhlOneAtTime; hash: 'x'+'29CE3489'; plain: '4D22DF'),
    (obj: TrhlOneAtTime; hash: 'x'+'9D5163D0'; plain: '6CCD13D7'),

    (obj: TrhlPJW; hash: 'x'+'00000000'; plain: ''),
    (obj: TrhlPJW; hash: 'x'+'40000000'; plain: '40'),
    (obj: TrhlPJW; hash: 'x'+'A7030000'; plain: '3197'),
    (obj: TrhlPJW; hash: 'x'+'FF4F0000'; plain: '4D22DF'),
    (obj: TrhlPJW; hash: 'x'+'078F0700'; plain: '6CCD13D7'),

    (obj: TrhlRotating; hash: 'x'+'00000000'; plain: ''),
    (obj: TrhlRotating; hash: 'x'+'40000000'; plain: '40'),
    (obj: TrhlRotating; hash: 'x'+'87030000'; plain: '3197'),
    (obj: TrhlRotating; hash: 'x'+'FF4F0000'; plain: '4D22DF'),
    (obj: TrhlRotating; hash: 'x'+'E70C0600'; plain: '6CCD13D7'),

    (obj: TrhlRS; hash: 'x'+'00000000'; plain: ''),
    (obj: TrhlRS; hash: 'x'+'40000000'; plain: '40'),
    (obj: TrhlRS; hash: 'x'+'16DFF80E'; plain: '3197'),
    (obj: TrhlRS; hash: 'x'+'1C13536C'; plain: '4D22DF'),
    (obj: TrhlRS; hash: 'x'+'8B87CA50'; plain: '6CCD13D7'),

    (obj: TrhlSDBM; hash: 'x'+'00000000'; plain: ''),
    (obj: TrhlSDBM; hash: 'x'+'40000000'; plain: '40'),
    (obj: TrhlSDBM; hash: 'x'+'A60C3100'; plain: '3197'),
    (obj: TrhlSDBM; hash: 'x'+'0AB30C26'; plain: '4D22DF'),
    (obj: TrhlSDBM; hash: 'x'+'6580E505'; plain: '6CCD13D7'),

    (obj: TrhlShiftAndXor; hash: 'x'+'00000000'; plain: ''),
    (obj: TrhlShiftAndXor; hash: 'x'+'40000000'; plain: '40'),
    (obj: TrhlShiftAndXor; hash: 'x'+'F2060000'; plain: '3197'),
    (obj: TrhlShiftAndXor; hash: 'x'+'DD3F0100'; plain: '4D22DF'),
    (obj: TrhlShiftAndXor; hash: 'x'+'4B7F3800'; plain: '6CCD13D7'),

    (obj: TrhlSuperFast; hash: 'x'+'00000000'; plain: ''),
    (obj: TrhlSuperFast; hash: 'x'+'15C33F97'; plain: '40'),
    (obj: TrhlSuperFast; hash: 'x'+'7A45AEC2'; plain: '3197'),
    (obj: TrhlSuperFast; hash: 'x'+'F31EFBA2'; plain: '4D22DF'),
    (obj: TrhlSuperFast; hash: 'x'+'6615B0B5'; plain: '6CCD13D7'),
    (obj: TrhlSuperFast; hash: 'x'+'E721642C'; plain: 'D8D9C639AE'),
    (obj: TrhlSuperFast; hash: 'x'+'97688774'; plain: 'FBC4AB9E4B2F'),
    (obj: TrhlSuperFast; hash: 'x'+'B42B4CB9'; plain: 'D19BEB74934639'),
    (obj: TrhlSuperFast; hash: 'x'+'C01FB003'; plain: '48DE5F4845276C8F'),
    (obj: TrhlSuperFast; hash: 'x'+'6C9F5EF8'; plain: '8E854990BC47A07EAA'),
    (obj: TrhlSuperFast; hash: 'x'+'633D75D2'; plain: '4EB0FE433C6B87F34B29'),
    (obj: TrhlSuperFast; hash: 'x'+'E6360E5E'; plain: 'BE497843C5834987519441'),
    (obj: TrhlSuperFast; hash: 'x'+'FD6AC728'; plain: '8331CA2956433A094249FDBE'),
    (obj: TrhlSuperFast; hash: 'x'+'A17E7005'; plain: 'BF62FA2EECBE87D080E92C37EB'),

    (obj: TrhlFNV1a64; hash: 'x'+'25232284E49CF2CB'; plain: ''),
    (obj: TrhlFNV1a64; hash: 'x'+'9F2402864CFD63AF'; plain: '40'),
    (obj: TrhlFNV1a64; hash: 'x'+'D163B9B40731F807'; plain: '3197'),
    (obj: TrhlFNV1a64; hash: 'x'+'03D06FB41912421D'; plain: '4D22DF'),
    (obj: TrhlFNV1a64; hash: 'x'+'CC29A152AFEBF71F'; plain: '6CCD13D7'),

    (obj: TrhlFNV64; hash: 'x'+'25232284E49CF2CB'; plain: ''),
    (obj: TrhlFNV64; hash: 'x'+'9FB701864CBD63AF'; plain: '40'),
    (obj: TrhlFNV64; hash: 'x'+'FD89EBB407973208'; plain: '3197'),
    (obj: TrhlFNV64; hash: 'x'+'830F316B188247D8'; plain: '4D22DF'),
    (obj: TrhlFNV64; hash: 'x'+'1A5D0AC87EE77FD2'; plain: '6CCD13D7')
  );

  stwk: array[0..69] of record
    obj: TrhlHashWithKeyClass;
    hash: ansistring;
    key: ansistring;
    plain: ansistring;
  end = (
    (obj: TrhlMurmur2; hash: 'x'+'00000000'; key: '7B1A8FC5'; plain: ''),
    (obj: TrhlMurmur2; hash: 'x'+'A8E8A4CE'; key: '7B1A8FC5'; plain: '40'),
    (obj: TrhlMurmur2; hash: 'x'+'CAD35951'; key: '7B1A8FC5'; plain: '974D'),
    (obj: TrhlMurmur2; hash: 'x'+'B9C68D6F'; key: '7B1A8FC5'; plain: '6CCD13'),
    (obj: TrhlMurmur2; hash: 'x'+'D0FBB8CA'; key: '7B1A8FC5'; plain: 'C639AEFB'),
    (obj: TrhlMurmur2; hash: 'x'+'EE56909A'; key: '7B1A8FC5'; plain: '2FD19BEB74'),

    (obj: TrhlMurmur2; hash: 'x'+'00000000'; key: 'E60E3263'; plain: ''),
    (obj: TrhlMurmur2; hash: 'x'+'71F0AC63'; key: 'E60E3263'; plain: '31'),
    (obj: TrhlMurmur2; hash: 'x'+'2BB8BEA4'; key: 'E60E3263'; plain: '22DF'),
    (obj: TrhlMurmur2; hash: 'x'+'4168073E'; key: 'E60E3263'; plain: 'D7D8D9'),
    (obj: TrhlMurmur2; hash: 'x'+'C21B8F10'; key: 'E60E3263'; plain: 'C4AB9E4B'),
    (obj: TrhlMurmur2; hash: 'x'+'FEF0CB7C'; key: 'E60E3263'; plain: '93463948DE'),

    (obj: TrhlMurmur3; hash: 'x'+'86991F82'; key: '7B1A8FC5'; plain: ''),
    (obj: TrhlMurmur3; hash: 'x'+'EBD052D6'; key: '7B1A8FC5'; plain: '40'),
    (obj: TrhlMurmur3; hash: 'x'+'C1B4E96C'; key: '7B1A8FC5'; plain: '974D'),
    (obj: TrhlMurmur3; hash: 'x'+'2ED5BB6A'; key: '7B1A8FC5'; plain: '6CCD13'),
    (obj: TrhlMurmur3; hash: 'x'+'EA9F514F'; key: '7B1A8FC5'; plain: 'C639AEFB'),
    (obj: TrhlMurmur3; hash: 'x'+'8B960B1C'; key: '7B1A8FC5'; plain: '2FD19BEB74'),

    (obj: TrhlMurmur3; hash: 'x'+'A1F371BB'; key: '24B0B688'; plain: ''),
    (obj: TrhlMurmur3; hash: 'x'+'CBFF3699'; key: '24B0B688'; plain: '31'),
    (obj: TrhlMurmur3; hash: 'x'+'8A80C26F'; key: '24B0B688'; plain: '22DF'),
    (obj: TrhlMurmur3; hash: 'x'+'09C1C637'; key: '24B0B688'; plain: 'D7D8D9'),
    (obj: TrhlMurmur3; hash: 'x'+'B2DE2BE4'; key: '24B0B688'; plain: 'C4AB9E4B'),
    (obj: TrhlMurmur3; hash: 'x'+'D15391EC'; key: '24B0B688'; plain: '93463948DE'),

    (obj: TrhlMurmur2_64; hash: 'x'+'0000000000000000'; key: '7B1A8FC5'; plain: ''),
    (obj: TrhlMurmur2_64; hash: 'x'+'8587975F5F7E7E51'; key: '7B1A8FC5'; plain: '40'),
    (obj: TrhlMurmur2_64; hash: 'x'+'E024B75CAD1A49C2'; key: '7B1A8FC5'; plain: '974D'),
    (obj: TrhlMurmur2_64; hash: 'x'+'CE282A81392E8D5C'; key: '7B1A8FC5'; plain: '6CCD13'),
    (obj: TrhlMurmur2_64; hash: 'x'+'2A6913486D8BD97D'; key: '7B1A8FC5'; plain: 'C639AEFB'),
    (obj: TrhlMurmur2_64; hash: 'x'+'296AD7D13920DE29'; key: '7B1A8FC5'; plain: '2FD19BEB74'),
    (obj: TrhlMurmur2_64; hash: 'x'+'198CC78B144DA2F5'; key: '7B1A8FC5'; plain: '5F4845276C8F'),
    (obj: TrhlMurmur2_64; hash: 'x'+'96BEA7667042193D'; key: '7B1A8FC5'; plain: 'A07EAA4EB0FE43'),
    (obj: TrhlMurmur2_64; hash: 'x'+'2780296C30C62DA0'; key: '7B1A8FC5'; plain: '497843C583498751'),
    (obj: TrhlMurmur2_64; hash: 'x'+'4C6EEA6B53AD751F'; key: '7B1A8FC5'; plain: '3A094249FDBEBF62FA'),
    (obj: TrhlMurmur2_64; hash: 'x'+'EB949B263B616965'; key: '7B1A8FC5'; plain: 'EB4A8BAE394046AFBC47'),
    (obj: TrhlMurmur2_64; hash: 'x'+'5352AD98D33C3D2F'; key: '7B1A8FC5'; plain: 'C1E0C41E2A48278E4B4B81'),
    (obj: TrhlMurmur2_64; hash: 'x'+'64E1A45F3C971ED9'; key: '7B1A8FC5'; plain: '628FC520629768E3633858B4'),
    (obj: TrhlMurmur2_64; hash: 'x'+'8831CCCA73CFFF0C'; key: '7B1A8FC5'; plain: 'F88CDF40292838C888B71D16EA'),
    (obj: TrhlMurmur2_64; hash: 'x'+'FDC402E1FD7F8687'; key: '7B1A8FC5'; plain: 'C3AD05C05413E9585A6462CE0449'),
    (obj: TrhlMurmur2_64; hash: 'x'+'9AD3A516A28E82F0'; key: '7B1A8FC5'; plain: '99F397D1268B57091AA4A299685C38'),
    (obj: TrhlMurmur2_64; hash: 'x'+'6224A70764AF7D3F'; key: '7B1A8FC5'; plain: 'F3D53061C0789B90F5374CEC88A0DAC9'),
    (obj: TrhlMurmur2_64; hash: 'x'+'F30864CC62A09F17'; key: '7B1A8FC5'; plain: '3300D4260B69E8AA8DEED1859D2B7FF78D'),
    (obj: TrhlMurmur2_64; hash: 'x'+'8FBE346FF1137921'; key: '7B1A8FC5'; plain: '0DD8F28C8DDABAA5790C640A77C8243F958C'),
    (obj: TrhlMurmur2_64; hash: 'x'+'FD0068FC9D210DE4'; key: 'E60E3263'; plain: 'B7B3A5499BE07B8FCD489A7B56E07F0A91D1964971FB3435'),

    (obj: TrhlSipHash; hash: 'x'+'310E0EDD47DB6F72'; key: '000102030405060708090A0B0C0D0E0F'; plain: ''),
    (obj: TrhlSipHash; hash: 'x'+'9C58AD7C50BB3826'; key: '175710446750988ED9A8D2B460D23F85'; plain: ''),
    (obj: TrhlSipHash; hash: 'x'+'6872F312481CF16F'; key: '000102030405060708090A0B0C0D0E0F'; plain: '40'),
    (obj: TrhlSipHash; hash: 'x'+'6CC07811ADFC5222'; key: '175710446750988ED9A8D2B460D23F85'; plain: '31'),
    (obj: TrhlSipHash; hash: 'x'+'DBCACE3C2E078894'; key: '000102030405060708090A0B0C0D0E0F'; plain: '974D'),
    (obj: TrhlSipHash; hash: 'x'+'2D80286A224BACB0'; key: '000102030405060708090A0B0C0D0E0F'; plain: '497843C583498751'),

    (obj: TrhlMurmur3_128; hash: 'x'+'6E4718DF51C270B92DAD702FF62D055F'; key: '7B1A8FC5'; plain: ''),
    (obj: TrhlMurmur3_128; hash: 'x'+'8231C291DB6D160C806D7487EBC68F92'; key: '7B1A8FC5'; plain: '40'),
    (obj: TrhlMurmur3_128; hash: 'x'+'056951A64E2DBFB2C198161C6EAAC683'; key: '7B1A8FC5'; plain: '974D'),
    (obj: TrhlMurmur3_128; hash: 'x'+'3C0346B6359803CB06CAC722E8B438FF'; key: '7B1A8FC5'; plain: '6CCD13'),
    (obj: TrhlMurmur3_128; hash: 'x'+'321BC94F197860E6AC1656F35BF54980'; key: '7B1A8FC5'; plain: 'C639AEFB'),
    (obj: TrhlMurmur3_128; hash: 'x'+'FADFA1837804DE4B7B9A0AF214C73CA2'; key: '7B1A8FC5'; plain: '2FD19BEB74'),
    (obj: TrhlMurmur3_128; hash: 'x'+'B8C77BB8AA41056A039B0214BAAF7CB9'; key: '7B1A8FC5'; plain: '5F4845276C8F'),
    (obj: TrhlMurmur3_128; hash: 'x'+'319C703C68351759C874816547C79C21'; key: '7B1A8FC5'; plain: 'A07EAA4EB0FE43'),
    (obj: TrhlMurmur3_128; hash: 'x'+'DAF8F0FF5D72E060A178C836B2683432'; key: '7B1A8FC5'; plain: '497843C583498751'),
    (obj: TrhlMurmur3_128; hash: 'x'+'582EF5AB34209E4F4503981056B3F419'; key: '7B1A8FC5'; plain: '3A094249FDBEBF62FA'),
    (obj: TrhlMurmur3_128; hash: 'x'+'09BCE3208780D6079E845339A8B224B5'; key: '7B1A8FC5'; plain: 'EB4A8BAE394046AFBC47'),
    (obj: TrhlMurmur3_128; hash: 'x'+'FA2CDFFFBC13169DEA2A53CF1D9EF1A4'; key: '7B1A8FC5'; plain: 'C1E0C41E2A48278E4B4B81'),
    (obj: TrhlMurmur3_128; hash: 'x'+'2BDC63CFBC9B45F5FEBF6C2854559907'; key: '7B1A8FC5'; plain: '628FC520629768E3633858B4'),
    (obj: TrhlMurmur3_128; hash: 'x'+'A437DC70D1671625A257C89ACF0EC507'; key: '7B1A8FC5'; plain: 'F88CDF40292838C888B71D16EA'),
    (obj: TrhlMurmur3_128; hash: 'x'+'E47D7451AF14496D09B6A8CED70C8EFC'; key: '7B1A8FC5'; plain: 'C3AD05C05413E9585A6462CE0449'),
    (obj: TrhlMurmur3_128; hash: 'x'+'25F64356FFED8222AFD2BB709E0194E9'; key: '7B1A8FC5'; plain: '99F397D1268B57091AA4A299685C38'),
    (obj: TrhlMurmur3_128; hash: 'x'+'B3E72C110948C8C9D9257A94798A8F56'; key: '7B1A8FC5'; plain: 'F3D53061C0789B90F5374CEC88A0DAC9'),
    (obj: TrhlMurmur3_128; hash: 'x'+'FDA965D783B39A586CFF2BE3E760A612'; key: '7B1A8FC5'; plain: '3300D4260B69E8AA8DEED1859D2B7FF78D'),
    (obj: TrhlMurmur3_128; hash: 'x'+'F075CC9D21C52901F529243DD229524D'; key: '7B1A8FC5'; plain: '0DD8F28C8DDABAA5790C640A77C8243F958C'),
    (obj: TrhlMurmur3_128; hash: 'x'+'2D33081A712AF21969491E8EA1F0F6D1'; key: 'BA6BF557'; plain: 'B7B3A5499BE07B8FCD489A7B56E07F0A91D1964971FB3435')
  );

function RHLSelfTest(ALog: TStrings = nil): Boolean;

implementation

uses
  sysutils, strutils, Dialogs;

function StringToHexString(s: string; separator: string = ':'): string;
var
  i, j: integer;
begin
  Result := '';
  j := Length(s);
  for i := 1 to j do
  begin
    Result := Result + Format('%.2x', [byte(s[i])]);
    if i < j then
      Result := Result + separator;
  end;
end;

function HexStringToString(s: string; separator: string = ''): string;
var
  i: integer;
begin
  if Length(separator) > 0 then
  begin
    Result := '';
    for i := 1 to Length(s) do
      if s[i] <> separator[1] then
        Result := Result + s[i];
    s := Result;
  end;

  Result := '';
  for i := 1 to Length(s) div 2 do
    Result := Result + char(Hex2Dec(s[i * 2 - 1] + s[i * 2]));
end;

function RHLSelfTest(ALog: TStrings): Boolean;
var
  i: Integer;
  s, p, h, k: ansistring;
  b: Boolean;
begin
  Result := True;
  // st
  for i := Low(st) to High(st) do
  begin
    h := st[i].hash;
    if Pos('x', h) = 1 then
    begin
      p := HexStringToString(st[i].plain);
      Delete(h, 1, 1);
    end
    else
    begin
      p := st[i].plain;
    end;
    h := HexStringToString(h);

    s := rhlHash(p, st[i].obj);
    b := s = h;
    Result := Result and b;
    if Assigned(ALog) then
    begin
      ALog.Append(Format('%-40s %s', [st[i].obj.ClassName, BoolToStr(b, 'OK', 'FAIL')]));
      if not b then
      begin
        ALog.Append(Format('%s<>%s', [StringToHexString(h, ''), StringToHexString(s, '')]));
      end;
    end;
  end;

  // stwk
  for i := Low(stwk) to High(stwk) do
  begin
    h := stwk[i].hash;
    if Pos('x', h) = 1 then
    begin
      p := HexStringToString(stwk[i].plain);
      k := HexStringToString(stwk[i].key);
      Delete(h, 1, 1);
    end
    else
    begin
      k := '';
      p := stwk[i].plain;
    end;
    h := HexStringToString(h);

    s := rhlHash(p, k, stwk[i].obj);
    b := s = h;
    Result := Result and b;
    if Assigned(ALog) then
    begin
      ALog.Append(Format('%-40s %s', [stwk[i].obj.ClassName, BoolToStr(b, 'OK', 'FAIL')]));
      if not b then
      begin
        ALog.Append(Format('%s<>%s', [StringToHexString(h, ''), StringToHexString(s, '')]));
      end;
    end;
  end;

end;

end.
