#include <stdio.h>

#include "inc/utilities.h"
#include "inc/psm.h"

int parse_args(int argc, char *argv[], char *fwl, psm_t *psm, dpm_policy_t
        *selected_policy, dpm_timeout_params *tparams, dpm_history_params
        *hparams)
{
    int timeout = 0;
    int cur = 1;
    while(cur < argc) {

        if(strcmp(argv[cur], "-help") == 0) {
            print_command_line();
            return 0;
        }

        // set policy to timeout and get timeout value
        if(strcmp(argv[cur], "-t") == 0) {
            *selected_policy = DPM_TIMEOUT;
            if(argc > cur + 1) {
                tparams->timeout = atof(argv[++cur]);
                // Assume that low power state is IDLE
                tparams->low_power_state = PSM_STATE_IDLE;

                timeout = 1;
            }
            else return	0;
        }

        // set policy to timeout and get timeout value
        if(strcmp(argv[cur], "-lp") == 0) {
            if (!timeout) {
                dprintf(2 , "[error] Timeout low power state works can be set only after setting timeout\n");
                dprintf(2, "hint: use -lp flag after -t\n");
                return 0;
            }

            if(argc > cur + 1) {
                tparams->low_power_state = !strcmp(argv[++cur], "sleep") ? PSM_STATE_SLEEP : PSM_STATE_IDLE;
            }
            else return	0;
        }

        // set policy to history based and get parameters and thresholds
        if(strcmp(argv[cur], "-h") == 0) {
            *selected_policy = DPM_HISTORY;
            if(argc > cur + DPM_HIST_WIND_SIZE + 2){
                int i;
                for(i = 0; i < DPM_HIST_WIND_SIZE; i++) {
                    hparams->alpha[i] = atof(argv[++cur]);
                }
                hparams->threshold[0] = atof(argv[++cur]);
                hparams->threshold[1] = atof(argv[++cur]);
            } else return 0;
        }

        // set name of file for the power state machine
        if(strcmp(argv[cur], "-psm") == 0) {
            if(argc <= cur + 1 || !psm_read(psm, argv[++cur]))
                return 0;
        }

        // set name of file for the workload
        if(strcmp(argv[cur], "-wl") == 0)
        {
            if(argc > cur + 1)
            {
                strcpy(fwl, argv[++cur]);
            }
            else return	0;
        }
        cur ++;
    }
    return 1;
}

void print_command_line(){
	printf("\n******************************************************************************\n");
	printf(" DPM simulator: \n");
	printf("\t-t <timeout>: timeout of the timeout policy\n");
	printf("\t-lp <low_power_state>: set the low_power_state. If low_power_state is not sleep assume idle\n");
	printf("\t-h <Value1> …<Value5> <Threshold1> <Threshold2>: history-based policy \n");
	printf("\t   <Value1-5> value of coefficients\n");
	printf("\t   <Threshold1-2> predicted time thresholds\n");
	printf("\t-psm <psm filename>: the power state machine file\n");
	printf("\t-wl <wl filename>: the workload file\n");
	printf("******************************************************************************\n\n");
}
