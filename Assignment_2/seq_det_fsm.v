//MEALY SEQUENCE DETECTOR FSM FOR THE SEQUENCE '00011'
module Seq_Det_FSM
    // I/O
    (
    input wire clk, reset, seq_next,
    output wire seq_det
    );
    
    // LOCAL PARAMETERS FOR EACH STATE IN THE FSM
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b100,
               D = 3'b011,
               E = 3'b010;
    
    // STATE REG DECLARATIONS
    reg [2:0] state_curr, state_next;
    reg temp;
    // STATE REGISTER
    always @(posedge clk, posedge reset)
        if (reset)
                state_curr <= A; // IF RESET IS HIGH, RETURN TO RESET STATE A
        else
            state_curr <= state_next; // OTHERWISE MOVE TO NEXT STATE USING STATE LOGIC BELOW
            
    // NEXT STATE AND OUTPUT LOGIC
    always@*
        begin
            state_next = state_curr; // BY DEFAULT, NEXT STATE = CURRENT STATE
            temp = 1'b0; // UNLESS SEQUENCE IS FOUND, OUTPUT IS LOW
            
            case(state_curr)
                // STATE A, RESET STATE
                A:
                begin
                    if(seq_next == 0) // IF NEXT BIT IS 0
                        state_next <= B; // MOVE TO STATE B
                    else // ELSE NEXT BIT IS 1
                        state_next <= A; // STAY AT STATE A 
                end
                // STATE B
                B:
                begin
                    if(seq_next == 0) // IF NEXT BIT IS 0
                        state_next <= C; // MOVE TO STATE C
                    else //ELSE NEXT BIT IS 1
                        state_next <= A; // BACK TO STATE A
                end
                // STATE C
                C:
                begin
                    if (seq_next == 0) // IF NEXT BIT IS 0
                        state_next <= D;    // MOVE TO STATE D
                    else // ELSE NEXT BIT IS 1
                        state_next <=A; // BACK TO STATE A
                end
                // STATE D
                D:
                begin
                    if (seq_next == 1) // IF NEXT BIT IS 1
                        state_next <= E; // MOVE TO STATE E
                    else // ELSE NEXT BIT IS 0
                        state_next <= D; // STAY AT STATE D
                end
                // STATE E
                E:
                begin
                    if(seq_next == 1) // IF NEXT BIT IS 1
                        begin 
                        state_next <= A; // RESET TO STATE A
                        temp = 1'b1; // OUTPUT IS HIGH
                        end
                    else // ELSE NEXT BIT IS 0
                        state_next <= B; // BACK TO STATE A
                end
                // DEFAULT CASE STATE
                default:
                    state_next = A; // DEFAULT IS RESET STATE
            endcase
        end
        
        assign seq_det = temp;
endmodule