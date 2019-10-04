#!/bin/bash

scripts=/Methods/Tools/Scripts

#cmd="$scripts/makePDF-Local.sh `realpath ../BufferStockTheory-Shared` BufferStockTheory"
#echo "$cmd"
# eval "$cmd"

cmd="$scripts/makePDF-Local.sh `realpath ../BufferStockTheory-Shared/Slides` BufferStockTheory-Slides"
echo "$cmd"
eval "$cmd"


