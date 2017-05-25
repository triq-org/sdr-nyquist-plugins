;nyquist plug-in
;version 3
;type process
;categories "http://lv2plug.in/ns/lv2core/#MixerPlugin"
;name "Demod I/Q to FM"
;info "by Christian Zuckschwerdt (http://triq.net). Released under GPL v2."
;action "Mixing..."
;preview "enabled"
;author "Christian Zuckschwerdt"
;copyright "Released under terms of the GNU General Public License version 2"

;; demod-iq-fm.ny by Christian Zuckschwerdt, May 2017
;; almost, but not quite, entirely unlike a proper FM demodulation
;; Released under terms of the GNU General Public License version 2
;; http://www.gnu.org/copyleft/gpl.html

; x=i,q  ->  x^=i,-q
; y[n] = x[n] * x^[n-1]
; x*y^ = (xi*yi - xq*-yq), (xq*yi + xi*-yq)
(if (arrayp s) ; check for stereo track
  (let* ((i (aref s 0))
         (q (aref s 1))
         (out (make-array (truncate len)))
         (i-1 0) (q-1 1))
    (dotimes (k (truncate len))
      (let* ((i0 (snd-fetch i)) (q0 (snd-fetch q)))
             (setf (aref out k)
                   (sum (- (* i-1 i0) (* q-1 q0))
                        (+ (* i-1 q0) (* q-1 i0))))
                   (psetq i-1 i0 q-1 (* -1 q0))))
             (setf (aref out 0) 0)
    (snd-from-array 0 *sound-srate* out))
; or error if not stereo
	(format NIL "Error\
Demod I/Q to FM can only be used on stereo tracks."))
