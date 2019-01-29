/******************************
made 2019/1/17 powered harumaki
module name: rowBuff_mdl
this is matrix_mdl data buffer.

parameter:
    DATA_SIZE
    COLUMN_SIZE
    ROW_SIZE
function list


*******************************/

module rowBuff_mdl(clock, reset, enable, dendFlag, dats, dsetFlag, datsOut);
    parameter DATA_SIZE ='d16;
    parameter COLUMN_SIZE ='d64;
    parameter ROW_SIZE = 'd64;
    //parameter 
    input clock;
    input reset;
    input enable;
    input dendFlag;
    input[(DATA_SIZE * ROW_SIZE)-1:0] dats;
    output dsetFlag;
    output[(DATA_SIZE * COLUMN_SIZE * ROW_SIZE)-1:0] datsOut;
    reg dsetFlag = 0;
    reg[(DATA_SIZE * COLUMN_SIZE * ROW_SIZE)-1:0] datsOut = 0;
    reg[(DATA_SIZE * COLUMN_SIZE * ROW_SIZE)-1:0] datsBuff = 0;
    reg[3:0] count = 4'd0;
    
    always@(posedge clock or negedge reset)
    begin
    if(~reset)
    begin
        datsOut     = 'h0;
        datsBuff    = 'h0;
        count       = 'h0;
    end
    else
    begin
        if(enable)
        begin
            if(dendFlag == 1'b1)
            begin
                count       = 4'D0;
                datsOut     = datsBuff;
                dsetFlag    = 1'b1;
            end
            else
            begin
                datsBuff[(DATA_SIZE * ROW_SIZE)-1:0] = dats;
                
                if(count == 4'd8)
                begin
                    count       = 4'd8;
                    datsOut     = datsBuff;
                    datsOut     = 'h0;
                    dsetFlag    = 1'b1;
                end
                else
                begin
                    count       = count + 4'd1;
                    datsBuff    = datsBuff<<DATA_SIZE;
                    dsetFlag    = 1'b0;
                end
            end
        end
    end
    end
    
endmodule