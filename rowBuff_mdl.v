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
    parameter COLUMN_SIZE ='d16;
    parameter ROW_SIZE = 'd16;
    input clock;
    input reset;
    input enable;
    input dendFlag;
    input[(DATA_SIZE * ROW_SIZE)-1:0] dats;
    output dsetFlag;
    output[(DATA_SIZE * COLUMN_SIZE * ROW_SIZE)-1:0] datsOut;
    reg dsetFlag = 0;
    reg[(DATA_SIZE * COLUMN_SIZE * ROW_SIZE)-1:0] datsOut = 0;
    reg[(COLUMN_SIZE * ROW_SIZE)-1:0] datsBuff[DATA_SIZE -1:0];
    reg [$clog2(COLUMN_SIZE):0]count = 'b0;
    integer i = 0;
    
    always@(posedge clock or negedge reset)
    begin
    if(~reset)
    begin
        datsOut     = 'h0;
        count       = 'h0;
        for(i = 0; i < (COLUMN_SIZE * ROW_SIZE);i = i +1 )
            datsBuff[i] = 'h0;
    end
    else
    begin
        if(enable)
        begin
            if(dendFlag == 1'b1)
            begin
                count       = 4'D0;
                dsetFlag    = 1'b1;
                for(i = 0; i < (COLUMN_SIZE * ROW_SIZE); i = i +1 )
                begin
                    datsOut[i*DATA_SIZE+:DATA_SIZE] = datsBuff[i];
                    datsBuff[i] = 'h0;
                end
            end
            else
            begin
                for(i = 0; i <ROW_SIZE; i = i+1)
                    datsBuff[count*ROW_SIZE] = dats;
                    
                if(count == COLUMN_SIZE * ROW_SIZE)
                begin
                    count       = 'd0;
                    dsetFlag    = 1'b1;
                    for(i = 0; i < (COLUMN_SIZE * ROW_SIZE); i = i +1 )
                        datsOut[i*DATA_SIZE+:DATA_SIZE] = datsBuff[i];
                end
                else
                begin
                    count = count + 'd1;
                    dsetFlag = 1'b0;
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
