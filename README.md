# Troubleshooting a SLURM time issue with Snakemake

 A colleague is having trouble with `Snakemake` on ComputeCanada's Cedar cluster with `Snakemake`.

The following is a **minimal reproducible example** describing the issue.

The example `Snakemake` has two rules:

* rule asking for `60 min` = **1 hour**
* rule asking for `480 min` = **8 hours**

The problem is likely:

* An error caused by `Snakemake-Profiles`
* An error cause by `Snakemake` + `Python version`

# Setup Snakemake + Snakemake Profile for SLURM

## Start-Fresh

First let's delete everything and start fresh.

```
rm -rf ~/.config/snakemake
rm -rf ~/.cookiecutter*
rm -rf ~/snakemake
```

## Setup `Python`

```
module load python/3.8.2
python3 -m venv ~/snakemake
source ~/snakemake/bin/activate
```

## Setup Snakemake Profile for SLURM scheduler

```
pip install cookiecutter
mkdir -p ~/.config/snakemake
cd ~/.config/snakemake
cookiecutter https://github.com/Snakemake-Profiles/slurm.git       
```

_Note: You will be asked for input so do the following:_

```
profile_name [slurm]:
sbatch_defaults []:
cluster_config []:
Select advanced_argument_conversion:
1 - no
2 - yes
Choose from 1, 2 [1]: 1
```

## Install `Snakemake`

```
pip install snakemake
```

# Run the example

## Change directory to scratch

```
cd /scratch/$USER
```

## Clone repo

```
git clone https://github.com/moldach/snakemake-SLURM-timeAllocation-troubleshooting.git
cd snakemake-SLURM-timeAllocation-troubleshooting
```

## Run `Snakemake`

```
bash -c "nohup snakemake --profile slurm --jobs 2 &"
```

### On my profile I see:

```
squeue -u $USER
```

```
(snakemake) [moldach@cedar5 snakemake-SLURM-timeAllocation-troubleshooting]$ squeue -u moldach
          JOBID     USER      ACCOUNT           NAME  ST  TIME_LEFT NODES CPUS TRES_PER_N MIN_MEM NODELIST (REASON) 
       64649511  moldach def-mtarailo snakejob.test_  PD    8:00:00     1    1        N/A   1000M  (Priority) 
       64649515  moldach def-mtarailo snakejob.test_  PD    1:00:00     1    1        N/A   1000M  (Priority) 
```


### On their profile they see:

```


```


