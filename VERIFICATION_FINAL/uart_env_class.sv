


class uart_env_class;
uart_gen_class g_env_hdl;
uart_bfm_class b_env_hdl;
uart_mon_class m_env_hdl;
uart_sbd_class s_env_hdl;


function new();
g_env_hdl=new();
b_env_hdl=new();
m_env_hdl=new();
s_env_hdl=new();
endfunction

	task env_run();
	$display(">>>***Inside the UART Environment Class***<<<<");
      fork
	  g_env_hdl.gen_run();
          b_env_hdl.bfm_run();
          m_env_hdl.mon_run();
          s_env_hdl.sbd_run();
         
	  join
	endtask


endclass

