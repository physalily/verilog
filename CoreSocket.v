/******************************
made 2019/1/25 powered harumaki
module name: CoreSocket
this is prcessing unit
module list
CoreSocket
+MatrixCore x4  //core elements
+inst_decoder   
*******************************/

module CoreSocket();
    parameter DATA_SIZE = 'd16;
    parameter COLUMN_SIZE = 'd16;
    parameter ROW_SIZE = 'd16;
    parameter Cores = 'd100;
    
    generate 
    genvar i;
        for(i = 0; i < Cores; i = i +1)
        begin
            :Core
            MatrixCore
            #(DATA_SIZE, COLUMN_SIZE, ROW_SIZE)
            matrix(
            
            );
        end
    endgenerate
    
    inst_decoder
    #()
    Dec(
    
    );
    
endmodule