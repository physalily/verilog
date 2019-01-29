/******************************
made 2019/1/16 powered harumaki
comment:
    nothing
function list:
module
+rowSum[22] 
+sumShift[16] 
+rowCal[1024]
    +VectorCal[16] 
        +multiplication_16[32] 
        +DRShift_16[32]
*******************************/

module matrix_mdl(clock, reset, enable, datsA, datsB, datsOut);
    input clock;
    input reset;
    input enable;
    input[1023:0] datsA;
    input[65535:0] datsB;
    output[1024:0]datsOut;
    reg[1024:0] datsOut;
    integer i = 0;
    
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
            for(i=0; i <64; i =i+1)//64 is matrix columm size
            begin
                datsOut[i*16+:16] <= sumShift(rowSum(rowCal(datsA, datsB[i*1024+:1024])));
            end
        end
    end
    end

    function[21:0] rowSum;//16bit x64 overflow size added
    input[1023:0] dataset;
    integer i;
    for(i = 0; i <64; i = i+1)
        rowSum = rowSum + dataset[i*16+:16];      
    endfunction
    
    function[15:0] sumShift;
    input[21:0] A;
    if(~(| A[21:16]))
        sumShift = A;
    else
        sumShift = 16'hFFFF;
    endfunction

    function[1023:0] rowCal;
    input [1023:0] datsA;
    input [1023:0] datsB;
    integer i;
    for(i=0; i < 64; i =i+1)//64 is matrix row size
    begin
        datsOut[i*16+:16] = VectorCal(datsA[i*16+:16],datsB[i*16+:16]);
    end
    endfunction

    function[15:0] VectorCal;
    input [15:0] datsA;
    input [15:0] datsB;
    VectorCal = DRShift_16(multiplication_16(datsA, datsB));
    endfunction
  
    function[31:0] multiplication_16;
    input[15:0] A;
    input[15:0] B;
    multiplication_16 = A * B;
    endfunction
    
    function[15:0] DRShift_16;
    input[31:0] A;
    DRShift_16 = A[31:16];
    endfunction
    
endmodule