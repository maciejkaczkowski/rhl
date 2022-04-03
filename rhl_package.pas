{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit rhl_package;

{$warn 5023 off : no warning about unused units}
interface

uses
  rhlAdler32, rhlAP, rhlBernstein, rhlBernstein1, rhlBKDR, rhlCore, rhlCRC32, 
  rhlCRC64, rhlDEK, rhlDJB, rhlELF, rhlFNV, rhlFNV1a, rhlFNV1a64, rhlFNV64, 
  rhlGost, rhlGostBase, rhlGostCryptoPro, rhlGrindahl256, rhlGrindahl512, 
  rhlHAS160, rhlHAVAL, rhlHAVAL128, rhlHAVAL160, rhlHAVAL192, rhlHAVAL224, 
  rhlHAVAL256, rhlJenkins3, rhlJS, rhlKeccak, rhlMD2, rhlMD4, rhlMD5, 
  rhlMDBase, rhlMurmur2, rhlMurmur2_64, rhlMurmur3, rhlMurmur3_128, 
  rhlOneAtTime, rhlPanama, rhlPJW, rhlRadioGatun32, rhlRadioGatun64, 
  rhlRIPEMD, rhlRIPEMD128, rhlRIPEMD160, rhlRIPEMD256, rhlRIPEMD320, 
  rhlRotating, rhlRS, rhlSDBM, rhlSHA0, rhlSHA1, rhlSHA224, rhlSHA256, 
  rhlSHA256Base, rhlSHA384, rhlSHA512, rhlSHA512_224, rhlSHA512_256, 
  rhlSHA512Base, rhlShiftAndXor, rhlSipHash, rhlSnefru, rhlSuperFast, 
  rhlTests, rhlTiger, rhlTiger2, rhlTMDPA, rhlWhirlpool, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('rhl_package', @Register);
end.
