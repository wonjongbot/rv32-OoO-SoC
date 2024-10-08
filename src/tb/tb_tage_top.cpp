#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "../obj_dir/Vtage_top.h"

#define MAX_SIM_TIME 100
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    Vtage_top *dut = new Vtage_top;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;

    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    while(sim_time < MAX_SIM_TIME) {

        if(sim_time >= 4 && sim_time < 7){
            dut->rst = 0;
        }

        if(sim_time >= )

        dut->clk ^= 1;
        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}