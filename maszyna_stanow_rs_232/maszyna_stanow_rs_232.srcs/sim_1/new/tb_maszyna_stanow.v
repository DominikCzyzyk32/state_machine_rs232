`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2022 13:15:10
// Design Name: 
// Module Name: tb_maszyna_stanow
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


module tb_maszyna_stanow(
    );
    reg clk = 1'b0;
    reg rst = 1'b0;
    wire send;
    wire [7:0] data;
    wire out;
    
    load_file l_f(
        .data(data),
        .send(send)
    );
    
    initial
    begin
        while(1)
        begin
            #1; 
            clk = clk + 1;
        end
        
    end
    
    maszyna_stanow m_s(
        .clk(clk),
        .rst(rst),
        .send(send),
        .data(data),
        .txd(out)
    );
    
    save_file s_f(
        .c(out)
    );
    
    
endmodule


module load_file(
    output [7:0] data,
    output send
    );

    integer file;
    reg [7:0] d;
    reg s = 1'b0;
    
    initial
    begin
        file=$fopen("C:/Users/domin/maszyna_stanow_rs_232/maszyna_stanow_rs_232.srcs/sim_1/new/test_file.txt","rb");
        d <= $fgetc(file);
        while(1)
        begin
            s <= 1'b1; #2;
            s <= 1'b0; #22;
            d <= $fgetc(file);
        end

        $fclose(file);
    end

    assign send = s; 
    assign data = d;   
endmodule


module save_file
    (
        input c
    );
    integer file;
    reg [7:0] i = 0;
        
    initial
    begin
        file=$fopen("C:/Users/domin/maszyna_stanow_rs_232/maszyna_stanow_rs_232.srcs/sim_1/new/bin_file.txt", "wb");
        while(i < 16*12)
        begin
            #2;
            $fwrite(file,"%b",c);
            i=i+1;
        end
        $fclose(file);
    end
endmodule