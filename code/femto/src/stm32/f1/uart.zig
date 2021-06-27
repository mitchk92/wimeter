const mem_map = @import("memmap.zig");
const gpio = @import("GPIO.zig");
const rcc = @import("RCC.zig");

const usart_reg = {
    sr:u32,
    dr:u32,
    brr:u32,
    cr1:u32,
    cr2:u32,
    cr3:u32,
    gtpr:u32,
};
