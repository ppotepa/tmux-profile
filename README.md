# Tmux WASD - Twój Terminal jak Gra FPS 🎮

To jest konfiguracja Tmuxa stworzona dla osób, które chcą obsługiwać terminal głównie lewą ręką (jak w grach) i mieć dostęp do potężnych funkcji jednym kliknięciem.

## 🚀 Szybki start

1. Skopiuj plik do swojego folderu domowego: `cp .tmux-wsad.conf ~/.tmux.conf`
2. **Instalacja dodatków (Ważne!):** Będąc w Tmuxie, naciśnij `Ctrl + a`, a potem dużą literę `I` (jak Install). Cierpliwie poczekaj chwilę.
3. Odświeżanie ustawień: `Ctrl + a`, potem `r`.

---

## 🕹️ Sterowanie WASD (Poruszanie się)

Używasz `Ctrl + a` (twój "Prefix"), a potem:
- **W / A / S / D**: Przechodzenie między okienkami (góra, lewo, dół, prawo).
- **Q / E**: Dzielenie ekranu (Q = pionowo, E = poziomo).
- **Shift + W / A / S / D**: Szybka zmiana rozmiaru okienka ("sprint").
- **Z**: Tryb snajperski (powiększa jedno okno na cały ekran i chowa paski).

Możesz też używać samego `Alt + WASD` bez naciskania `Ctrl + a`.

---

## 🔥 Nowe "Supermoce" (Pluginy)

Dodałem dla Ciebie kilka fajnych bajerów:

1.  **Pływająca Konsola (Pop-up):**
    - Naciśnij `Ctrl + a` i `p`. Pojawi się okienko na środku ekranu. Idealne, żeby coś szybko sprawdzić i zamknąć (ponownie `Ctrl + a` i `p`).
2.  **Łatwe Kopiowanie (Yank):**
    - W trybie kopiowania (`Ctrl + a` + `v`), zaznacz tekst i naciśnij `y`. Tekst od razu trafia do Twojego Windowsa/Maca (schowka systemowego).
3.  **Magiczne Wyciąganie Tekstu (Extrakto):**
    - Naciśnij `Ctrl + a` + `g`. Tmux pokaże Ci listę ścieżek i linków, które są na ekranie. Wybierz jeden, a on sam się wpisze!
4.  **Zapisywanie Sesji:**
    - Twoja praca nie zginie po restarcie komputera.
    - `Ctrl + a` + `Ctrl + s` (Save) – zapisz.
    - `Ctrl + a` + `Ctrl + r` (Restore) – przywróć wszystko.

---

## 🛠️ Inne przydatne klawisze
- `` ` `` (klawisz tyldy pod Esc): Pokazuje/chowa dolny pasek (HUD).
- `t`: Zmiana nazwy okna (Talk).
- `f`: Lista wszystkich sesji (Full Map).
- `F6`: Odłączenie się od sesji (wyjście do zwykłego terminala).
