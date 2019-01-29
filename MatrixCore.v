/******************************
made 2019/1/25 powered harumaki
module name: MatrixCore
    this is matrix core system

function list
*******************************/

module MatrixCore(
    input clock,
    input reset,
    input enable,
    input colummEnable,
    input selector,
    input dendFlag,
    input[1023:0] in_row,
    input[1023:0] in_buffer,
    input[1023:0] in_matrix,
    output[1023:0] datsOut
    );
    wire bufferEnable;
    wire[1023:0] toMatrix, fromMatrix;
    wire[65535:0] RBtoMM;
    
    rowBuff_mdl         RB(
    .clock(clock),
    .reset(reset),
    .enable(enable),
    .dendFlag(dendFlag),
    .dats(in_row),
    .dsetFlag(bufferEnable),
    .datsOut(RBtoMM)
    );
    matrix_mdl      MM(
    .clock(clock),
    .reset(reset),
    .enable(colummEnable),
    .datsA(toMatrix),
    .datsB(RBtoMM),
    .datsOut(fromMatrix)
    );
    unit_jointer    UJ(
    .selector(selector),
    .in_buffer(in_buffer),
    .in_matrix(in_matrix),
    .datsOut(toMatrix)
    );
endmodule