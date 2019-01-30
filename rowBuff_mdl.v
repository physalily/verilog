/******************************
made 2019/1/17 powered harumaki
module name: rowBuff_mdl
this is matrix_mdl data buffer.
comment:
    Synthesis need very very long time. In my laptop, about 8h.(use default parameter)
parameter:
    DATA_SIZE
    COLUMN_SIZE
    ROW_SIZE
function list
module rowBuff_dml
+log2 
*******************************/

module rowBuff_mdl(clock, reset, enable, dendFlag, dats, dsetFlag, datsOut);
    parameter DATA_SIZE ='d16;
    parameter COLUMN_SIZE ='d64;
    parameter ROW_SIZE = 'd64; 
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
    reg [log2(COLUMN_SIZE):0]count = 'b0;
    
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
                
                if(count == COLUMN_SIZE)
                begin
                    count       = 'd8;
                    datsOut     = datsBuff;
                    datsOut     = 'h0;
                    dsetFlag    = 1'b1;
                end
                else
                begin
                    count       = count + 'd1;
                    datsBuff    = datsBuff<<DATA_SIZE;
                    dsetFlag    = 1'b0;
                end
            end
        end
    end
    end
    // Beyond Circuts, ref:Constant Function in Verilog 2001
    // http://www.beyond-circuits.com/wordpress/2008/11/constant-functions/
    function integer log2;
    input integer addr;
    begin
        addr = addr - 1;
        for (log2=0; addr>0; log2=log2+1)
            addr = addr >> 1;
    end
    endfunction
endmodule