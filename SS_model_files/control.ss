#V3.30.22.00;_safe;_compile_date:_Oct 30 2023;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: anchovy2021.dat // anchovy2021.ctl
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
 0.2 1.5 0.66283 0 99 0 2 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
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
             3            30       17.3698             0             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
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
 1960.0   #_last_early_yr_nobias_adj_in_MPD 
 1981.4   #_first_yr_fullbias_adj_in_MPD 
 2016.6   #_last_yr_fullbias_adj_in_MPD 
 2022.3   #_first_recent_yr_nobias_adj_in_MPD 
 0.6929  #_max_bias_adj_in_MPD (1.0 to mimic pre-2009 models) 
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
#  -0.227774 -0.24691 -0.370503 -0.977186 0.842845 0.60364 1.12228 1.94964 1.23866 1.53718 0.883828 -0.574051 -0.661305 0.711076 -0.66625 1.71996 1.09957 0.932699 -0.550581 0.420169 1.93433 0.260601 0.0419674 0.981382 0.0761925 -2.05653 -0.149104 -0.419043 -0.568637 -0.419776 -0.229261 -0.418167 -0.264318 -0.576668 -0.598425 -0.387906 -0.274574 -0.194985 -0.233651 -0.0170098 0.428553 -0.61968 -0.753976 -1.39589 -1.40233 -1.67028 -1.38805 -1.47134 -1.23346 -0.583539 -0.900395 -0.876281 0.900727 0.542626 0.79527 0.557805 1.18623 2.13082 -0.335858 -0.163885 0
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
# MexCal_S1 0.0977896 0 0.234045 0 0.170381 0 0.199604 0 0.252641 0 0.38351 0 0.111664 0 0.12707 0 0.167064 0 0.157132 0 0.317269 0 0.759689 0 2.12094 0 1.09336 0 0.686629 0 1.02324 0 1.43557 0 2.3721 0 1.41959 0 0.518104 0 0.395706 0 1.03584 0 0.694081 0 3.14713 0 0.836337 0 0.0949892 0 0.106672 0 0.0801408 0 0.0535998 0 0.0584312 0 0.283434 0 0.0821622 0 0.0519076 0 0.0321299 0 0.105728 0 0.135729 0 0.0596888 0 0.0348238 0 0.0218171 0 0.0235969 0 0.0763144 0 0.0799528 0 0.0782002 0 0.158045 0 0.0782944 0 0.19504 0 0.115187 0 0.124224 0 0.539906 0 0.158588 0 3.55504 0 0.134005 0 0.173565 0 0.235119 0 0.130992 0 0.0954418 0 0.0183756 0 0.489316 0
# MexCal_S2 0 0.27763 0 0.428966 0 0.0726176 0 0.0947794 0 0.176933 0 0.143192 0 0.147029 0 0.139391 0 0.103285 0 0.25815 0 0.283609 0 0.386092 0 1.76296 0 0.901942 0 0.230628 0 0.727687 0 0.752556 0 0.794477 0 0.0916879 0 0.245105 0 0.130846 0 0.215572 0 0.0390878 0 3.99999 0 0.07719 0 0.123354 0 0.0478047 0 0.0584223 0 0.0317997 0 0.0486099 0 0.14084 0 0.181663 0 0.0200066 0 0.0789207 0 0.192552 0 0.763892 0 0.124222 0 0.0316678 0 0.134535 0 0.2021 0 0.169708 0 0.269388 0 0.357903 0 0.207745 0 0.0169596 0 0.380121 0 0.417422 0 0.113454 0 2.89464 0 2.9814 0 2.09922 0 0.0930968 0 0.271523 0 0.236396 0 0.185583 0 0.0272541 0 0.0942856 0 2.51068
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
         4         1         0         1         0         1  #  CalCOFI
         5         1         0         1         0         0  #  RREAS_YOY
         6         1         0         1         0         1  #  CalCOFI_eggs
         7         1         0         0         0         0  #  AT_spring
         8         1         0         1         0         0  #  ThayerBiomass
         9         1         0         1         0         1  #  SPOTTER
        10         1         0         1         0         0  #  RREAS_Adult
        11         1         0         1         0         1  #  CASL_summer
        12         1         0         0         0         0  #  SONAR_Methot89
        13         1         0         1         0         1  #  EPI_Jacobson94
        14         1         0         1         0         0  #  DEPM
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            -3             3             0             0            99             0         -2          0          0          0          0          0          0          0  #  LnQ_base_AT_summer(3)
           -25            25      -6.87183             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CalCOFI(4)
             0             1           0.5             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_CalCOFI(4)
           -25            25      -17.9575             0             1             0          1          0          0          0          0          0          0          0  #  LnQ_base_RREAS_YOY(5)
             0           1.5      0.636998             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_RREAS_YOY(5)
           -25            25      -6.26008             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CalCOFI_eggs(6)
             0             1      0.500025             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_CalCOFI_eggs(6)
            -3             3             0             0            99             0         -2          0          0          0          0          0          0          0  #  LnQ_base_AT_spring(7)
           -25            25      -6.77692             0             1             0          1          0          0          0          0          0          0          0  #  LnQ_base_ThayerBiomass(8)
             0             1      0.450897             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_ThayerBiomass(8)
           -25            25      -7.98878             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_SPOTTER(9)
             0             1      0.500062             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_SPOTTER(9)
           -25            25      -10.8684             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_RREAS_Adult(10)
             0             1      0.499974             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_RREAS_Adult(10)
           -25            25      -12.3673             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CASL_summer(11)
             0             1      0.500246             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_CASL_summer(11)
            -3             3       1.87375             0            99             0          2          0          0          0          0          0          0          0  #  LnQ_base_SONAR_Methot89(12)
           -25            25      -11.8014             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_EPI_Jacobson94(13)
             0             1      0.499997             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_EPI_Jacobson94(13)
           -25            25             0             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_DEPM(14)
             0             1      0.373813             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_DEPM(14)
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
 0 0 0 0 # 4 CalCOFI
 0 0 0 0 # 5 RREAS_YOY
 0 0 0 0 # 6 CalCOFI_eggs
 0 0 0 0 # 7 AT_spring
 0 0 0 0 # 8 ThayerBiomass
 0 0 0 0 # 9 SPOTTER
 0 0 0 0 # 10 RREAS_Adult
 0 0 0 0 # 11 CASL_summer
 0 0 0 0 # 12 SONAR_Methot89
 0 0 0 0 # 13 EPI_Jacobson94
 0 0 0 0 # 14 DEPM
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
 0 0 0 0 # 4 CalCOFI
 0 0 0 0 # 5 RREAS_YOY
 0 0 0 0 # 6 CalCOFI_eggs
 17 0 0 1 # 7 AT_spring
 0 0 0 0 # 8 ThayerBiomass
 0 0 0 0 # 9 SPOTTER
 0 0 0 0 # 10 RREAS_Adult
 0 0 0 0 # 11 CASL_summer
 17 0 0 3 # 12 SONAR_Methot89
 0 0 0 0 # 13 EPI_Jacobson94
 0 0 0 0 # 14 DEPM
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   MexCal_S1 LenSelex
# 2   MexCal_S2 LenSelex
# 3   AT_summer LenSelex
# 4   CalCOFI LenSelex
# 5   RREAS_YOY LenSelex
# 6   CalCOFI_eggs LenSelex
# 7   AT_spring LenSelex
# 8   ThayerBiomass LenSelex
# 9   SPOTTER LenSelex
# 10   RREAS_Adult LenSelex
# 11   CASL_summer LenSelex
# 12   SONAR_Methot89 LenSelex
# 13   EPI_Jacobson94 LenSelex
# 14   DEPM LenSelex
# 1   MexCal_S1 AgeSelex
            -6             9             0             0             0             0         -2          0          0          0          0          0          0          0  #  AgeSel_P1_MexCal_S1(1)
            -6             9       8.38603             0             0             0          2          0          0          0          0          0          4          2  #  AgeSel_P2_MexCal_S1(1)
            -6             9       1.82923             0             0             0          2          0          0          0          0          0          4          2  #  AgeSel_P3_MexCal_S1(1)
            -6             9     -0.014512             0             0             0          2          0          0          0          0          0          0          0  #  AgeSel_P4_MexCal_S1(1)
