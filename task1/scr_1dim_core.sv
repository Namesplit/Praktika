/*************************************************************************************
 *                                                                                   *
 *       Description:                                                                *
 *                                                                                   *
 *                    1-dimensional Scrambler                                       *
 *************************************************************************************/
 (* keep_hierarchy = "yes" *)
    module scr_1dim_core
     #(
             parameter DATA_WIDTH    = 1,
             parameter SCR_WIDTH     = 7
     )
         (
             input                           clk,
             input                           kill,
             input                           scr_en,
             input   [DATA_WIDTH-1:0]        data_in,
             input                           data_in_en,
             input   [SCR_WIDTH-1:0]         init_val,
             input                           init_val_en,
             output logic [DATA_WIDTH-1:0]   data_out,
             output logic                    data_out_en
         );

/*******************************************************
 *               LOCAL REGS AND WIRES                  *
 *******************************************************/

 logic    [SCR_WIDTH-1:0]     scr_reg         = '0;
 logic    [SCR_WIDTH-1:0]     next_scr_reg;
 logic    [DATA_WIDTH-1:0]    scr_data_out;
 logic    [DATA_WIDTH-1:0]    scr_seq;
 logic                        data_in_en_reg = 0;


/*******************************************************
 *               SCRAMBLING CORE                       *
 *******************************************************/
 assign next_scr_reg[0] = scr_reg[5] ^ scr_reg[6];
 assign next_scr_reg[1] = scr_reg[0];
 assign next_scr_reg[2] = scr_reg[1];
 assign next_scr_reg[3] = scr_reg[2];
 assign next_scr_reg[4] = scr_reg[3];
 assign next_scr_reg[5] = scr_reg[4] ^ scr_reg[3];
 assign next_scr_reg[6] = scr_reg[5];

 // Scrambler register
 always @(posedge clk)
    if(kill)
        scr_reg     <= '0;
    else if(init_val_en)
        scr_reg     <= init_val;
    else if(data_in_en)
        scr_reg     <= next_scr_reg;

 assign scr_seq = (scr_en) ? next_scr_reg : '0;

 assign scr_data_out[0] = data_in[0] || scr_seq[0];

/*******************************************************
 *               SCRAMBLING DATA OUTPUT                *
 *******************************************************/
 always @(posedge clk)
    data_in_en_reg <= data_in_en;
 
 always @(posedge clk)
    if(kill)
        begin
             data_out    <= '0;
             data_out_en <= '0;
        end
    else if(data_in_en)
        begin
             data_out    <= scr_data_out;
             data_out_en <= data_in_en_reg;
        end
    else
        begin
             data_out    <= '0;
             data_out_en <= '0;
        end

endmodule
