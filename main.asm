[org 0x7C00]

mov ah, 0x02
mov al, 2
mov bx, 0x7E00
mov ch, 0
mov dh, 0
mov cl, 2

int 0x13

mov ax, 0x4F00
mov di, VbeSignature
int 0x10

mov dx, 0

set_mode:
    mov ax, 0x4F01
    mov cx, [VideoModePtr]
    add cx, dx
    mov di, ModeAttributes
    int 0x10

    mov ax, 0x4F02
    mov bx, [VideoModePtr]
    add bx, dx
    int 0x10

    mov ah, 0x0E
    mov al, 'T'
    int 0x10
    mov al, 'E'
    int 0x10
    mov al, 'S'
    int 0x10
    mov al, 'T'
    int 0x10

check_for_keyboard:
    mov ah, 0x00
    int 0x16
    cmp al, 0
    jg increase
    jmp check_for_keyboard

increase:
    inc dx
    jmp set_mode

jmp $

times 510-$+$$ db 0
dw 1010101001010101b
times 3 dq 0

; Mandatory information for all VBE revisions
ModeAttributes dw 0 ; mode attributes
WinAAttributes db 0 ; window A attributes
WinBAttributes db 0 ; window B attributes
WinGranularity dw 0 ; window granularity
WinSize dw 0 ; window size
WinASegment dw 0 ; window A start segment
WinBSegment dw 0 ; window B start segment
WinFuncPtr dd 0 ; real mode pointer to window function
BytesPerScanLine dw 0 ; bytes per scan line
; Mandatory information for VBE 1.2 and above
XResolution dw 0 ; horizontal resolution in pixels or characters3
YResolution dw 0 ; vertical resolution in pixels or characters
XCharSize db 0 ; character cell width in pixels
YCharSize db 0 ; character cell height in pixels
NumberOfPlanes db 0 ; number of memory planes
BitsPerPixel db 0 ; bits per pixel
NumberOfBanks db 0 ; number of banks
MemoryModel db 0 ; memory model type
BankSize db 0 ; bank size in KB
NumberOfImagePages db 0 ; number of images
db 1 ; reserved for page function
; Direct Color fields (required for direct/6 and YUV/7 memory models)
RedMaskSize db 0 ; size of direct color red mask in bits
RedFieldPosition db 0 ; bit position of lsb of red mask
GreenMaskSize db 0 ; size of direct color green mask in bits
GreenFieldPosition db 0 ; bit position of lsb of green mask
BlueMaskSize db 0 ; size of direct color blue mask in bits
BlueFieldPosition db 0 ; bit position of lsb of blue mask
RsvdMaskSize db 0 ; size of direct color reserved mask in bits
RsvdFieldPosition db 0 ; bit position of lsb of reserved mask
DirectColorModeInfo db 0 ; direct color mode attributes
; Mandatory information for VBE 2.0 and above
PhysBasePtr dd 0 ; physical address for flat memory frame buffer
dd 0 ; Reserved - always set to 0
dw 0 ; Reserved - always set to 0
; Mandatory information for VBE 3.0 and above
LinBytesPerScanLine dw 0 ; bytes per scan line for linear modes
BnkNumberOfImagePages db 0 ; number of images for banked modes
LinNumberOfImagePages db 0 ; number of images for linear modes
LinRedMaskSize db 0 ; size of direct color red mask (linear modes)
LinRedFieldPosition db 0 ; bit position of lsb of red mask (linear modes)
LinGreenMaskSize db 0 ; size of direct color green mask (linear modes)
LinGreenFieldPosition db 0 ; bit position of lsb of green mask (linear modes)
LinBlueMaskSize db 0 ; size of direct color blue mask (linear modes)
LinBlueFieldPosition db 0 ; bit position of lsb of blue mask (linear modes)
LinRsvdMaskSize db 0 ; size of direct color reserved mask (linear modes)
LinRsvdFieldPosition db 0 ; bit position of lsb of reserved mask (linear modes)
MaxPixelClock dd 0 ; maximum pixel clock (in Hz) for graphics mode
times 190 db 0

VbeSignature times 4 db 0 ; VBE Signature
VbeVersion dw 0 ; VBE Version
OemStringPtr dd 0 ; VbeFarPtr to OEM String
Capabilities times 4 db 0 ; Capabilities of graphics controller
VideoModePtr dd 0 ; VbeFarPtr to VideoModeList
TotalMemory dw 0 ; Number of 64kb memory blocks
; Added for VBE 2.0+
OemSoftwareRev dw 0 ; VBE implementation Software revision
OemVendorNamePtr dd 0 ; VbeFarPtr to Vendor Name String
OemProductNamePtr dd 0 ; VbeFarPtr to Product Name String
OemProductRevPtr dd 0 ; VbeFarPtr to Product Revision String
times 478 db 0 ; Reserved for VBE implementation scratch