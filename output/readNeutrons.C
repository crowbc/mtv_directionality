{

  TFile *_file0 = TFile::Open("output.ntuple.root");

  auto T = (TTree*)_file0->Get("output");

  T->SetScanField(-1);

  T->Scan("trackPDG : trackPosX : trackPosY : trackPosZ : trackTime : trackMomX : trackMomY : trackMomZ : trackKE : trackProcess","trackPDG == 2112 || trackPDG == 1.00003006e+09 || trackPDG == 1.00001003e+09 || trackPDG == 1.00002004e+09","colsize=30 precision=9 col=::20.10");

}
