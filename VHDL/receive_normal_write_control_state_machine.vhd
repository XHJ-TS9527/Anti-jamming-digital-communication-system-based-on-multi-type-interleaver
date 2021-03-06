library ieee;
use ieee.std_logic_1164.all;
entity receive_normal_write_control_state_machine is
	port(WCLK:in std_logic;
		 RST:in std_logic;
		 BUFF_LAST_FLAG:in std_logic;
		 BUFF_SEND_FLAG:in std_logic;
		 BUFF_MODE:in std_logic_vector(2 downto 0);
		 write_work:out std_logic;
		 write_chip:out std_logic;
		 out_RST:out std_logic;
		 out_pause:out std_logic;
		 last_write_mode:out std_logic_vector(2 downto 0));
end receive_normal_write_control_state_machine;
architecture behav of receive_normal_write_control_state_machine is
component rising_CNT204 is
	port(CLK:in std_logic;
		 RST:in std_logic;
		 ENA:in std_logic;
		 CNT:out std_logic_vector(7 downto 0));
end component;
component rising_D_trigger is
	port(CLK:in std_logic;
		 RST:in std_logic;
		 D:in std_logic;
		 ENA:in std_logic;
		 Q:out std_logic;
		 Qbar:out std_logic);
end component;
signal w_work,w_local_work,write_chip_select,reset_flag,pause_flag,out_reset,local_CLK,temp_D,start_flag,allow_flag:std_logic;
signal last_w_mode,now_w_mode:std_logic_vector(2 downto 0);
signal local_CNT:std_logic_vector(7 downto 0);
type state is(init,
			  bloc0,bloc1,  --0:ram 0,1:ram 1
			  rand0,rand1,
			  spin0,spin1,
			  odev0,odev1,
			  refl0,refl1,
			  itdg0,itdg1,
			  circ0,circ1,
			  conv0,conv1);
