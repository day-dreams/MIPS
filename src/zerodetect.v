/*
    BY: zhangnan,20170705
*/

//0еп╤о
module zerodetect #(parameter WIDTH=32)(
    input [WIDTH-1:0]   a,
    output              y);
    
    assign y = (a==0);
    
endmodule
