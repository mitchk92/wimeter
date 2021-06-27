pub const fsmc = 0xA000000;
pub const usb_otg_fs = 0x50000000;
pub const ethernet = 0x40028000;
pub const crc = 0x40023000;
pub const flash_mem = 0x40022000;
pub const rcc = 0x40021000;

pub const sdio = 0x40018000;
pub const EXTI = 0x40010400;
pub const AFIO = 0x40010000;
pub const DAC = 0x40007800;
pub const PWR = 0x40007000;
pub const BKP = 0x40006c00;
pub const bxcan1 = 0x40006400;
pub const bxcan2 = 0x40006800;
pub const usb = 0x40006000;
pub const can = 0x40006000; //shared with usb
pub const usb_fs = 0x40005c00;
pub const iwdg = 0x40003000;
pub const wwdg = 0x40002c00;
pub const rtc = 0x40002800;

pub const dma = [_]usize{
    0x40020000, //1
    0x40020400, //2
};

pub const uart = [_]usize{
    0x40013800, //1
    0x40004400, //2
    0x40004800, //3
    0x40004c00, //4
    0x40005000, //5
};

pub const spi = [_]usize{
    0x40013000, //1
    0x40003800, //2
    0x40003c00, //3
};

pub const adc = [_]usize{
    0x40012400, //1
    0x40012800, //2
    0x40013c00, //3
};
pub const i2c = [_]usize{
    0x40005400, //1
    0x40005800, //2
};

pub const timers = [_]usize{
    0x40012c00, //1
    0x40000000, //2
    0x40000400, //3
    0x40000800, //4
    0x40000C00, //5
    0x40001000, //6
    0x40001400, //7
    0x40013400, //8
    0x40014c00, //9
    0x40015000, //10
    0x40015400, //11
    0x40001800, //12
    0x40001c00, //13
    0x40002000, //14
};

pub const gpio = [_]usize{
    0x40010800, //A
    0x40010c00, //B
    0x40011000, //C
    0x40011400, //D
    0x40011800, //E
    0x40011c00, //F
    0x40012000, //G
};
