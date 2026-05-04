# HRT Application Notes (throwaway)

## Key Numbers from GitLab/GitHub Scrape (Jan 2025 - May 2026)

### GitLab (internal AWS)
- **soca-config-utils**: 65 MRs authored (38 merged) — 70% of all 93 project MRs
- **das-handbook**: 36 MRs (27 merged) — documentation/runbooks
- **scale-out-computing-on-aws**: 14 MRs (8 merged) — upstream CQC fork
- **cqc-soca-fork**: 4 MRs (4 merged) — fork consolidation
- **soca-deployments/soca-qht-blue**: 7 MRs (2 merged) — blue cluster configs
- **Total**: 100 MRs across 7 repos, reviewed 28 MRs from 6 other engineers

### GitHub (public)
- **awslabs/palace**: 12 PRs (7 merged) — Spack CI, build system, docs pipeline
- **spack/spack-packages**: 5 PRs (5 merged) — Palace 0.13/0.14, ExaGO, ed
- **pnnl/ExaGO**: 27 PRs (22 merged) — CI/CD, spack, pipelines, releases
- **LLNL/hiop**: 26 PRs (17 merged, 2020-2024) — GPU sparse solver, CMake, CUDA/HIP
- **cameronrutherford (personal site)**: 9 commits since Jan 2025
- **Total GitHub contributions**: 122 (33 commits, 21 PRs, 10 issues, 2 new repos)

## HRT JD Mapping

| JD Requirement | My Experience |
|---|---|
| 5+ years relevant | 6+ years (PNNL 2020-2024, Amazon 2025-2026) |
| Linux install/config/troubleshoot | Ubuntu 22.04 AMI builds, slapd debugging, kernel D-state, dual-NIC routing |
| Large scale distributed HPC | 5 clusters, 3 regions, 256 nodes MPI, Frontier/Summit |
| Config management | CDK, Spack, patch workflows, cluster YAML configs |
| Python + Shell scripting | test.sh framework, PBS hooks, deploy-ami.sh, rsync.sh |
| Performance tuning | MPI collective benchmarking, Lustre throughput, CUDA/HIP profiling |
| Context switching | 14+ concurrent MRs, 7 repos, parallel worktree workflows |
| Debian/Ubuntu (plus) | All SOCA clusters Ubuntu 22.04, compiled OpenMPI 5.0.8 w/ GCC 14 |
| GPU Optimization (plus) | Frontier AMD MI250X, Summit V100, CUDA/HIP/RAJA, 26 PRs on HiOp |
| Cross-collaboration | 6 engineers reviewed, 27 docs pages, team architecture decisions |

## Things to potentially elaborate on in interviews

- **"Noisy neighbor" debugging**: EC2 networking team blocked c7g.16xlarge due to EFA traffic causing RX UDMA drops on co-located instances. I gathered CCMT capacity data across 3 regions to push back on the proposed workaround (switch to c7gn) showing 60% less capacity.
- **slapd fd exhaustion**: Diagnosed OpenLDAP file descriptor leak under 1000+ concurrent Managed AD connections. Wrote hotfix script, filed issue, ultimately drove migration to Managed AD which eliminated the class of failure entirely.
- **MPI scaling**: Validated OpenMPI 5.0.8 on Graviton ARM with EFA to 256 nodes. Identified PRTE hostfile bugs, dual-NIC routing conflicts on EFA instances, and bootstrap reliability issues where 1/N node failures block entire jobs.
- **Release strategy**: Authored the team's SOCA versioning proposal — CQC-YY.MM.PATCH, ALB-based blue/green cutover, rebuild-not-upgrade lifecycle, SOCA-lite shutdown plan. Accepted by team.
- **ExaGO on Frontier**: Scaled power grid optimization code from Summit (V100) to Frontier (MI250X). Required porting from CUDA to HIP via RAJA abstraction layer, rebuilding CI/CD for AMD GPUs.
