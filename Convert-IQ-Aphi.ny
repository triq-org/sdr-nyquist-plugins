;nyquist plug-in
;version 3
;type process
;categories "http://lv2plug.in/ns/lv2core/#MixerPlugin"
;name "Convert I/Q to A/phi"
;info "by Christian Zuckschwerdt (http://triq.net). Released under GPL v2."
;action "Converting..."
;preview "enabled"
;author "Christian Zuckschwerdt"
;copyright "Released under terms of the GNU General Public License version 2"

;; convert-iq-aphi.ny by Christian Zuckschwerdt, April 2017
;; Released under terms of the GNU General Public License version 2
;; http://www.gnu.org/copyleft/gpl.html

; mix and output as vector
(if (arrayp s) ; check for stereo track
	(vector
; a = (i * i + q * q) / 2
		(sum
			(mult 0.5 (aref s 0)(aref s 0))
			(mult 0.5 (aref s 1)(aref s 1)))
; phi = atan2(q, i)
		(mult (aref s 1)(aref s 0)))
; or error if not stereo
	(format NIL "Error\nConvert I/Q to A/phi can only be used on stereo tracks."))
