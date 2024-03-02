#include <systemc-ams.h>

#include "config.h"

// #define P1
// #define P2
#define P3

SCA_TDF_MODULE(bus)
{
    sca_tdf::sca_in<double> i_mcu; // Requested current from MCU
    sca_tdf::sca_in<double> i_rf; // Requested current from RF module
    sca_tdf::sca_in<double> i_air_quality_sensor; // Requested current from air_quality_sensor
    sca_tdf::sca_in<double> i_methane_sensor; // Requested current from methane_sensor
    sca_tdf::sca_in<double> i_temperature_sensor; // Requested current from temperature_sensor
    sca_tdf::sca_in<double> i_mic_click_sensor; // Requested current from mic_click_sensor
#ifdef P1
    sca_tdf::sca_in<double> real_i_pv; // Provided current from pv panel after conversion
#endif
#ifdef P2
    sca_tdf::sca_in<double> real_i_pv_1,real_i_pv_2; // Provided current from pv panel after conversion
#endif
#ifdef P3
    sca_tdf::sca_in<double> real_i_pv_1, real_i_pv_2, real_i_pv_3; // Provided current from pv panel after conversion
#endif
    sca_tdf::sca_out<double> i_tot;

    SCA_CTOR(bus): i_tot("i_tot"),
                   i_mcu("i_mcu"),
                   i_rf("i_rf"),
                   i_air_quality_sensor("i_air_quality_sensor"),
                   i_methane_sensor("i_methane_sensor"),
                   i_temperature_sensor("i_temperature_sensor"),
                   i_mic_click_sensor("i_mic_click_sensor"),
#ifdef P1
                   real_i_pv("real_i_pv") {};
#endif
#ifdef P2
                   real_i_pv_1("real_i_pv_1"),
                   real_i_pv_2("real_i_pv_2") {};
#endif
#ifdef P3
                   real_i_pv_1("real_i_pv_1"),
                   real_i_pv_2("real_i_pv_2"),
                   real_i_pv_3("real_i_pv_3") {};
#endif

    void set_attributes();

    void initialize();
    void processing();
};
