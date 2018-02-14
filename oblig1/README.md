# opsys

Oblig 1 Operativsystemer IMT 2282

Fredrik Røstad
frer@stud.ntnu.no
131212

Gruppe: 
Fredrik Røstad
Morten Bjerke


Kompilert i Fedora OS.

Alle 3 filene kjørt i gcc -Wall med 0 feilmeldinger.

(Knoter fortsatt litt med den neste, da nettsiden med manualen er nede)
Clonet inn cppcheck til maskin og lastet ned gcc-cpp, kjørte filene gjennom cppcheck.
Kommandolinje:
sudo apt-get install gcc-cpp |
git clone https://github.com/danmar/cppcheck.git  |
make |
cppcheck --enable=all ./filnavn.c
