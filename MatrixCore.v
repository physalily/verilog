/******************************
made 2019/1/25 powered harumaki
module name: MatrixCore
    this is matrix core system

module MatrixCore
+rowBuff_mdl
+matrix_mdl
+unit_jointer
*******************************/

module MatrixCore(clock, reset, enable, columnEnable, selector, dendFlag, in_row, in_buffer, in_matrix, datsOut);
    parameter DATA_SIZE = 'd16;
    parameter COLUMN_SIZE = 'd16;
    parameter ROW_SIZE = 'd16;
    input clock;
    input reset;
    input enable;
    input columnEnable;
    input selector;
    input dendFlag;
    input[1023:0] in_row;
    input[1023:0] in_buffer;
    input[1023:0] in_matrix;
    output[1023:0] datsOut;
    wire bufferEnable;
    wire[1023:0] toMatrix, fromMatrix;
    wire[65535:0] RBtoMM;
    
    rowBuff_mdl 
    #(DATA_SIZE, COLUMN_SIZE, ROW_SIZE)
    RB(
    .clock(clock),
    .reset(reset),
    .enable(enable),
    .dendFlag(dendFlag),
    .dats(in_row),
    .dsetFlag(bufferEnable),
    .datsOut(RBtoMM)
    );
    
    matrix_mdl      
    #(DATA_SIZE, COLUMN_SIZE, ROW_SIZE)
    MM(
    .clock(clock),
    .reset(reset),
    .enable(columnEnable),
    .datsA(toMatrix),
    .datsB(RBtoMM),
    .datsOut(fromMatrix)
    );
    
    unit_jointer    
    #(DATA_SIZE, COLUMN_SIZE)
    UJ(
    .selector(selector),
    .in_buffer(in_buffer),
    .in_matrix(in_matrix),
    .datsOut(toMatrix)
    );
endmodule