signal pr_st,nx_st:state;
begin
	write_work<=w_work;
	w_work<=w_local_work and not(pause_flag);
	write_chip<=write_chip_select;
	out_RST<=out_reset;
	out_reset<=RST and not(reset_flag);
	out_pause<=pause_flag;
	last_write_mode<=last_w_mode;
	temp_D<=BUFF_LAST_FLAG and BUFF_SEND_FLAG;
	local_counter:rising_CNT204 port map(CLK=>WCLK,RST=>out_reset,ENA=>w_work,CNT=>local_CNT);
	D_trigger:rising_D_trigger port map(CLK=>WCLK,RST=>out_reset,D=>temp_D,ENA=>'1',Q=>start_flag);
	--state machine
	local_CLK<=WCLK when (pause_flag='0') else 'Z';
	process(out_reset,local_CLK)
	begin
		if (out_reset='0') then pr_st<=init;
		elsif falling_edge(local_CLK) then pr_st<=nx_st;
		end if;
	end process;
	process(pr_st,out_reset,start_flag,local_CNT,BUFF_MODE)
	begin
		if (out_reset='0') then nx_st<=init;
		else
			case pr_st is
				when init=>
					if (start_flag='1') then
						case BUFF_MODE is
							when "000"=>nx_st<=conv0;
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when others=>null;
						end case;
					else nx_st<=init;
					end if;
				when bloc0=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc1;
							when "010"=>nx_st<=rand1;
							when "011"=>nx_st<=spin1;
							when "100"=>nx_st<=odev1;
							when "101"=>nx_st<=refl1;
							when "110"=>nx_st<=itdg1;
							when "111"=>nx_st<=circ1;
							when "000"=>nx_st<=conv1;
							when others=>null;
						end case;
					else nx_st<=bloc0;
					end if;
				when bloc1=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when "000"=>nx_st<=conv0;
							when others=>null;
						end case;
					else nx_st<=bloc1;
					end if;
				when rand0=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc1;
							when "010"=>nx_st<=rand1;
							when "011"=>nx_st<=spin1;
							when "100"=>nx_st<=odev1;
							when "101"=>nx_st<=refl1;
							when "110"=>nx_st<=itdg1;
							when "111"=>nx_st<=circ1;
							when "000"=>nx_st<=conv1;
							when others=>null;
						end case;
					else nx_st<=rand0;
					end if;
				when rand1=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when "000"=>nx_st<=conv0;
							when others=>null;
						end case;
					else nx_st<=rand1;
					end if;
				when spin0=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc1;
							when "010"=>nx_st<=rand1;
							when "011"=>nx_st<=spin1;
							when "100"=>nx_st<=odev1;
							when "101"=>nx_st<=refl1;
							when "110"=>nx_st<=itdg1;
							when "111"=>nx_st<=circ1;
							when "000"=>nx_st<=conv1;
							when others=>null;
						end case;
					else nx_st<=spin0;
					end if;
				when spin1=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when "000"=>nx_st<=conv0;
							when others=>null;
						end case;
					else nx_st<=spin1;
					end if;
				when odev0=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc1;
							when "010"=>nx_st<=rand1;
							when "011"=>nx_st<=spin1;
							when "100"=>nx_st<=odev1;
							when "101"=>nx_st<=refl1;
							when "110"=>nx_st<=itdg1;
							when "111"=>nx_st<=circ1;
							when "000"=>nx_st<=conv1;
							when others=>null;
						end case;
					else nx_st<=odev0;
					end if;
				when odev1=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when "000"=>nx_st<=conv0;
							when others=>null;
						end case;
					else nx_st<=odev1;
					end if;
				when refl0=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc1;
							when "010"=>nx_st<=rand1;
							when "011"=>nx_st<=spin1;
							when "100"=>nx_st<=odev1;
							when "101"=>nx_st<=refl1;
							when "110"=>nx_st<=itdg1;
							when "111"=>nx_st<=circ1;
							when "000"=>nx_st<=conv1;
							when others=>null;
						end case;
					else nx_st<=refl0;
					end if;
				when refl1=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when "000"=>nx_st<=conv0;
							when others=>null;
						end case;
					else nx_st<=refl1;
					end if;
				when itdg0=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc1;
							when "010"=>nx_st<=rand1;
							when "011"=>nx_st<=spin1;
							when "100"=>nx_st<=odev1;
							when "101"=>nx_st<=refl1;
							when "110"=>nx_st<=itdg1;
							when "111"=>nx_st<=circ1;
							when "000"=>nx_st<=conv1;
							when others=>null;
						end case;
					else nx_st<=itdg0;
					end if;
				when itdg1=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when "000"=>nx_st<=conv0;
							when others=>null;
						end case;
					else nx_st<=itdg1;
					end if;
				when circ0=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc1;
							when "010"=>nx_st<=rand1;
							when "011"=>nx_st<=spin1;
							when "100"=>nx_st<=odev1;
							when "101"=>nx_st<=refl1;
							when "110"=>nx_st<=itdg1;
							when "111"=>nx_st<=circ1;
							when "000"=>nx_st<=conv1;
							when others=>null;
						end case;
					else nx_st<=circ0;
					end if;
				when circ1=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when "000"=>nx_st<=conv0;
							when others=>null;
						end case;
					else nx_st<=circ1;
					end if;
				when conv0=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc1;
							when "010"=>nx_st<=rand1;
							when "011"=>nx_st<=spin1;
							when "100"=>nx_st<=odev1;
							when "101"=>nx_st<=refl1;
							when "110"=>nx_st<=itdg1;
							when "111"=>nx_st<=circ1;
							when "000"=>nx_st<=conv1;
							when others=>null;
						end case;
					else nx_st<=conv0;
					end if;
				when conv1=>
					if (local_CNT="00000000") then
						case BUFF_MODE is
							when "001"=>nx_st<=bloc0;
							when "010"=>nx_st<=rand0;
							when "011"=>nx_st<=spin0;
							when "100"=>nx_st<=odev0;
							when "101"=>nx_st<=refl0;
							when "110"=>nx_st<=itdg0;
							when "111"=>nx_st<=circ0;
							when "000"=>nx_st<=conv0;
							when others=>null;
						end case;
					else nx_st<=conv1;
					end if;
			end case;
		end if;
	end process;
	--output logic
	w_local_work<='0' when (pr_st=init) else '1';
	reset_flag<='0' when (pr_st=init) else
				'1' when ((BUFF_SEND_FLAG='0') and (BUFF_LAST_FLAG='1')) else '0';
	pause_flag<='1' when ((BUFF_SEND_FLAG='0') and (BUFF_LAST_FLAG='0')) else '0';
	with pr_st select
		now_w_mode<="001" when bloc0,
					"001" when bloc1,
					"010" when rand0,
					"010" when rand1,
					"011" when spin0,
					"011" when spin1,
					"100" when odev0,
					"100" when odev1,
					"101" when refl0,
					"101" when refl1,
					"110" when itdg0,
					"110" when itdg1,
					"111" when circ0,
					"111" when circ1,
					"000" when others;
	allow_flag<='1' when (local_CNT="11001001") else '0';
	process(out_reset,allow_flag)
	begin
		if (out_reset='0') then last_w_mode<="000";
		elsif rising_edge(allow_flag) then last_w_mode<=now_w_mode;
		end if;
	end process;
	with pr_st select
		write_chip_select<='1' when bloc1,
						   '1' when rand1,
						   '1' when spin1,
						   '1' when odev1,
						   '1' when refl1,
						   '1' when itdg1,
						   '1' when circ1,
						   '1' when conv1,
						   '0' when others;
end behav;