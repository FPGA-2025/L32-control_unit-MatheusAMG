module Control_Unit (
    input wire clk,
    input wire rst_n,
    input wire [6:0] instruction_opcode,
    output reg pc_write,
    output reg ir_write,
    output reg pc_source,
    output reg reg_write,
    output reg memory_read,
    output reg is_immediate,
    output reg memory_write,
    output reg pc_write_cond,
    output reg lorD,
    output reg memory_to_reg,
    output reg [1:0] aluop,
    output reg [1:0] alu_src_a,
    output reg [1:0] alu_src_b
);

// machine states
localparam FETCH              = 4'b0000;
localparam DECODE             = 4'b0001;
localparam MEMADR             = 4'b0010;
localparam MEMREAD            = 4'b0011;
localparam MEMWB              = 4'b0100;
localparam MEMWRITE           = 4'b0101;
localparam EXECUTER           = 4'b0110;
localparam ALUWB              = 4'b0111;
localparam EXECUTEI           = 4'b1000;
localparam JAL                = 4'b1001;
localparam BRANCH             = 4'b1010;
localparam JALR               = 4'b1011;
localparam AUIPC              = 4'b1100;
localparam LUI                = 4'b1101;
localparam JALR_PC            = 4'b1110;

// Instruction Opcodes
localparam LW      = 7'b0000011;
localparam SW      = 7'b0100011;
localparam RTYPE   = 7'b0110011;
localparam ITYPE   = 7'b0010011;
localparam JALI    = 7'b1101111;
localparam BRANCHI = 7'b1100011;
localparam JALRI   = 7'b1100111;
localparam AUIPCI  = 7'b0010111;
localparam LUII    = 7'b0110111;

// insira aqui o seu código
reg [3:0] actual_state;
reg [3:0] next_state;

//Lógica da saida
always @(actual_state)begin
    case (actual_state)
        FETCH: begin
            pc_write      = 1'b1;
            ir_write      = 1'b1;
            pc_source     = 1'b0;
            reg_write     = 1'b0; //
            memory_read   = 1'b1; 
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0;
            memory_to_reg = 1'b0; //
            aluop         = 2'b00;
            alu_src_a     = 2'b00;
            alu_src_b     = 2'b01;
        end
        DECODE: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; // 
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            aluop         = 2'b00;
            memory_to_reg = 1'b0; //
            alu_src_a     = 2'b10;
            alu_src_b     = 2'b10;
        end
        MEMADR: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            memory_to_reg = 1'b0; //
            aluop         = 2'b00;
            alu_src_a     = 2'b01;
            alu_src_b     = 2'b10;
        end
        MEMREAD: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; //
            memory_read   = 1'b1;
            is_immediate  = 1'b0; // 
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b1;
            memory_to_reg = 1'b0; //
            aluop         = 2'b00; //
            alu_src_a     = 2'b00; //
            alu_src_b     = 2'b00; //
        end
        MEMWB: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b1;
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            memory_to_reg = 1'b1; 
            aluop         = 2'b00; //
            alu_src_a     = 2'b00; //
            alu_src_b     = 2'b00; //
        end
        MEMWRITE: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b1; 
            pc_write_cond = 1'b0; //
            lorD          = 1'b1;
            memory_to_reg = 1'b0; //
            aluop         = 2'b00; //
            alu_src_a     = 2'b00; //
            alu_src_b     = 2'b00; //
        end
        EXECUTER: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            memory_to_reg = 1'b0; //
            aluop         = 2'b10;
            alu_src_a     = 2'b01;
            alu_src_b     = 2'b00;
        end
        ALUWB: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b1;
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            memory_to_reg = 1'b0; 
            aluop         = 2'b00; //
            alu_src_a     = 2'b00; //
            alu_src_b     = 2'b00; //
        end
        EXECUTEI: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b1;
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            aluop         = 2'b10; 
            alu_src_a     = 2'b01; 
            alu_src_b     = 2'b10; 
        end
        JAL: begin
            pc_write      = 1'b1;
            ir_write      = 1'b0; //
            pc_source     = 1'b1;
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            aluop         = 2'b00;
            alu_src_a     = 2'b10;
            alu_src_b     = 2'b01;
        end
        BRANCH: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b1; 
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b1;
            lorD          = 1'b0; //
            aluop         = 2'b01;
            alu_src_a     = 2'b01;
            alu_src_b     = 2'b00;
        end
        JALR: begin
            pc_write      = 1'b1;
            ir_write      = 1'b0; //
            pc_source     = 1'b1;
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b1; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            aluop         = 2'b00;
            alu_src_a     = 2'b10;
            alu_src_b     = 2'b01;
        end
        AUIPC: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            aluop         = 2'b00;
            alu_src_a     = 2'b10; // Está diferente Tb e Diagrama
            alu_src_b     = 2'b10;
        end
        LUI: begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            aluop         = 2'b00;
            alu_src_a     = 2'b11;
            alu_src_b     = 2'b10;
        end
        JALR_PC : begin
            pc_write      = 1'b0; //
            ir_write      = 1'b0; //
            pc_source     = 1'b0; //
            reg_write     = 1'b0; //
            memory_read   = 1'b0; //
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0; //
            aluop         = 2'b00;
            alu_src_a     = 2'b01;
            alu_src_b     = 2'b10;
        end
        default : begin
            pc_write      = 1'b1;
            ir_write      = 1'b1;
            pc_source     = 1'b0;
            reg_write     = 1'b0; //
            memory_read   = 1'b1; 
            is_immediate  = 1'b0; //
            memory_write  = 1'b0; //
            pc_write_cond = 1'b0; //
            lorD          = 1'b0;
            memory_to_reg = 1'b0; //
            aluop         = 2'b00;
            alu_src_a     = 2'b00;
            alu_src_b     = 2'b01;
        end
    endcase
    
