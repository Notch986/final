function a = duffing_forzado(t, x, v, c, b, d, f, w)
    a = -b * x - c * v - d * x^3 + f * cos(w * t);
end