# 2   MexCal_S2 AgeSelex
            -6             9             0             0             0             0         -2          0          0          0          0          0          0          0  #  AgeSel_P1_MexCal_S2(2)
            -6             9       3.34239             0             0             0          2          0          0          0          0          0          5          2  #  AgeSel_P2_MexCal_S2(2)
            -6             9      0.536635             0             0             0          2          0          0          0          0          0          5          2  #  AgeSel_P3_MexCal_S2(2)
            -6             9      0.452168             0             0             0          2          0          0          0          0          0          0          0  #  AgeSel_P4_MexCal_S2(2)
# 3   AT_summer AgeSelex
             0             9             0            -1            99             0         -3          0          0          0          0          0          0          0  #  AgeSel_P1_AT_summer(3)
             0             9      0.843468            -1            99             0          4          0          0          0          0          0          3          2  #  AgeSel_P2_AT_summer(3)
# 4   CalCOFI AgeSelex
# 5   RREAS_YOY AgeSelex
# 6   CalCOFI_eggs AgeSelex
# 7   AT_spring AgeSelex
             0             9             0            -1            99             0         -3          0          0          0          0          0          0          0  #  AgeSel_P1_AT_spring(7)
             0             9       2.76403            -1            99             0          4          0          0          0          0          0          6          2  #  AgeSel_P2_AT_spring(7)
