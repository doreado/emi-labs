#include "bus.h"

void bus::set_attributes() {}

void bus::initialize() {}

void bus::processing()
{
    // Compute total current consumption
    double tot_consumed = i_mcu.read() + i_rf.read()
                          + i_air_quality_sensor.read()
                          + i_methane_sensor.read()
                          + i_temperature_sensor.read()
                          + i_mic_click_sensor.read()
                          ;
#ifdef P1
    double tot_scavenged = real_i_pv.read();
#endif
#ifdef P2
    double tot_scavenged = real_i_pv_1.read() + real_i_pv_2.read();
#endif
#ifdef P3
    double tot_scavenged = real_i_pv_1.read() + real_i_pv_2.read() + real_i_pv_3.read();
#endif
    double tot_requested = tot_consumed - tot_scavenged;

    i_tot.write(tot_requested); // tot_requested >= 0 ? pow_from_battery : pow_to_battery
}
