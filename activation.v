/******************************
made 2019/1/30 powered harumaki
module name: activation
this is activation function

only ReLU (plans)
*******************************/

module activation(indats, outdats);
    parameter DATA_SIZE = 'h16;
    parameter ROW_SIZE = 'h32;
    input [(DATA_SIZE * ROW_SIZE) -1:0] indats;
    output[(DATA_SIZE * ROW_SIZE) -1:0] outdats;

    assign outdats = ReLU(indats);

    function [(DATA_SIZE * ROW_SIZE) -1:0] ReLU;
    input indats;
        ReLU = indats;
    endfunction

endmodule