# 8   ThayerBiomass AgeSelex
# 9   SPOTTER AgeSelex
# 10   RREAS_Adult AgeSelex
# 11   CASL_summer AgeSelex
# 12   SONAR_Methot89 AgeSelex
             0             9             0            -1            99             0         -3          0          0          0          0          0          0          0  #  AgeSel_P1_SONAR_Methot89(12)
             0             9       6.05719            -1            99             0          4          0          0          0          0          0          7          2  #  AgeSel_P2_SONAR_Methot89(12)
             0             9        0.3503            -1            99             0          4          0          0          0          0          0          7          2  #  AgeSel_P3_SONAR_Methot89(12)
             0             9       3.77532            -1            99             0          4          0          0          0          0          0          7          2  #  AgeSel_P4_SONAR_Methot89(12)
# 13   EPI_Jacobson94 AgeSelex
# 14   DEPM AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
            -6             9       5.78033             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1968
            -6             9       8.91814             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1970
            -6             9       1.99185             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1976
            -6             9       0.27275             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1977
            -6             9       2.21005             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1978
            -6             9       1.94249             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1982
            -6             9     -0.746462             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1984
            -6             9       1.67043             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1986
            -6             9      -3.05638             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1988
            -6             9       2.02026             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_1990
            -6             9       1.46686             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2016
            -6             9       4.21195             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2017
            -6             9       8.61071             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2018
            -6             9       8.65757             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2019
            -6             9       8.69765             0             0             0      2  # AgeSel_P2_MexCal_S1(1)_BLK4repl_2020
            -6             9       1.46268             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1968
            -6             9       1.84334             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1970
            -6             9       1.18601             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1976
            -6             9       2.07903             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1977
            -6             9      0.575025             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1978
            -6             9      0.799681             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1982
            -6             9    -0.0269901             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1984
            -6             9       -3.0556             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1986
            -6             9       1.14772             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1988
            -6             9       1.48568             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_1990
            -6             9      0.866894             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2016
            -6             9       1.76864             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2017
            -6             9      0.948221             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2018
            -6             9       1.36813             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2019
            -6             9       1.52316             0             0             0      2  # AgeSel_P3_MexCal_S1(1)_BLK4repl_2020
            -6             9       1.01477             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1968
            -6             9       2.09119             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1970
            -6             9     -0.278477             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1976
            -6             9       2.53689             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1977
            -6             9      0.968386             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1978
            -6             9      -5.19561             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1982
            -6             9      -0.76036             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1984
            -6             9      0.180982             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1986
            -6             9      -3.36744             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1988
            -6             9       1.72482             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_1990
            -6             9      -4.12244             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2016
            -6             9      0.728895             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2017
            -6             9       1.08584             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2018
            -6             9       2.61623             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2019
            -6             9     -0.320372             0             0             0      2  # AgeSel_P2_MexCal_S2(2)_BLK5repl_2020
            -6             9      -0.28222             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1968
            -6             9      0.426574             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1970
            -6             9      0.907206             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1976
            -6             9       8.31046             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1977
            -6             9      0.483511             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1978
            -6             9        3.7829             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1982
            -6             9      -1.24939             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1984
            -6             9      -1.72779             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1986
            -6             9     -0.954032             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1988
            -6             9       1.17535             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_1990
            -6             9      -1.50893             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2016
            -6             9    -0.0526754             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2017
            -6             9      0.101758             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2018
            -6             9     -0.321552             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2019
            -6             9     -0.180216             0             0             0      2  # AgeSel_P3_MexCal_S2(2)_BLK5repl_2020
             0             9       2.41746            -1            99             0      4  # AgeSel_P2_AT_summer(3)_BLK3repl_2016
             0             9       2.92118            -1            99             0      4  # AgeSel_P2_AT_summer(3)_BLK3repl_2017
             0             9       1.04214            -1            99             0      4  # AgeSel_P2_AT_summer(3)_BLK3repl_2018
             0             9      0.379604            -1            99             0      4  # AgeSel_P2_AT_summer(3)_BLK3repl_2019
             0             9      0.934611            -1            99             0      4  # AgeSel_P2_AT_spring(7)_BLK6repl_2020
             0             9       8.52955            -1            99             0      4  # AgeSel_P2_SONAR_Methot89(12)_BLK7repl_1967
             0             9       8.24573            -1            99             0      4  # AgeSel_P2_SONAR_Methot89(12)_BLK7repl_1970
             0             9       8.81854            -1            99             0      4  # AgeSel_P2_SONAR_Methot89(12)_BLK7repl_1976
             0             9       6.99943            -1            99             0      4  # AgeSel_P2_SONAR_Methot89(12)_BLK7repl_1977
             0             9       8.92187            -1            99             0      4  # AgeSel_P2_SONAR_Methot89(12)_BLK7repl_1978
             0             9       8.97272            -1            99             0      4  # AgeSel_P2_SONAR_Methot89(12)_BLK7repl_1982
             0             9       8.56242            -1            99             0      4  # AgeSel_P2_SONAR_Methot89(12)_BLK7repl_1984
             0             9     0.0893533            -1            99             0      4  # AgeSel_P3_SONAR_Methot89(12)_BLK7repl_1967
             0             9       1.50048            -1            99             0      4  # AgeSel_P3_SONAR_Methot89(12)_BLK7repl_1970
             0             9   0.000399822            -1            99             0      4  # AgeSel_P3_SONAR_Methot89(12)_BLK7repl_1976
             0             9       4.96122            -1            99             0      4  # AgeSel_P3_SONAR_Methot89(12)_BLK7repl_1977
             0             9       1.03908            -1            99             0      4  # AgeSel_P3_SONAR_Methot89(12)_BLK7repl_1978
             0             9    0.00111221            -1            99             0      4  # AgeSel_P3_SONAR_Methot89(12)_BLK7repl_1982
             0             9       1.29831            -1            99             0      4  # AgeSel_P3_SONAR_Methot89(12)_BLK7repl_1984
             0             9       2.39217            -1            99             0      4  # AgeSel_P4_SONAR_Methot89(12)_BLK7repl_1967
             0             9       2.89453            -1            99             0      4  # AgeSel_P4_SONAR_Methot89(12)_BLK7repl_1970
             0             9   0.000784825            -1            99             0      4  # AgeSel_P4_SONAR_Methot89(12)_BLK7repl_1976
             0             9   0.000501307            -1            99             0      4  # AgeSel_P4_SONAR_Methot89(12)_BLK7repl_1977
             0             9       1.57004            -1            99             0      4  # AgeSel_P4_SONAR_Methot89(12)_BLK7repl_1978
             0             9   0.000691753            -1            99             0      4  # AgeSel_P4_SONAR_Methot89(12)_BLK7repl_1982
             0             9      0.210051            -1            99             0      4  # AgeSel_P4_SONAR_Methot89(12)_BLK7repl_1984
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
# read 36 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 1 3 1 1 1
 1 4 1 0 1
 1 5 1 1 1
 1 6 1 0 1
 1 7 1 1 1
 1 8 1 1 1
 1 9 1 0 1
 1 10 1 0 1
 1 11 1 0 1
 1 12 1 1 1
 1 13 1 0 1
 1 14 1 1 1
 4 1 1 0 1
 4 2 1 0 1
 4 3 1 0 1
 5 1 1 1 1
 5 2 1 1 1
 5 3 1 1 1
 5 7 1 1 1
 5 12 1 1 1
 8 1 1 1 1
 8 2 1 1 1
 8 3 1 0 1
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
 18 9 1 0 1
 18 10 1 0 1
 18 11 1 0 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  0 #_CPUE/survey:_2
