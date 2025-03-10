#!/bin/bash

datasets=("MUTAG" "PROTEINS" "IMDB-BINARY" "ENZYMES")
num_nodes=("20" "40")

for dataset in "${datasets[@]}" ; do
  for num_node in "${num_nodes[@]}" ; do

    python src/train.py --data $dataset \
    --model GCN \
    --num_node $num_node \
     --augment True \
     --cuda 0 \
     --aug_ratio 1.0 \
     --sample_dist beta \
     --beta_alpha 1.0 \
     --beta_beta 1.0

  done
done