EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_ST_STM32F1:STM32F103C8Tx U?
U 1 1 60D30FA6
P 3300 3800
F 0 "U?" V 3300 3150 50  0000 C CNN
F 1 "STM32F103C8Tx" V 3150 3150 50  0000 C CNN
F 2 "Package_QFP:LQFP-48_7x7mm_P0.5mm" H 2700 2400 50  0001 R CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00161566.pdf" H 3300 3800 50  0001 C CNN
	1    3300 3800
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 60D34BA4
P 3250 2150
F 0 "#PWR?" H 3250 2000 50  0001 C CNN
F 1 "+3V3" H 3265 2323 50  0000 C CNN
F 2 "" H 3250 2150 50  0001 C CNN
F 3 "" H 3250 2150 50  0001 C CNN
	1    3250 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 2150 3250 2200
Wire Wire Line
	3250 2200 3200 2200
Wire Wire Line
	3200 2200 3200 2300
Wire Wire Line
	3250 2200 3300 2200
Wire Wire Line
	3300 2200 3300 2300
Connection ~ 3250 2200
Wire Wire Line
	3300 2200 3400 2200
Wire Wire Line
	3400 2200 3400 2300
Connection ~ 3300 2200
Wire Wire Line
	3400 2200 3500 2200
Wire Wire Line
	3500 2200 3500 2300
Connection ~ 3400 2200
$Comp
L power:GND #PWR?
U 1 1 60D35FC5
P 3150 5450
F 0 "#PWR?" H 3150 5200 50  0001 C CNN
F 1 "GND" H 3155 5277 50  0000 C CNN
F 2 "" H 3150 5450 50  0001 C CNN
F 3 "" H 3150 5450 50  0001 C CNN
	1    3150 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 5450 3150 5400
Wire Wire Line
	3150 5400 3100 5400
Wire Wire Line
	3100 5400 3100 5300
Wire Wire Line
	3150 5400 3200 5400
Wire Wire Line
	3200 5400 3200 5300
Connection ~ 3150 5400
Wire Wire Line
	3200 5400 3300 5400
Wire Wire Line
	3300 5400 3300 5300
Connection ~ 3200 5400
$Comp
L RF:NRF24L01_Breakout U?
U 1 1 60D37956
P 5000 1100
F 0 "U?" V 5517 1100 50  0000 C CNN
F 1 "NRF24L01_Breakout" V 5426 1100 50  0000 C CNN
F 2 "RF_Module:nRF24L01_Breakout" H 5150 1700 50  0001 L CIN
F 3 "http://www.nordicsemi.com/eng/content/download/2730/34105/file/nRF24L01_Product_Specification_v2_0.pdf" H 5000 1000 50  0001 C CNN
	1    5000 1100
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 60D38475
P 4300 1000
F 0 "#PWR?" H 4300 850 50  0001 C CNN
F 1 "+3V3" H 4315 1173 50  0000 C CNN
F 2 "" H 4300 1000 50  0001 C CNN
F 3 "" H 4300 1000 50  0001 C CNN
	1    4300 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 1100 4300 1100
Wire Wire Line
	4300 1100 4300 1000
$Comp
L power:GND #PWR?
U 1 1 60D38D9C
P 5700 1200
F 0 "#PWR?" H 5700 950 50  0001 C CNN
F 1 "GND" H 5705 1027 50  0000 C CNN
F 2 "" H 5700 1200 50  0001 C CNN
F 3 "" H 5700 1200 50  0001 C CNN
	1    5700 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 1200 5700 1100
Wire Wire Line
	5700 1100 5600 1100
Text Label 4700 1600 3    50   ~ 0
NRF_MOSI
Text Label 4800 1600 3    50   ~ 0
NRF_MISO
Text Label 4900 1600 3    50   ~ 0
NRF_SCK
Text Label 5000 1600 3    50   ~ 0
NRF_SEL_1
Text Label 5300 1600 3    50   ~ 0
NRF_IRQ_1
Text Label 5200 1600 3    50   ~ 0
NRF_EN_1
$Comp
L power:VCC #PWR?
U 1 1 60D3B75C
P 6750 2600
F 0 "#PWR?" H 6750 2450 50  0001 C CNN
F 1 "VCC" H 6765 2773 50  0000 C CNN
F 2 "" H 6750 2600 50  0001 C CNN
F 3 "" H 6750 2600 50  0001 C CNN
	1    6750 2600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60D3BE6D
P 6600 2600
F 0 "#PWR?" H 6600 2350 50  0001 C CNN
F 1 "GND" H 6605 2427 50  0000 C CNN
F 2 "" H 6600 2600 50  0001 C CNN
F 3 "" H 6600 2600 50  0001 C CNN
	1    6600 2600
	-1   0    0    1   
$EndComp
Text Label 6600 2900 3    50   ~ 0
SER_IN
Text Label 6750 2900 0    50   ~ 0
SER_OUT
Text Label 6750 3000 0    50   ~ 0
CON
$EndSCHEMATC
