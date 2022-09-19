`timescale 1ns / 1ps

module APB_PWM
(
    // Peripheral Signals
    input           PCLK,
    input           PRESETn,

    // APB Bridge Signals
    input [31:0]    PADDR,
    input           PWRITE,
    input           PSEL,
    input           PENABLE,
    input [31:0]    PWDATA,

    // APB Slave Signals
    output reg      PREADY,

    output reg      PWM_OUT
);

// State Mechine Parameters and State declaration
localparam IDLE  = 2'b00;
localparam WRITE = 2'b01;
localparam READ  = 2'b10;

reg [1:0] State = 2'b00;


// PWM Module Registers 
// 32 Bit Data Width
// 2 Bit Depth

// RAM[0] : PWM Enable 0x1 Register 
// RAM[1] : PWM Duty Cycle (Width) Register
// RAM[2] : PWM Frequency Register
reg [31:0] RAM [0:2];
initial RAM[2] = 1;


always @(posedge PCLK, negedge PRESETn) begin
    if(~PRESETn) begin
        // Initial Values For The APB Slave
        State <= IDLE;
        PREADY <= 0;
        PWM_OUT <= 0;
    end
    else begin
        case (State)
            IDLE: begin 
                PREADY <= 0;
                if (PSEL) begin
                    if (PWRITE) begin
                        State <= WRITE;
                    end
                    else begin
                        State <= READ; 
                    end 
                end
            end 
            WRITE: begin
                if (PSEL && PENABLE && PWRITE) begin
                    RAM[PADDR] <= PWDATA;
                    PREADY <= 1'b1;
                end
                State <= IDLE;
            end 
            default: begin 
                State <= IDLE;
            end  
        endcase
    end
end

reg div_clk = 0;
reg [31:0] clk_counter = 0;

always @(posedge PCLK)
begin
    clk_counter <= clk_counter + 1;
    if (clk_counter == RAM[2]) begin
        div_clk = ~div_clk ;
        clk_counter <= 1;
    end 
end 

// Assumed Controller Clock Frequency Is 16 MHz 
// So Clock Period Is 62.5 ns 
//
// PWM Period = Counter Max Value x Clock Period 
// 15-Bit Counter Max Value = 32767
// PWM Period = 32767 x 62.5 ns = 2146238,5 ns 
// PWM Frequency = 465.931442 Hz
reg [8:0] counter = 0;

always @(posedge div_clk)
begin
    if (RAM[0]) begin
        if (RAM[1] > counter) begin
            PWM_OUT <= 1;
        end
        else begin
            PWM_OUT <= 0;
        end
        counter <= counter + 1;
    end 
end

endmodule