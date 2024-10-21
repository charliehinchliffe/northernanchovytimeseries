#V3.30.22.00;_safe;_compile_date:_Oct 30 2023;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: data.ss // control.ss
1  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond sd_ratio_rd < 0: platoon_sd_ratio parameter required after movement params.
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
7 #_Nblock_Patterns
 1 2 4 15 15 1 7 #_blocks_per_pattern 
# begin and end years of blocks
 1964 1964
 2017 2017 2018 2020
 2016 2016 2017 2017 2018 2018 2019 2019
 1968 1969 1970 1975 1976 1976 1977 1977 1978 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 2015 2016 2016 2017 2017 2018 2018 2019 2019 2020 2020
 1968 1969 1970 1975 1976 1976 1977 1977 1978 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 2015 2016 2016 2017 2017 2018 2018 2019 2019 2020 2020
 2020 2020
 1967 1969 1970 1975 1976 1976 1977 1977 1978 1981 1982 1983 1984 1985
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
999 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
4 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
#_Age_Fecundity by growth pattern
 0.726 0.931 0.985 0.997
0 #_First_Mature_Age
# NOTE: maturity options 4 and 5 cause fecundity_at_length to be ignored, but parameters still needed 
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.2 1.5 0.675749 0 99 0 2 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 5 12 9 0 99 0 -3 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 11 20 16.1 0 99 0 -3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.05 1 0.215 0 99 0 -3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.1 1 0.15 0 99 0 -3 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.05 1 0.15 0 99 0 -3 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -3 3 1.1e-05 0 99 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -3 5 2.988 0 99 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 -1 19 -0.24 0 99 0 -3 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -20 3 1.61 0 99 0 -3 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 0 5 1 0 99 0 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -1 5 0 0 99 0 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 0.001 0.999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             3            30       17.3582             0             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1           0.6             0             0             0         -5          0          0          0          0          0          0          0 # SR_BH_steep
             0             1             1             0             0             0         -3          0          0          0          0          0          0          0 # SR_sigmaR
           -15            15             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_regime
             0             0             0             0             0             0         -3          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1967 # first year of main recr_devs; early devs can precede this era
2021 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 -5 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 2 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1960 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1981.4 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2016.6 #_last_yr_fullbias_adj_in_MPD
 2022.3 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.6929 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1962E 1963E 1964E 1965E 1966E 1967R 1968R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021R 2022F
