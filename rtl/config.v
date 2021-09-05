//
//  Файл конфигурации проекта МС1201-02.
//

//
//  Включаемые компоненты
//  Закомментируйте ненужные модули, если хотите исключить их из схемы.
//

`define KSM_module        // текстовый контроллер КСМ
//`define KGD_module        // графический контроллер КГД
//`define IRPS2_module      // второй последовательный порт ИРПС
//`define IRPR_module       // параллельный порт ИРПР
//`define RK_module         // диск RK-11/RK05
//`define DW_module         // жесткий диск DW
//`define DX_module         // гибкий диск RX01
//`define MY_module         // гибкий диск двойной плотности MY

//  Индексы скорости последовательного порта:
//  0 - 1200
//  1 - 2400
//  2 - 4800
//  3 - 9600
//  4 - 19200
//  5 - 38400
//  6 - 57600
//  7 - 115200

// начальная скорость терминала
`define TERMINAL_SPEED 3'd5

// скорость второго последовательного интерфейса
`define UART2SPEED 3'd7


//======================================================================================================
//
//  Сдвиг фазы строчного синхроимпульса, выдаваемого модулем КСМ на VGA.
//  Если на вашем мониторе или устройстве видеозахвата картинка уезжает за левый край экрана, то раскомментируйте эту строку и
//  укажите величину горизонтального сдвига в пикселях.
//  Если картинка выглядит нормально без коррекции, оставьте строку закомметированной.
//
`define hsync_shift 11'd27


//======================================================================================================
//------------------ конец списка настраиваемых параметров -------------------------------------------------------------
//======================================================================================================

// удаление графического модуля при отсутствии текcтового терминала
`ifndef KSM_module
`undef KGD_module
`endif

// Выбор ведущего и ведомых SDSPI
`ifdef RK_module
  `define RK_sdmode 1'b1
  `define MY_sdmode 1'b0
  `define DX_sdmode 1'b0
  `define DW_sdmode 1'b0
  `define def_mosi  rk_mosi
  `define def_cs    rk_cs
  `define def_sclk  rk_sclk
  
`elsif MY_module
  `define MY_sdmode 1'b1
  `define RK_sdmode 1'b0  
  `define DX_sdmode 1'b0
  `define DW_sdmode 1'b0
  `define def_mosi  my_mosi
  `define def_cs    my_cs
  `define def_sclk  my_sclk

`elsif DX_module
  `define DX_sdmode 1'b1
  `define MY_sdmode 1'b0
  `define RK_sdmode 1'b0  
  `define DW_sdmode 1'b0
  `define def_mosi  dx_mosi
  `define def_cs    dx_cs
  `define def_sclk  dx_sclk
  
`else
  `define DW_sdmode 1'b1
  `define DX_sdmode 1'b0
  `define MY_sdmode 1'b0
  `define RK_sdmode 1'b0  
  `define def_mosi  dw_mosi
  `define def_cs    dw_cs
  `define def_sclk  dw_sclk
  
`endif  
  