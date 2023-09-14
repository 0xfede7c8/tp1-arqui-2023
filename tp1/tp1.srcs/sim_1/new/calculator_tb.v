`timescale 1ns / 1ps

`include "defs.vh"

module calculator_tb;

    //INPUTS
    reg signed    [`DATA_MSB:0]    entrada;
    reg boton_a, boton_b, boton_op, boton_calc;
    wire [`DATA_MSB:0] leds;
    reg clk;

    localparam period = 20;


    calculator calc (
        .entrada (entrada), 
        .boton_a (boton_a), 
        .boton_b (boton_b),
        .boton_op (boton_op),
        .boton_calc (boton_calc),
        .leds (leds),
        .clk (clk)
    );
     
    always #(period) clk = ~clk;

    initial begin
        clk = 0;
        boton_op = 0;
        boton_a = 0;
        boton_b = 0;


        #(period)
        entrada = 8'b00000001;
        #(period)
        boton_a = 1;
        #(period)
        boton_a = 0;
        #(period)
        boton_b = 1;
        #(period)
        boton_b = 0;
        #(period);
        entrada = `ADD;
        #(period)
        boton_op = 1;
        #(period)
        boton_op = 0;
        #(period)
        boton_calc = 1;
        #(period)
        boton_calc = 0;
        #(period)
        entrada = 8'b00000002;
        #(period)
        $finish;
        
    end
       
endmodule