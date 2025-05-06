// Топ-модуль верификационного окружения
// скреблера(шифратора на (linear feedback shift register, LFSR)).

//  ------------------ TODO -------------------
// | В данном задании все изменения необходимо |
// | вносить в этот файл                       |
//  ------------------ TODO -------------------

module tb_scr_1dim_core ();

    parameter DATA_WIDTH    = 1;
    parameter SCR_WIDTH     = 7;


    // Определение тактового сигнала и
    // сигнала сброса.
    logic clk;
    logic kill;

    // Определение проводов, которые будут
    // подключены к портам модуля.
             logic                          scr_en;
             logic  [DATA_WIDTH-1:0]        data_in;
             logic                          data_in_en;
             logic  [SCR_WIDTH-1:0]         init_val;
             logic                          init_val_en;
             logic  [DATA_WIDTH-1:0]        data_out;
             logic                          data_out_en;
    // Подключение тестируемого модуля.
    scr_1dim_core #(
        .DATA_WIDTH      (DATA_WIDTH ),
        .SCR_WIDTH     (SCR_WIDTH)
    ) DUT (
        .clk                ( clk        ),
        .kill               ( kill       ),
        .scr_en             ( scr_en     ),
        .data_in            ( data_in    ),
        .data_in_en         ( data_in_en ),
        .init_val_en        ( init_val_en),
        .init_val           ( init_val),
        .data_out           ( data_out   ),
        .data_out_en        ( data_out_en )
    );

    initial begin
        // Настройка waveform
        // Необходимо для создание временных диаграмм 
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_scr_1dim_core); 
    end

    // Генерация тактового сигнала.
    initial begin
        clk <= 1'b0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        // Инициализация регистра ненулевым значением + проверка записи
        init_val <= '1;
        init_val_en = 1;
        data_in_en = 1;
        data_in = 0;
        scr_en = 0;
        kill = 1'b0; 
        @(posedge clk);

        // Проверка сигнала сброса.
        kill <= 1'b1;
        @(posedge clk);
        kill = 1'b0; 

        // Проверка работы сдвигового регистра
        init_val <= (SCR_WIDTH)'(1);
        @(posedge clk);
        init_val_en = 0;
        for (int i = 0; i<SCR_WIDTH+1; i++)
            @(posedge clk);
        
        //Проверка работы выхода
        init_val_en = 1;
        init_val <= '0; // Таким образом XOR = 0
        data_in = '0;
        @(posedge clk); 
        data_in = '1;
        @(posedge clk);
        init_val <= (1 << SCR_WIDTH-1); // Таким образом XOR = 1
        data_in = '0;
        @(posedge clk);
        data_in = '1;
        @(posedge clk);

        scr_en = 1;
        init_val <= '0; // Таким образом XOR = 0
        @(posedge clk); 
        data_in = '0;
        @(posedge clk); 
        data_in = '1;
        @(posedge clk);
        init_val <= (1 << SCR_WIDTH-1); // Таким образом XOR = 1
        @(posedge clk); 
        data_in = '0;
        @(posedge clk);
        data_in = '1;
        @(posedge clk);
        #3; // Чтобы увидеть график
        $stop;
    end

endmodule