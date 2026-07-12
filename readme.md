# mtv (cloned from Ratpac 2 Example Simulation)

This repository holds the simulation and RATDB files used to create the geometry for the directionality paper titled ["Enhancing Angular Sensitivity of Segmented Antineutrino Detectors for Reactor Monitoring"](https://link.aps.org/doi/10.1103/jrmk-r81s). Data files are too large to host on this repository, but can be made available upon reasonable request to the authors. The RATPAC2 RatpacExperiment repository is the template for this one, and it can be accessed [here](https://github.com/rat-pac/RatpacExperiment).

---

The reference data set for the binning matrices used for the directional reconstruction described in the paper was generated using 10 runs of the 1M event macro file `macros/mtv_ibd_1M.mac`. Post processing scripts for the ROOT files generated from the simulation are in the shell scripts `output/mtv_directionality/parseMCTruth.sh`, `output/mtv_directionality/parseNeutrons.sh`, and `output/mtv_directionality/parsePositrons.sh`. These scripts call the ROOT macros in `output/mtv_directionality/readMCTruth.C`, `output/mtv_directionality/readNeutrons.C`, and `output/mtv_directionality/readPositrons.C`. The data files generated from these scripts are then used in the analysis code found at the [neutrino-directionality](https://github.com/jgyepez/neutrino-directionality) repository.

---

## Version History:

11JUL2026: v 1.0.1 -- Hotfix 1.

Added MIT License for publication

26JUN2026: v 1.0.0 -- Initial Commit for publication and data availability
