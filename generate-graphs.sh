#!/bin/bash

# Meta
dataset="MUTAG"
aug_ratio="0.1"
running_jobs=0
max_jobs=4

# HPs
num_nodes=(20 40)
mixup_alphas=("0.1" "0.3" "0.5")

for mixup_alpha in "${mixup_alphas[@]}"; do
  for num_node in "${num_nodes[@]}"; do
    python src/train.py \
      --data $dataset \
      --model GCN \
      --num_node $num_node \
      --augment True \
      --cuda 0 \
      --aug_ratio $aug_ratio \
      --sample_dist beta \
      --beta_alpha $mixup_alpha \
      --beta_beta $mixup_alpha &

    ((running_jobs++))
    if (( running_jobs >= max_jobs )); then
      wait -n
      ((running_jobs--))
    fi

  done
done
wait