#  1 #_CPUE/survey:_3
#  0 #_CPUE/survey:_4
#  1 #_CPUE/survey:_5
#  0 #_CPUE/survey:_6
#  1 #_CPUE/survey:_7
#  1 #_CPUE/survey:_8
#  0 #_CPUE/survey:_9
#  0 #_CPUE/survey:_10
#  0 #_CPUE/survey:_11
#  1 #_CPUE/survey:_12
#  0 #_CPUE/survey:_13
#  1 #_CPUE/survey:_14
#  0 #_lencomp:_1
#  0 #_lencomp:_2
#  0 #_lencomp:_3
#  0 #_lencomp:_4
#  0 #_lencomp:_5
#  0 #_lencomp:_6
#  0 #_lencomp:_7
#  0 #_lencomp:_8
#  0 #_lencomp:_9
#  0 #_lencomp:_10
#  0 #_lencomp:_11
#  0 #_lencomp:_12
#  0 #_lencomp:_13
#  0 #_lencomp:_14
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_agecomp:_3
#  0 #_agecomp:_4
#  0 #_agecomp:_5
#  0 #_agecomp:_6
#  1 #_agecomp:_7
#  0 #_agecomp:_8
#  0 #_agecomp:_9
#  0 #_agecomp:_10
#  0 #_agecomp:_11
#  1 #_agecomp:_12
#  0 #_agecomp:_13
#  0 #_agecomp:_14
#  0 #_init_equ_catch1
#  0 #_init_equ_catch2
#  1 #_init_equ_catch3
#  1 #_init_equ_catch4
#  1 #_init_equ_catch5
#  1 #_init_equ_catch6
#  1 #_init_equ_catch7
#  1 #_init_equ_catch8
#  1 #_init_equ_catch9
#  1 #_init_equ_catch10
#  1 #_init_equ_catch11
#  1 #_init_equ_catch12
#  1 #_init_equ_catch13
#  1 #_init_equ_catch14
#  1 #_recruitments
#  0 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
2 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 0 2 0 0 # Selectivity: (1) 0 to skip or fleet, (2) 1=len/2=age/3=combined, (3) year, (4) N selex bins; NOTE: combined reports in age bins
 0 0 # Growth: (1) 0 to skip or growth pattern, (2) growth ages; NOTE: does each sex
 0 0 0 # Numbers-at-age: (1) 0 or area(-1 for all), (2) year, (3) N ages;  NOTE: sums across morphs
 0 0 # Mortality: (1) 0 to skip or growth pattern, (2) N ages for mortality; NOTE: does each sex
0 # Dyn Bzero: 0 to skip, 1 to include, or 2 to add recr
1 # SmryBio: 0 to skip, 1 to include
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
 # -1 # list of ages for NatM std (-1 in first bin to self-generate)
999