end

//Lógica de próximo estado
always @(actual_state, instruction_opcode)begin
    case (actual_state)
        FETCH: begin
            next_state <= DECODE;
        end
        DECODE: begin
            if (instruction_opcode == BRANCHI) begin
                next_state <= BRANCH;
            end
            else if ((instruction_opcode == LW) || instruction_opcode == SW) begin
                next_state <= MEMADR;
            end
            else if (instruction_opcode == AUIPCI) begin
                next_state <= AUIPC;  
            end
            else if (instruction_opcode == JALI) begin
                next_state <= JAL;  
            end
            else if (instruction_opcode == ITYPE) begin
                next_state <= EXECUTEI;  
            end
            else if (instruction_opcode == RTYPE) begin
                next_state <= EXECUTER;  
            end
            else if (instruction_opcode == LUII) begin
                next_state <= LUI;  
            end
            else if (instruction_opcode == JALRI) begin
                next_state <= JALR_PC;  
            end
        end
        MEMADR: begin
            if (instruction_opcode == LW) begin
                next_state <= MEMREAD;
            end
            else if (instruction_opcode == SW) begin
                next_state <= MEMWRITE;
            end
        end
        MEMREAD: begin
            next_state <= MEMWB;
        end
        MEMWB: begin
            next_state <= FETCH;
        end
        MEMWRITE: begin
            next_state <= FETCH;
        end
        EXECUTER: begin
            next_state <= ALUWB;
        end
        ALUWB   : begin
            next_state <= FETCH;
        end
        EXECUTEI: begin
            next_state <= ALUWB;
        end
        JAL     : begin
            next_state <= ALUWB;
        end
        BRANCH  : begin
            next_state <= FETCH;
        end
        JALR    : begin
            next_state <= ALUWB;
        end
        AUIPC   : begin
            next_state <= ALUWB;
        end
        LUI     : begin
            next_state <= ALUWB;  
        end
        JALR_PC : begin
            next_state <= JALR; 
        end
        default : begin
            next_state <= FETCH; 
        end
    endcase
end

//Lógica de transição de estados
always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        actual_state <= FETCH; 
    end
    else begin
       actual_state <= next_state; 
    end
end

endmodule
