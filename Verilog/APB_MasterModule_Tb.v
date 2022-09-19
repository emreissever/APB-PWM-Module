`timescale 1ns / 1ps

module APB_MasterModule_Tb();

reg clk = 1;
reg rstN = 1; 

reg [31:0]      apb_addr;
reg             apb_write;
reg             apb_sel;
reg             apb_en;
reg [31:0]      apb_wdata;


wire            apb_ready;
wire            pwm_out;


APB_PWM APB_PWM_Test
(
    .PCLK(clk),
    .PRESETn(rstN),

    .PADDR(apb_addr),
    .PWRITE(apb_write),
    .PSEL(apb_sel),
    .PENABLE(apb_en),
    .PWDATA(apb_wdata),

    .PREADY(apb_ready),

    .PWM_OUT(pwm_out)
);

// 10 ns Clock Signal
always begin 
clk = !clk; 
#5;
end

initial begin

    // Initial values
    clk = 1;
    rstN = 1;
    apb_sel   = 0;
    apb_en    = 0;
    apb_addr  = 0;
    apb_wdata  = 0;
    apb_write = 0;

    // First Write
    @(posedge clk);
    apb_sel   = 1;
    apb_write = 1;
    apb_addr  = 1;
    apb_wdata  = 120;
    @(posedge clk);
    apb_en = 1;
    @(posedge clk); 
    if(apb_ready) begin
        apb_en    = 0;
        apb_addr  = 2;
        apb_wdata  = 5;
    end
    else begin
        $display("Timeout"); 
    end

    // Second Write
    @(posedge clk);
    apb_en = 1;
    @(posedge clk); 
    if(apb_ready) begin
        apb_en    = 0;
        apb_sel   = 1;
        apb_addr  = 0;
        apb_wdata  = 1;
    end

    @(posedge clk);
    apb_en = 1;
    @(posedge clk); 
    if(apb_ready) begin
        apb_en    = 0;
        apb_sel   = 0;
        apb_addr  = 0;
        apb_wdata  = 0;
        $display("Success");
    end
    else begin
        $display("Failed TimeOut");
    end

    @(posedge clk);
    apb_en    = 0;
    apb_sel   = 0;

    $finish;
end
endmodule
