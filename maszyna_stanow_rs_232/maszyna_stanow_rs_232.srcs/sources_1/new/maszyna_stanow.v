`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2022 13:14:31
// Design Name: 
// Module Name: StateMachine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module maszyna_stanow(
    input clk,
    input rst,
    input send,
    input [7:0] data,
    output txd
    );
    
    localparam STATE0=2'd0;
    localparam STATE1=2'd1;
    localparam STATE2=2'd2;
    localparam STATE3=2'd3;
    
    reg [1:0] state = STATE0;
    reg previous_send = 1'b0;
    reg [7:0] internal_data;
    reg [2:0] counter = 3'b0;
    reg txd_temp = 1'b0;
    
    always @(posedge clk)
    begin
        if(rst) state = STATE0;
        else
        begin
            case(state)
                STATE0:
                begin
                    if(previous_send == 0 & send == 1)
                    begin
                        internal_data = data;
                        state = STATE1;
                    end
                end
                
                STATE1:
                begin
                    txd_temp = 1'b1;
                    state = STATE2;
                end
                
                STATE2:
                begin
                    txd_temp = internal_data[counter];
                    counter <= counter + 1;
                    if(counter == 7) state = STATE3;
                end
                
                STATE3:
                begin
                    txd_temp = 1'b0;
                    state = STATE0;
                end
            endcase
        end
        previous_send = send;
    end
    assign txd = txd_temp;
endmodule