#  -0.192444 -0.233521 -0.395743 -1.12333 0.641229 0.42503 0.960403 1.80516 1.11887 1.43144 0.793712 -0.646203 -0.739036 0.648353 -0.720495 1.67647 1.07901 0.922716 -0.551972 0.438297 1.96306 0.296696 0.095777 1.01552 0.0708228 -1.83018 0.15043 -0.457552 -0.577847 -0.4205 -0.219026 -0.396393 -0.232099 -0.551778 -0.576847 -0.364191 -0.252842 -0.171965 -0.216528 0.00460393 0.514 -0.575283 -0.708974 -1.36019 -1.36778 -1.64078 -1.35937 -1.44476 -1.20729 -0.565649 -0.89541 -0.878166 0.905063 0.557603 0.818769 0.561316 1.14282 2.01892 -0.323175 -0.162585 0
#
#Fishing Mortality info 
0.1 # F ballpark value in units of annual_F
-2006 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
4 # max F (methods 2-4) or harvest fraction (method 1)
10  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1965 1965 1966 1966 1967 1967 1968 1968 1969 1969 1970 1970 1971 1971 1972 1972 1973 1973 1974 1974 1975 1975 1976 1976 1977 1977 1978 1978 1979 1979 1980 1980 1981 1981 1982 1982 1983 1983 1984 1984 1985 1985 1986 1986 1987 1987 1988 1988 1989 1989 1990 1990 1991 1991 1992 1992 1993 1993 1994 1994 1995 1995 1996 1996 1997 1997 1998 1998 1999 1999 2000 2000 2001 2001 2002 2002 2003 2003 2004 2004 2005 2005 2006 2006 2007 2007 2008 2008 2009 2009 2010 2010 2011 2011 2012 2012 2013 2013 2014 2014 2015 2015 2016 2016 2017 2017 2018 2018 2019 2019 2020 2020 2021 2021 2022 2022
# seas:  1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
# MexCal_S1 0.0998377 0 0.234451 0 0.172617 0 0.198398 0 0.249759 0 0.375806 0 0.109391 0 0.124506 0 0.163242 0 0.153829 0 0.310417 0 0.74355 0 2.08958 0 1.0796 0 0.676391 0 1.0148 0 1.42771 0 2.38866 0 1.42172 0 0.499816 0 0.376333 0 0.974124 0 0.675759 0 1.98341 0 0.573731 0 0.0876108 0 0.0876128 0 0.071322 0 0.050214 0 0.0564078 0 0.277954 0 0.0810681 0 0.0514625 0 0.0320085 0 0.105865 0 0.136349 0 0.0601641 0 0.0351493 0 0.0219772 0 0.0234517 0 0.0744366 0 0.0780275 0 0.0768403 0 0.156094 0 0.077746 0 0.194121 0 0.114771 0 0.123445 0 0.534174 0 0.157241 0 3.53426 0 0.134961 0 0.17543 0 0.237409 0 0.132584 0 0.0967044 0 0.0194779 0 0.476646 0
# MexCal_S2 0 0.290736 0 0.459204 0 0.0748012 0 0.0967162 0 0.179397 0 0.143138 0 0.147059 0 0.139245 0 0.103035 0 0.257933 0 0.283059 0 0.385368 0 1.76702 0 0.903976 0 0.231744 0 0.735252 0 0.764219 0 0.784547 0 0.0895186 0 0.236263 0 0.124305 0 0.199356 0 0.0377866 0 0.977728 0 0.0469497 0 0.118484 0 0.0418025 0 0.0516776 0 0.0301496 0 0.0477308 0 0.140744 0 0.183154 0 0.0202878 0 0.0803675 0 0.197303 0 0.787197 0 0.128258 0 0.0327196 0 0.138389 0 0.205758 0 0.170322 0 0.268286 0 0.359274 0 0.20973 0 0.0172251 0 0.387515 0 0.426244 0 0.115467 0 2.93916 0 3.02599 0 2.1338 0 0.0919275 0 0.280573 0 0.244285 0 0.192221 0 0.0268813 0 0.103116 0 2.52335
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         3         1         0         0         0         0  #  AT_summer
         4         1         0         0         0         0  #  AT_spring
         5         1         0         1         0         0  #  RREAS_YOY
         6         1         0         1         0         0  #  RELSSB
         7         1         0         0         0         0  #  CDFG
         8         1         0         1         0         0  #  DEPM
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            -3             3             0             0            99             0         -2          0          0          0          0          0          0          0  #  LnQ_base_AT_summer(3)
            -3             3             0             0            99             0         -2          0          0          0          0          0          0          0  #  LnQ_base_AT_spring(4)
           -25            25      -17.9855             0             1             0          1          0          0          0          0          0          0          0  #  LnQ_base_RREAS_YOY(5)
             0           1.5      0.642051             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_RREAS_YOY(5)
           -25            25      -6.79882             0             1             0          1          0          0          0          0          0          0          0  #  LnQ_base_RELSSB(6)
             0             1      0.452974             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_RELSSB(6)
            -3             3       1.87841             0            99             0          2          0          0          0          0          0          0          0  #  LnQ_base_CDFG(7)
           -25            25             0             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_DEPM(8)
             0             1      0.381987             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_DEPM(8)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (mean over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (mean over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 0 0 0 0 # 1 MexCal_S1
 0 0 0 1 # 2 MexCal_S2
 0 0 0 0 # 3 AT_summer
 0 0 0 0 # 4 AT_spring
 0 0 0 0 # 5 RREAS_YOY
 0 0 0 0 # 6 RELSSB
 0 0 0 0 # 7 CDFG
 0 0 0 0 # 8 DEPM
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (mean over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (mean over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 17 0 0 3 # 1 MexCal_S1
 17 0 0 3 # 2 MexCal_S2
 17 0 0 1 # 3 AT_summer
 17 0 0 1 # 4 AT_spring
 0 0 0 0 # 5 RREAS_YOY
 0 0 0 0 # 6 RELSSB
 17 0 0 3 # 7 CDFG
 0 0 0 0 # 8 DEPM
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   MexCal_S1 LenSelex
# 2   MexCal_S2 LenSelex
# 3   AT_summer LenSelex
# 4   AT_spring LenSelex
# 5   RREAS_YOY LenSelex
# 6   RELSSB LenSelex
# 7   CDFG LenSelex
# 8   DEPM LenSelex
# 1   MexCal_S1 AgeSelex
            -6             9             0             0             0             0         -2          0          0          0          0          0          0          0  #  AgeSel_P1_MexCal_S1(1)
            -6             9       8.33965             0             0             0          2          0          0          0          0          0          4          2  #  AgeSel_P2_MexCal_S1(1)
            -6             9       2.00071             0             0             0          2          0          0          0          0          0          4          2  #  AgeSel_P3_MexCal_S1(1)
            -6             9    0.00348789             0             0             0          2          0          0          0          0          0          0          0  #  AgeSel_P4_MexCal_S1(1)
# 2   MexCal_S2 AgeSelex
            -6             9             0             0             0             0         -2          0          0          0          0          0          0          0  #  AgeSel_P1_MexCal_S2(2)
            -6             9       3.24764             0             0             0          2          0          0          0          0          0          5          2  #  AgeSel_P2_MexCal_S2(2)
            -6             9      0.669438             0             0             0          2          0          0          0          0          0          5          2  #  AgeSel_P3_MexCal_S2(2)
            -6             9      0.470508             0             0             0          2          0          0          0          0          0          0          0  #  AgeSel_P4_MexCal_S2(2)
# 3   AT_summer AgeSelex
             0             9             0            -1            99             0         -3          0          0          0          0          0          0          0  #  AgeSel_P1_AT_summer(3)
             0             9      0.863535            -1            99             0          4          0          0          0          0          0          3          2  #  AgeSel_P2_AT_summer(3)
# 4   AT_spring AgeSelex
             0             9             0            -1            99             0         -3          0          0          0          0          0          0          0  #  AgeSel_P1_AT_spring(4)
             0             9       2.77641            -1            99             0          4          0          0          0          0          0          6          2  #  AgeSel_P2_AT_spring(4)
# 5   RREAS_YOY AgeSelex
# 6   RELSSB AgeSelex
# 7   CDFG AgeSelex
             0             9             0            -1            99             0         -3          0          0          0          0          0          0          0  #  AgeSel_P1_CDFG(7)
             0             9       6.12292            -1            99             0          4          0          0          0          0          0          7          2  #  AgeSel_P2_CDFG(7)
             0             9       0.31129            -1            99             0          4          0          0          0          0          0          7          2  #  AgeSel_P3_CDFG(7)
             0             9       3.85409            -1            99             0          4          0          0          0          0          0          7          2  #  AgeSel_P4_CDFG(7)
# 8   DEPM AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
            -6             9       5.71545             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1968
            -6             9       8.91914             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1970
            -6             9       2.00285             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1976
            -6             9      0.277987             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1977
            -6             9       2.22151             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1978
            -6             9       1.96372             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1982
            -6             9     -0.730254             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1984
            -6             9       1.63711             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1986
            -6             9      -2.54748             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1988
            -6             9       2.03674             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1990
            -6             9       1.48096             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2016
            -6             9        4.2226             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2017
            -6             9       8.61398             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2018
            -6             9       8.66379             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2019
            -6             9       8.69855             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2020
            -6             9       1.48651             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1968
            -6             9       1.85493             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1970
            -6             9       1.18089             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1976
            -6             9        2.0823             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1977
            -6             9      0.573104             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1978
            -6             9      0.800531             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1982
            -6             9   -0.00119303             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1984
            -6             9      -3.02438             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1986
            -6             9       1.07557             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1988
            -6             9       1.47737             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1990
            -6             9      0.875559             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2016
            -6             9       1.78242             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2017
            -6             9      0.959197             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2018
            -6             9        1.3808             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2019
            -6             9       1.54908             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2020
            -6             9       1.02424             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1968
            -6             9       2.10251             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1970
            -6             9     -0.270403             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1976
            -6             9       2.53638             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1977
            -6             9      0.973195             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1978
            -6             9      -5.14375             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1982
            -6             9     -0.738752             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1984
            -6             9      0.128582             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1986
            -6             9      -1.91234             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1988
            -6             9       1.73193             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1990
            -6             9      -4.12949             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2016
            -6             9      0.739054             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2017
            -6             9       1.09741             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2018
            -6             9       2.64091             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2019
            -6             9      -0.31356             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2020
            -6             9     -0.254521             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1968
            -6             9      0.437111             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1970
            -6             9      0.904191             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1976
            -6             9       8.30971             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1977
            -6             9       0.48268             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1978
            -6             9       3.75609             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1982
            -6             9      -1.22047             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1984
            -6             9      -1.66338             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1986
            -6             9      -1.01334             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1988
            -6             9       1.17621             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1990
            -6             9      -1.49686             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2016
            -6             9    -0.0377703             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2017
            -6             9      0.114646             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2018
            -6             9     -0.307087             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2019
            -6             9     -0.160219             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2020
             0             9       2.43717            -1            99             0      4  # AgeSel_P2_AT_summer(3)_BLK3repl_2016
             0             9       2.94152            -1            99             0      4  # AgeSel_P2_AT_summer(3)_BLK3repl_2017
             0             9       1.06278            -1            99             0      4  # AgeSel_P2_AT_summer(3)_BLK3repl_2018
             0             9      0.409534            -1            99             0      4  # AgeSel_P2_AT_summer(3)_BLK3repl_2019
             0             9      0.947209            -1            99             0      4  # AgeSel_P2_AT_spring(4)_BLK6repl_2020
             0             9       8.54097            -1            99             0      4  # AgeSel_P2_CDFG(7)_BLK7repl_1967
             0             9       8.25155            -1            99             0      4  # AgeSel_P2_CDFG(7)_BLK7repl_1970
             0             9       8.82156            -1            99             0      4  # AgeSel_P2_CDFG(7)_BLK7repl_1976
             0             9       6.98314            -1            99             0      4  # AgeSel_P2_CDFG(7)_BLK7repl_1977
             0             9       8.92236            -1            99             0      4  # AgeSel_P2_CDFG(7)_BLK7repl_1978
             0             9       8.97343            -1            99             0      4  # AgeSel_P2_CDFG(7)_BLK7repl_1982
             0             9        8.5681            -1            99             0      4  # AgeSel_P2_CDFG(7)_BLK7repl_1984
             0             9     0.0526844            -1            99             0      4  # AgeSel_P3_CDFG(7)_BLK7repl_1967
             0             9       1.49699            -1            99             0      4  # AgeSel_P3_CDFG(7)_BLK7repl_1970
             0             9   0.000411877            -1            99             0      4  # AgeSel_P3_CDFG(7)_BLK7repl_1976
             0             9       5.00882            -1            99             0      4  # AgeSel_P3_CDFG(7)_BLK7repl_1977
             0             9       1.03716            -1            99             0      4  # AgeSel_P3_CDFG(7)_BLK7repl_1978
             0             9    0.00117926            -1            99             0      4  # AgeSel_P3_CDFG(7)_BLK7repl_1982
             0             9       1.33192            -1            99             0      4  # AgeSel_P3_CDFG(7)_BLK7repl_1984
             0             9       2.45029            -1            99             0      4  # AgeSel_P4_CDFG(7)_BLK7repl_1967
             0             9       2.92846            -1            99             0      4  # AgeSel_P4_CDFG(7)_BLK7repl_1970
             0             9   0.000850449            -1            99             0      4  # AgeSel_P4_CDFG(7)_BLK7repl_1976
             0             9   0.000507526            -1            99             0      4  # AgeSel_P4_CDFG(7)_BLK7repl_1977
             0             9       1.58713            -1            99             0      4  # AgeSel_P4_CDFG(7)_BLK7repl_1978
             0             9   0.000705755            -1            99             0      4  # AgeSel_P4_CDFG(7)_BLK7repl_1982
             0             9       0.20116            -1            99             0      4  # AgeSel_P4_CDFG(7)_BLK7repl_1984
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity? (0/1)
#_no 2D_AR1 selex offset used
#_specs:  fleet, ymin, ymax, amin, amax, sigma_amax, use_rho, len1/age2, devphase, before_range, after_range
#_sigma_amax>amin means create sigma parm for each bin from min to sigma_amax; sigma_amax<0 means just one sigma parm is read and used for all bins
#_needed parameters follow each fleet's specifications
# -9999  0 0 0 0 0 0 0 0 0 0 # terminator
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      5     2     1     4     2     0     0     0     0     0     0     0
#      5     3    16     4     2     0     0     0     0     0     0     0
#      5     6    31     5     2     0     0     0     0     0     0     0
#      5     7    46     5     2     0     0     0     0     0     0     0
#      5    10    61     3     2     0     0     0     0     0     0     0
#      5    12    65     6     2     0     0     0     0     0     0     0
#      5    14    66     7     2     0     0     0     0     0     0     0
#      5    15    73     7     2     0     0     0     0     0     0     0
#      5    16    80     7     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 29 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 1 3 1 1 1
 1 4 1 1 1
 1 5 1 1 1
 1 6 1 1 1
 1 7 1 1 1
 1 8 1 1 1
 4 1 1 0 1
 4 2 1 0 1
 4 3 1 0 1
 4 4 1 0 1
 5 1 1 1 1
 5 2 1 1 1
 5 3 1 1 1
 5 4 1 1 1
 5 7 1 1 1
 8 1 1 1 1
 8 2 1 1 1
 8 3 1 0 1
 8 4 1 0 1
 9 1 1 0 1
 9 2 1 0 1
 11 1 1 0 1
 18 1 1 0 1
 18 2 1 0 1
 18 3 1 0 1
 18 4 1 0 1
 18 5 1 0 1
 18 6 1 0 1
 18 8 1 0 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  0 #_CPUE/survey:_2
#  1 #_CPUE/survey:_3
#  1 #_CPUE/survey:_4
#  1 #_CPUE/survey:_5
#  1 #_CPUE/survey:_6
#  1 #_CPUE/survey:_7
#  1 #_CPUE/survey:_8
#  0 #_lencomp:_1
#  0 #_lencomp:_2
#  0 #_lencomp:_3
#  0 #_lencomp:_4
#  0 #_lencomp:_5
#  0 #_lencomp:_6
#  0 #_lencomp:_7
#  0 #_lencomp:_8
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_agecomp:_3
#  1 #_agecomp:_4
#  0 #_agecomp:_5
#  0 #_agecomp:_6
#  1 #_agecomp:_7
#  0 #_agecomp:_8
#  0 #_init_equ_catch1
#  0 #_init_equ_catch2
#  1 #_init_equ_catch3
#  1 #_init_equ_catch4
#  1 #_init_equ_catch5
#  1 #_init_equ_catch6
#  1 #_init_equ_catch7
#  1 #_init_equ_catch8
#  1 #_recruitments
#  0 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

