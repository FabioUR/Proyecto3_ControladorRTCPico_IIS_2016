%read the image
I = imread('timer.png');	
imshow(I);
		
%Extrae los terminos RGB de la imagen 
R = I(:,:,1); %Se divide la matriz		
G = I(:,:,2); %
B = I(:,:,3); %

%Pasa de termino a numero para poder ser manipulado 
R = double(R);	
G = double(G);
B = double(B);

%al ser un numero, se divide el valor original en 2, esto con el finde
%pasar de 8 a 4 bits 
R = R.^(4/8); % 8 bits -> 4 bits
G = G.^(4/8); % 8 bits -> 4 bits
B = B.^(4/8); % 8 bits -> 4 bits
%En la ecuacion, se tiene que la potencia que es fraccion es:  
%(Numero de bits deseado)/(Numero de bit existentes)

%traduce el termino flotante a un termino de 8 bits
R = uint16(R); % float -> uint8
G = uint16(G); %Funcion uinit16, lo que hace es pasar a un numero de 4 bits el numero que se tenga 
B = uint16(B);

%En algunos casos el redondeo en los pasos anteriores, hace que los bits 
%se salgan del rango deseado (4bits), por lo que se le resta uno al valor obtenido 
R = R-1; 
G = G-1;
B = B-1; 

%Se crea un conjunto de bits de 12 bits 
G = bitshift(G,4);  % 4 << G (shift by 4 bits)
R = bitshift(R,8);  % 8 << R (shift by 8 bits) hola
COLOR = R+G+B;      

%En el codigo se escribe de la siguiente mandera 
%  R     G     B
%(0000)(0000)(0000)

%Se guarda un nuevo arcgivo en con COLOR en formato hexadecimal 
fileID = fopen ('timer.list', 'w');
for i = 1:size(COLOR(:), 1)-1
    fprintf (fileID,'%x\n',COLOR(i)); % COLOR (dec) -> print to file (hex)
end
fprintf (fileID, '%x', COLOR(size(COLOR(:), 1))); % COLOR (dec) -> print to file (hex)

%save variable COLOR to a file in HEX format for the chip to read
%fileID = fopen ('Mickey.list', 'w');
%fprintf (fileID, '%x\n', COLOR); % COLOR (dec) -> print to file (hex)
fclose (fileID);

%translate to hex to see how many lines
COLOR_HEX = dec2hex(COLOR);