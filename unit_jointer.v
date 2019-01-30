/******************************
made 2019/1/24 powered harumaki
module name: unit_jointer
this is matrix unit joint. 
    So select input datas.(matrix unit output or buffer)
*******************************/

module unit_jointer (selector, in_buffer, in_matrix, datsOut);
    parameter DATA_SIZE = 'd16;//input bit width
    parameter COLUMN_SIZE = 'd64;
    input selector;
    input[(DATA_SIZE * COLUMN_SIZE) - 1:0] in_buffer;
    input[(DATA_SIZE * COLUMN_SIZE) - 1:0] in_matrix;
    output[(DATA_SIZE * COLUMN_SIZE) - 1:0] datsOut;
    
    assign datsOut = selector ? in_buffer : in_matrix;
    //selector 1: input for buffer
    //selector 0: input for matrix
endmodule