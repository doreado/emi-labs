# TODO
## Assignment 1
### Part 1 - Default Timeout Policy
- [ ] Compile the DPM simulator
Test it with the two workloads, using the default timeout policy
- [ ] Only transitions between RUN and IDLE states
- [ ] Try different timeout values and see what happens. Discuss in your report
  why it happens!
### Part 2 - Extension of the timeout policy
- [ ] Modify the timeout policy to enable transitions also to SLEEP. Must
modify the implementation of the DPM simulator (slide 29)
- [ ] Comparison between RUN-> IDLE timeout policy and RUN->SLEEP timeout
policy (slide 35)
- [ ] Extra: Make your analysis automatic and systematic
  - Don’t just try some "random" TTO values
  - Compare things in a reasonable and meaningful way

### Part 3 - Predictive Policy
- [ ] Modify the simulator to implement a predictive policy. It can be of any
kind, you decide. Trying and comparing more than one policy is also good. Of
course, motivate your choices.
 - Report assignment
 - [ ] Description of implemented predictive policy. Result of implemented predictive
 policy with the workload profiles. Analysis on effect of policy parameters (if
 any)
 - [ ] Comparison between predictive policy and timeout policies.
 - [ ] EXTRAS: change the psm, change the workload, other policies.

