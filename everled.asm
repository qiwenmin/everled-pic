    processor pic12lf1501

    ; CONFIG1
    config FOSC = INTOSC    ; Oscillator Selection Bits (INTOSC oscillator: I/O function on CLKIN pin)
    config WDTE = SWDTEN    ; Watchdog Timer Enable (WDT controlled by the SWDTEN bit in the WDTCON register)
    config PWRTE = OFF      ; Power-up Timer Enable (PWRT disabled)
    config MCLRE = ON       ; MCLR Pin Function Select (MCLR/VPP pin function is MCLR)
    config CP = OFF         ; Flash Program Memory Code Protection (Program memory code protection is disabled)
    config BOREN = OFF      ; Brown-out Reset Enable (Brown-out Reset disabled)
    config CLKOUTEN = OFF   ; Clock Out Enable (CLKOUT function is disabled. I/O or oscillator function on the CLKOUT pin)

    ; CONFIG2
    config WRT = OFF        ; Flash Memory Self-Write Protection (Write protection off)
    config STVREN = ON      ; Stack Overflow/Underflow Reset Enable (Stack Overflow or Underflow will cause a Reset)
    config BORV = LO        ; Brown-out Reset Voltage Selection (Brown-out Reset Voltage (Vbor), low trip point selected.)
    config LPBOR = OFF      ; Low-Power Brown Out Reset (Low-Power BOR is disabled)
    config LVP = ON         ; Low-Voltage Programming Enable (Low-voltage programming enabled)

    include p12lf1501.inc

    org 0x0000
reset_vector
    goto start

    org 0x0004
interrupt_vector
    retfie

start
    ; init
    movlb 1

    ; OSCCONbits.IRCF = 0b1100; // 2MHz
    ; OSCCONbits.SCS = 0b10; // Internal OSC Block
    movlw b'01100010'
    movwf OSCCON

    ; WDTCONbits.WDTPS = 0b00011; // 1:256 8ms
    movlw b'00000110'
    movwf WDTCON

    ; WDTCONbits.SWDTEN = 1; // Enable software watchdog
    bsf WDTCON, 0

    ; TRISA = 0; // RA is output
    clrf TRISA

    ; ANSELA = 0; // RA is digital
    movlb 3
    clrf ANSELA

    ; init finished
    movlb 0

    ; PORTA = 0; // RA is low
    clrf PORTA
loop
    ; toggle RA5 for 2us
    bsf PORTA, 5
    bcf PORTA, 5
    sleep
    goto loop

    end
