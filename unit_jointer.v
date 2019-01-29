/******************************
made 2019/1/24 powered harumaki
module name: unit_jointer
this is matrix unit joint. 
    So select input datas.(matrix unit output or buffer)
*******************************/

module unit_jointer (selector, in_buffer, in_matrix, datsOut);
    input selector;
    input[1023:0] in_buffer;
    input[1023:0] in_matrix;
    output[1023:0] datsOut;
    
    assign datsOut = selector ? in_buffer : in_matrix;
    //selector 1: input for buffer
    //selector 0: input for matrix
endmodule