`timescale 1ns / 1ps

`include "defs.vh"

module alu_tb;
  parameter SZ_DATA = `SZ_DATA;
  parameter N_OPS = 8;

  //INPUTS
  reg signed    [`DATA_MSB:0]    a;
  reg signed    [`DATA_MSB:0]    b;
  reg           [`OP_MSB:0]      op;

    //OUTPUTS
  wire  signed [`DATA_MSB:0]    res;
  reg [`OP_MSB:0] OPS[0:N_OPS-1];
  
 
   // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
  localparam period = 20;


  ALU #(SZ_DATA) alu_test (
    .a (a), 
    .b (b), 
    .op (op), 
    .out (res)
  );
     
  initial begin
      OPS[0] = `ADD;
      OPS[1] = `SUB;
      OPS[2] = `OR;
      OPS[3] = `AND;
      OPS[4] = `NOR;
      OPS[5] = `XOR;
      OPS[6] = `SRL;
      OPS[7] = `SRA;
          
      a = 8'b0;
      b = 8'b0;
      op = 6'b0;
      #10
      
      for(integer i = 0; i < N_OPS; i = i+1) begin

          a = $urandom;
          b = $urandom;
            
          #(period*2);
          
          if( i > 5) b = 4; //Si toca un shift, que sean fijos 4 lugares

          #(period*2);

          op = OPS[i]; 
          
          #(period*2);
          
          case(i)
              0: if((a + b) != res) $display("Suma - a: %d - b: %d - obtenido: %d - esperado: %d", a, b, out, a + b);
              1: if((a - b) != res) $display("Resta - a: %d - b: %d - obtenido: %d - esperado: %d", a, b, out, a - b);
              2: if((a | b) != res) $display("OR - a: %b - b: %b - obtenido: %b - esperado: %b", a, b, out, a | b);
              3: if((a & b) != res) $display("AND - a: %b - b: %b - obtenido: %b - esperado: %b", a, b, out, a & b);
              4: if(~(a | b) != res) $display("NOR - a: %b - b: %b - obtenido: %b - esperado: %b", a, b, out, ~(a | b));
              5: if((a ^ b) != res) $display("XOR - a: %b - b: %b - obtenido: %b - esperado: %b", a, b, out, a ^ b);
              6: if((a >> b) != res) $display("SRL - a: %b - b: %b - obtenido: %b - esperado: %b", a, b, out, a >> b);
              7: if((a >>> b) != res) $display("SRA - a: %b - b: %b - obtenido: %b - esperado: %b", a, b, out, a >>> b);
          endcase
          
      end
      
      #(period);

      $finish;
      
     end
       
endmodule