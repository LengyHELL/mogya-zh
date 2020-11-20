set ProductGroups;

param nRows;
param cashierCount;
param cashierLength;

param space{ProductGroups};

set SetRows := cashierCount + 1..nRows;
set SetCashierRows := 1..cashierCount;

var BuildingLength;

var Rows{SetRows, ProductGroups} binary;
var CashierRows{SetCashierRows, ProductGroups} binary;

s.t. noraml_row_length{s in SetRows}: BuildingLength >= sum{p in ProductGroups} Rows[s, p] * space[p];
s.t. cashier_row_length{s in SetCashierRows}: BuildingLength >= cashierLength + sum{p in ProductGroups} CashierRows[s, p] * space[p];
s.t. one_group_once{p in ProductGroups}: sum{sr in SetRows} Rows[sr, p] + sum{scr in SetCashierRows} CashierRows[scr, p] = 1;

minimize length_of_building: BuildingLength;

solve;
printf "%f\n",BuildingLength;

#for {s in SetRows} {
#  printf "Normal  %s:", s;
#  for {p in ProductGroups : Rows[s, p] > 0} {
#    printf " %s", p;
#  }
#  printf "\n";
#}
#
#for {s in SetCashierRows} {
#  printf "Cashier %s:", s;
#  for {p in ProductGroups : CashierRows[s, p] > 0} {
#    printf " %s", p;
#  }
#  printf "\n";
#}

data;
