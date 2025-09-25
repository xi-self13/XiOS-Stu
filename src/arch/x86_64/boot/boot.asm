; I am gonna do this with AI help. But i'll code for myself. The comments are my way of understanding this

bits 64     ; this helps define what bit we is working with. We is using 64 bit.

; Define a section, for instance, the multiboot_header
section .multiboot_header 
header_start:
    ; apparently Multiboot's "special number"
    dd 0xe85250d6
    ; The architecture, well 0 for i386
    dd 0
    dd header_end - header_start
    dd -(0xe85250d6 + 0 + (header_end - header_start))

    ; So this is required (End Tag)
    dd 0 ; types
    dd 0 ; flags
    dd 8 ; size
header_end:

section .text 
global start ; I am pretty sure this makes boot.asm visible (well, 'start') for linker to find - XI
extern kmain
start: 
    mov rsp, stack_top ; stack pointer needs to be registered to the top of memory area.
    call kmain ; gets kmain.c i am pretty sure.
    .hang:
        cli ; disable interrupt
        hlt ; stops CPU
        jmp .hang ; loops forever.

section .bss
resb 16384 ; Reserve 16KB
stack_bottom:
stack_top:

