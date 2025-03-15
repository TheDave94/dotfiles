CapsLock::Return

; Capslock + W = Pfeiltaste Hoch
CapsLock & w::
{
    Send "{Up}"
}

; Capslock + S = Pfeiltaste Runter
CapsLock & s::
{
    Send "{Down}"
}

; Capslock + A = Pfeiltaste Links
CapsLock & a::
{
    Send "{Left}"
}

; Capslock + D = Pfeiltaste Rechts
CapsLock & d::
{
    Send "{Right}"
}

; Capslock + Y = <
; Capslock + Shift + Y = >
CapsLock & y::
{
  If GetKeyState("Shift", "P")
	  Send ">"
  Else
	  Send "<"
  Return
}

; Capslock + 1 bis 0 = Numblock 1 bis 0
CapsLock & 1::
{
    Send "{Numpad1}"
}

CapsLock & 2::
{
    Send "{Numpad2}"
}

CapsLock & 3::
{
    Send "{Numpad3}"
}

CapsLock & 4::
{
    Send "{Numpad4}"
}

CapsLock & 5::
{
    Send "{Numpad5}"
}

CapsLock & 6::
{
    Send "{Numpad6}"
}

CapsLock & 7::
{
    Send "{Numpad7}"
}

CapsLock & 8::
{
    Send "{Numpad8}"
}

CapsLock & 9::
{
    Send "{Numpad9}"
}

CapsLock & 0::
{
    Send "{Numpad0}"
}
