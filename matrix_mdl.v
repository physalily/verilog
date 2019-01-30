/******************************
made 2019/1/16 powered harumaki
module name: matrix_mdl
this is matrix multipuly unit.
comment:
    nothing
parameter:
    DATA_SIZE
    COLUMN_SIZE
    ROW_SIZE
function list:
module matrix_mdl
+rowSum[22] 
+sumShift[16] 
+rowCal[1024]
    +VectorCal[16] 
        +multiplication_16[32] 
        +DRShift_16[32]
*function arg is bit width that use default parameter.
*******************************/

module matrix_mdl(clock, reset, enable, datsA, datsB, datsOut);
    parameter DATA_SIZE = 'd8;
    parameter COLUMN_SIZE = 'd64;
    parameter ROW_SIZE = 'd64;
    input clock;
    input reset;
    input enable;
    input[(DATA_SIZE * COLUMN_SIZE) -1:0] datsA;
    input[(DATA_SIZE * COLUMN_SIZE * ROW_SIZE) -1:0] datsB;
    output[(DATA_SIZE * COLUMN_SIZE) -1:0]datsOut;
    reg[(DATA_SIZE * COLUMN_SIZE) -1:0] datsOut;
    integer i = 0;//loop counter
    
    always @ (posedge clock or negedge reset)
    begin
    if(~reset)
    begin
        datsOut = 'h0;
    end
    else
    begin
        if(enable)
        begin
            for(i=0; i <COLUMN_SIZE; i =i+1)//64 is matrix columm size
            begin
                datsOut[i*DATA_SIZE +:DATA_SIZE] <= sumShift(rowSum(rowCal(datsA, datsB[i*(DATA_SIZE * ROW_SIZE)+:(DATA_SIZE * ROW_SIZE)])));
            end
        end
    end
    end

    function[(DATA_SIZE + (DATA_SIZE / 2)):0] rowSum;//DATA_SIZE -1bit x64 overflow size added
    input[(DATA_SIZE * COLUMN_SIZE) -1:0] dataset;
    integer i;
    for(i = 0; i <COLUMN_SIZE; i = i+1)
        rowSum = rowSum + dataset[i*DATA_SIZE +:DATA_SIZE ];      
    endfunction
    
    function[DATA_SIZE -1:0] sumShift;
    input[(DATA_SIZE + (DATA_SIZE / 2)):0] A;
    if(~(| A[(DATA_SIZE + (DATA_SIZE / 2)):DATA_SIZE]))
        sumShift = A;
    else
        sumShift = -1;//bit set all 1 
    endfunction

    function[(DATA_SIZE* COLUMN_SIZE) -1:0] rowCal;
    input [(DATA_SIZE* COLUMN_SIZE) -1:0] datsA;
    input [(DATA_SIZE* ROW_SIZE) -1:0] datsB;
    integer i;
    for(i=0; i < COLUMN_SIZE; i =i+1)//(DATA_SIZE * ROW_SIZE) -1 is matrix row size
    begin
        datsOut[i*DATA_SIZE+:DATA_SIZE] = VectorCal(datsA[i*DATA_SIZE+:DATA_SIZE],datsB[i*DATA_SIZE+:DATA_SIZE]);
    end
    endfunction

    function[DATA_SIZE -1:0] VectorCal;
    input [DATA_SIZE -1:0] datsA;
    input [DATA_SIZE -1:0] datsB;
    VectorCal = DRShift_DATA_SIZE(multiplication_DATA_SIZE(datsA, datsB));
    endfunction
  
    function[(DATA_SIZE *2) -1:0] multiplication_DATA_SIZE;
    input[DATA_SIZE -1:0] A;
    input[DATA_SIZE -1:0] B;
    multiplication_DATA_SIZE= A * B;
    endfunction
    
    function[DATA_SIZE -1:0] DRShift_DATA_SIZE;
    input[(DATA_SIZE *2) -1:0] A;
    DRShift_DATA_SIZE= A[(DATA_SIZE *2) -1:DATA_SIZE];
    endfunction
    
endmodule