library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG is
  GENERIC (N: integer );
  Port (en,rst: in std_logic; 
        A: in std_logic_vector(N-1 downto 0);
        Y: out std_logic_vector(N-1 downto 0) );
end REG;

architecture STRUCT of REG is

-- instanciate component fd
	component FD	
	Port (CK:	In	std_logic;
		RESET:	In	std_logic;
		D:	In	std_logic;
		Q:	Out	std_logic);
	end component;

begin
--simply generate N instances of FD, one for each bit of the input.	
gen: for i in 0 to N-1 generate 
         regs: FD port map (CK=>en,RESET=>rst,D=>A(i),Q=>Y(i));  
     end generate; 

end STRUCT;
-- define which configuration of FD to use. The choice defines 2 different configurations for the reg.


configuration CFG_REG_SYNC of REG is
	for STRUCT
	    for gen
		   for all : FD
			use configuration WORK.CFG_FD_PIPPO;
		end for;
    end for;
	end for;
end CFG_REG_SYNC;

-- configuration CFG_REG_ASYNC of REG is
-- 	for STRUCT
-- 	for gen
-- 		for all : FD
-- 			use configuration WORK.CFG_FD_PLUTO;
-- 		end for;
--     end for; 
-- 	end for;
-- end CFG_REG_ASYNC;
