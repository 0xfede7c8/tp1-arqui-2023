`include "defs.vh"

module calculator(
    input wire[`DATA_MSB:0] entrada,
    input wire boton_a,
    input wire boton_b,
    input wire boton_op,
    input wire boton_calc,
    input wire clk,
    output reg [`DATA_MSB:0]leds
    );


    reg calculado;
    reg [`DATA_MSB:0]entrada_d;

    reg [`DATA_MSB:0] a, b;
    reg [`OP_MSB:0] op;
    wire [`DATA_MSB:0] res;

    ALU #(`SZ_DATA) alu(
        .a(a),
        .b(b),
        .op(op),
        .out(res));

    always @(posedge clk) begin
        entrada_d <= entrada;

        if (boton_calc) begin
            calculado <= 1;
        end

        if (calculado) begin
            leds <= res;
        end
        else begin
            leds <= entrada;
        end

        if (entrada_d ^ entrada) begin 
            calculado <= 0;
        end

        if(boton_a) begin
            a = entrada;
        end
        else if(boton_b) begin
            b = entrada;
        end
        else if(boton_op) begin
            op = entrada[`OP_MSB:0];
        end
    end

endmodule
