# Length unit: nm
# Time unit: s
# Energy unit: eV

#Relative path also available when running in the application directory
#XolotlWrapperPath = './xolotl_userobj.i'

#Absolute path is neccessary when running from a remote directory
#XolotlWrapperPath = '/Users/donguk.kim/projects/coupling_xolotl/xolotl_userobj.i'    #for Mac
#XolotlWrapperPath = '/home/donguk.kim/projects/coupling_xolotl/xolotl_userobj.i'    #for UF HPG2
XolotlWrapperPath = './xolotl_subapp.i'  

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 125
  ny = 125
  xmin = 0
  xmax = 20000
  ymin = 0
  ymax = 20000
  #uniform_refine = 3
[]

[GlobalParams]
  op_num = 5
  grain_num = 5
  var_name_base = etam
  numbub = 14
  bubspac = 2500
  radius = 480
  int_width = 480
  invalue = 1
  outvalue = 0
[]

[Variables]
  [./wv]
  [../]
  [./wg]
  [../]
  [./etab0]
  [../]
  [./PolycrystalVariables]
  [../]
[]

[AuxVariables]
  [./bnds]
    order = FIRST
    family = LAGRANGE
  [../]
  [./XolotlXeRate]
    order = FIRST
    family = LAGRANGE
  [../]
  [./XolotlXeMono]
    order = FIRST
    family = LAGRANGE
  [../]
  [./XolotlVolumeFraction]
    order = FIRST
    family = LAGRANGE
  [../]

  [./time]
  [../]
  [./cg]
    order = FIRST
    family = MONOMIAL
  [../]
  [./cv]
    order = FIRST
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  [./time]
    type = FunctionAux
    variable = time
    function = 't'
  [../]
  [./cg]
    type = MaterialRealAux
    variable = cg
    property = cg_from_rhog
  [../]
  [./cv]
    type = MaterialRealAux
    variable = cv
    property = cv_from_rhov
  [../]
[]

[ICs]
  #[./PolycrystalICs]
  #  [./PolycrystalVoronoiVoidIC]
  #    invalue = 1.0
  #    outvalue = 0.0
  #    polycrystal_ic_uo = voronoi
  #  [../]
  #[../]
  [./bnds]
    type = ConstantIC
    variable = bnds
    value = 1
  [../]
   [./etab0_IC]
     type = SmoothCircleIC
     variable = etab0
     invalue = 1
     outvalue = 0
     x1 = 10000
     y1 = 10000
     radius = 480
     int_width = 480
   [../]
   [./etam1_IC]
     type = SmoothCircleIC
     variable = etam1
     invalue = 0
     outvalue = 1
     x1 = 10000
     y1 = 10000
     radius = 480
     int_width = 480
   [../]
  #[./bubble_IC]
  #  variable = etab0
  #  type = PolycrystalVoronoiVoidIC
  #  structure_type = voids
  #  invalue = 1.0
  #  outvalue = 0.0
  #  polycrystal_ic_uo = voronoi
  #[../]
  #[./IC_wv]
  #  variable = wv
  #  type = PolycrystalVoronoiVoidIC
  #  structure_type = voids
  #  invalue = 0.0
  #  outvalue = 0.0
  #  polycrystal_ic_uo = voronoi
  #[../]
  #[./IC_wg]
  #  variable = wg
  #  type = PolycrystalVoronoiVoidIC
  #  structure_type = voids
  #  invalue = 0.0
  #  outvalue = 0.0
  #  polycrystal_ic_uo = voronoi
  #[../]
[]



[BCs]
  #[./Periodic]
  #  [./All]
  #    auto_direction = 'x y'
  #  [../]
  #[../]

  # [./etam0_adiabatic]
  #   type = NeumannBC
  #   boundary = 'left right top bottom'
  #   variable = etam0
  #   value = 0
  # [../]
  # [./etam1_adiabatic]
  #   type = NeumannBC
  #   boundary = 'left right top bottom'
  #   variable = etam1
  #   value = 0
  # [../]
  # [./etam2_adiabatic]
  #   type = NeumannBC
  #   boundary = 'left right top bottom'
  #   variable = etam2
  #   value = 0
  # [../]
  # [./etam3_adiabatic]
  #   type = NeumannBC
  #   boundary = 'left right top bottom'
  #   variable = etam3
  #   value = 0
  # [../]
  # [./etam4_adiabatic]
  #   type = NeumannBC
  #   boundary = 'left right top bottom'
  #   variable = etam4
  #   value = 0
  # [../]
  # [./etab0_adiabatic]
  #   type = NeumannBC
  #   boundary = 'left right top bottom'
  #   variable = etab0
  #   value = 0
  # [../]
  # [./wg_adiabatic]
  #   type = NeumannBC
  #   boundary = 'left right top bottom'
  #   variable = wg
  #   value = 0
  # [../]
  # [./wb_adiabatic]
  #   type = NeumannBC
  #   boundary = 'left right top bottom'
  #   variable = wv
  #   value = 0
  # [../]
[]

[Kernels]

# Order parameter eta_b0 for bubble phase
  [./ACb0_bulk]
    type = ACGrGrMulti
    variable = etab0
    v =           'etam0 etam1 etam2 etam3 etam4'
    gamma_names = 'gmb   gmb   gmb   gmb   gmb'
    mob_name = L
  [../]
  [./ACb0_sw]
    type = ACSwitching
    variable = etab0
    Fj_names  = 'omegab   omegam'
    hj_names  = 'hb       hm'
    args = 'etam0 etam1 etam2 etam3 etam4 wv wg'
    mob_name = L
  [../]
  [./ACb0_int]
    type = ACInterface
    variable = etab0
    kappa_name = kappa
    mob_name = L
  [../]
  [./eb0_dot]
    type = TimeDerivative
    variable = etab0
  [../]
# Order parameter eta_m0 for matrix grain 0
  [./ACm0_bulk]
    type = ACGrGrMulti
    variable = etam0
    v =           'etab0 etam1 etam2 etam3 etam4'
    gamma_names = 'gmb   gmm   gmm   gmm   gmm'
    mob_name = L
  [../]
  [./ACm0_sw]
    type = ACSwitching
    variable = etam0
    Fj_names  = 'omegab   omegam'
    hj_names  = 'hb       hm'
    args = 'etab0 etam1 etam2 etam3 etam4 wv wg'
    mob_name = L
  [../]
  [./ACm0_int]
    type = ACInterface
    variable = etam0
    kappa_name = kappa
    mob_name = L
  [../]
  [./em0_dot]
    type = TimeDerivative
    variable = etam0
  [../]
# Order parameter eta_m1 for matrix grain 1
  [./ACm1_bulk]
    type = ACGrGrMulti
    variable = etam1
    v =           'etab0 etam0 etam2 etam3 etam4'
    gamma_names = 'gmb   gmm   gmm   gmm   gmm'
    mob_name = L
  [../]
  [./ACm1_sw]
    type = ACSwitching
    variable = etam1
    Fj_names  = 'omegab   omegam'
    hj_names  = 'hb       hm'
    args = 'etab0 etam0 etam2 etam3 etam4 wv wg'
    mob_name = L
  [../]
  [./ACm1_int]
    type = ACInterface
    variable = etam1
    kappa_name = kappa
    mob_name = L
  [../]
  [./em1_dot]
    type = TimeDerivative
    variable = etam1
  [../]

  # Order parameter eta_m1 for matrix grain 2
    [./ACm2_bulk]
      type = ACGrGrMulti
      variable = etam2
      v =           'etab0 etam0 etam1 etam3 etam4'
      gamma_names = 'gmb   gmm   gmm   gmm   gmm'
      mob_name = L
    [../]
    [./ACm2_sw]
      type = ACSwitching
      variable = etam2
      Fj_names  = 'omegab   omegam'
      hj_names  = 'hb       hm'
      args = 'etab0 etam0 etam1 etam3 etam4 wv wg'
      mob_name = L
    [../]
    [./ACm2_int]
      type = ACInterface
      variable = etam2
      kappa_name = kappa
      mob_name = L
    [../]
    [./em2_dot]
      type = TimeDerivative
      variable = etam2
    [../]
  # Order parameter eta_m3 for matrix grain 3
    [./ACm3_bulk]
      type = ACGrGrMulti
      variable = etam3
      v =           'etab0 etam0 etam1 etam2 etam4'
      gamma_names = 'gmb   gmm   gmm   gmm   gmm'
      mob_name = L
    [../]
    [./ACm3_sw]
      type = ACSwitching
      variable = etam3
      Fj_names  = 'omegab   omegam'
      hj_names  = 'hb                   hm'
      args = 'etab0 etam0 etam1 etam2 etam4 wv wg'
      mob_name = L
    [../]
    [./ACm3_int]
      type = ACInterface
      variable = etam3
      kappa_name = kappa
      mob_name = L
    [../]
    [./em3_dot]
      type = TimeDerivative
      variable = etam3
    [../]
  # Order parameter eta_m4 for matrix grain 4
    [./ACm4_bulk]
      type = ACGrGrMulti
      variable = etam4
      v =           'etab0 etam0 etam1 etam2 etam3'
      gamma_names = 'gmb   gmm   gmm   gmm   gmm'
      mob_name = L
    [../]
    [./ACm4_sw]
      type = ACSwitching
      variable = etam4
      Fj_names  = 'omegab   omegam'
      hj_names  = 'hb                   hm'
      args = 'etab0 etam0 etam1 etam2 etam3 wv wg'
      mob_name = L
    [../]
    [./ACm4_int]
      type = ACInterface
      variable = etam4
      kappa_name = kappa
      mob_name = L
    [../]
    [./em4_dot]
      type = TimeDerivative
      variable = etam4
    [../]

#Chemical potential for vacancies
  [./wv_dot]
    type = SusceptibilityTimeDerivative
    variable = wv
    f_name = chiv
    args = '' # in this case chi (the susceptibility) is simply a constant
  [../]
  [./Diffusion_v]
    type = MatDiffusion
    variable = wv
    D_name = Dchiv
    args = ''
  [../]
  [./Source_v]
    type = MaskedBodyForce
    variable = wv
    #value = 1
    value = 0
    mask = VacRate0
  [../]
  #[./Source_v]
  #  type = MaskedBodyForce
  #  variable = wv
  #  value = 1
  #  mask = VacRate
  #[../]
  [./coupled_v_etab0dot]
    type = CoupledSwitchingTimeDerivative
    variable = wv
    v = etab0
    Fj_names = 'rhovbub rhovmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_v_etam0dot]
    type = CoupledSwitchingTimeDerivative
    variable = wv
    v = etam0
    Fj_names = 'rhovbub rhovmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_v_etam1dot]
    type = CoupledSwitchingTimeDerivative
    variable = wv
    v = etam1
    Fj_names = 'rhovbub rhovmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_v_etam2dot]
    type = CoupledSwitchingTimeDerivative
    variable = wv
    v = etam2
    Fj_names = 'rhovbub rhovmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_v_etam3dot]
    type = CoupledSwitchingTimeDerivative
    variable = wv
    v = etam3
    Fj_names = 'rhovbub rhovmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_v_etam4dot]
    type = CoupledSwitchingTimeDerivative
    variable = wv
    v = etam4
    Fj_names = 'rhovbub rhovmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]

#Chemical potential for gas atoms
  [./wg_dot]
    type = SusceptibilityTimeDerivative
    variable = wg
    f_name = chig
    args = '' # in this case chi (the susceptibility) is simply a constant
  [../]
  [./Diffusion_g]
    type = MatDiffusion
    variable = wg
    D_name = Dchig
    args = ''
  [../]
  [./Source_g]
    type = MaskedBodyForce
    variable = wg
    #value = 1
    value = 0
    mask = XeRate0
  [../]
  #[./Source_g]
  #  type = MaskedBodyForce
  #  variable = wg
  #  value = 1 # for unit conversion between PF app and Xolotl
  #  mask = XeRate
  #[../]
  [./coupled_g_etab0dot]
    type = CoupledSwitchingTimeDerivative
    variable = wg
    v = etab0
    Fj_names = 'rhogbub rhogmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_g_etam0dot]
    type = CoupledSwitchingTimeDerivative
    variable = wg
    v = etam0
    Fj_names = 'rhogbub rhogmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_g_etam1dot]
    type = CoupledSwitchingTimeDerivative
    variable = wg
    v = etam1
    Fj_names = 'rhogbub rhogmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_g_etam2dot]
    type = CoupledSwitchingTimeDerivative
    variable = wg
    v = etam2
    Fj_names = 'rhogbub rhogmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_g_etam3dot]
    type = CoupledSwitchingTimeDerivative
    variable = wg
    v = etam3
    Fj_names = 'rhogbub rhogmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]
  [./coupled_g_etam4dot]
    type = CoupledSwitchingTimeDerivative
    variable = wg
    v = etam4
    Fj_names = 'rhogbub rhogmatrix'
    hj_names = 'hb      hm'
    args = 'etab0 etam0 etam1 etam2 etam3 etam4'
  [../]

[]

[AuxKernels]
  [./BndsCalc]
    type = BndsCalcAux
    variable = bnds
    execute_on = timestep_end
  [../]
[]

[Materials]
  [./hb]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = hb
    all_etas = 'etab0 etam0 etam1 etam2 etam3 etam4'
    phase_etas = 'etab0'
    #outputs = exodus
  [../]
  [./hm]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = hm
    all_etas = 'etab0 etam0 etam1 etam2 etam3 etam4'
    phase_etas = 'etam0 etam1 etam2 etam3 etam4'
    #outputs = exodus
  [../]
# Chemical contribution to grand potential of bubble
  [./omegab]
    type = DerivativeParsedMaterial
    args = 'wv wg time'
    f_name = omegab
    material_property_names = 'Va kvbub cvbubeq kgbub cgbubeq'
    function = 'if(time < 0, 0, -0.5*wv^2/Va^2/kvbub-wv/Va*cvbubeq-0.5*wg^2/Va^2/kgbub-wg/Va*cgbubeq)'
    derivative_order = 2
    #outputs = exodus
  [../]

# Chemical contribution to grand potential of matrix
  [./omegam]
    type = DerivativeParsedMaterial
    args = 'wv wg time'
    f_name = omegam
    material_property_names = 'Va kvmatrix cvmatrixeq kgmatrix cgmatrixeq'
    function = 'if(time < 0, 0, -0.5*wv^2/Va^2/kvmatrix-wv/Va*cvmatrixeq-0.5*wg^2/Va^2/kgmatrix-wg/Va*cgmatrixeq)'
    derivative_order = 2
    #outputs = exodus
  [../]

# Densities
  [./rhovbub]
    type = DerivativeParsedMaterial
    args = 'wv'
    f_name = rhovbub
    material_property_names = 'Va kvbub cvbubeq'
    function = 'wv/Va^2/kvbub + cvbubeq/Va'
    derivative_order = 2
    #outputs = exodus
  [../]
  [./rhovmatrix]
    type = DerivativeParsedMaterial
    args = 'wv'
    f_name = rhovmatrix
    material_property_names = 'Va kvmatrix cvmatrixeq'
    function = 'wv/Va^2/kvmatrix + cvmatrixeq/Va'
    derivative_order = 2
    #outputs = exodus
  [../]
  [./rhogbub]
    type = DerivativeParsedMaterial
    args = 'wg'
    f_name = rhogbub
    material_property_names = 'Va kgbub cgbubeq'
    function = 'wg/Va^2/kgbub + cgbubeq/Va'
    derivative_order = 2
    #outputs = exodus
  [../]
  [./rhogmatrix]
    type = DerivativeParsedMaterial
    args = 'wg'
    f_name = rhogmatrix
    material_property_names = 'Va kgmatrix cgmatrixeq'
    function = 'wg/Va^2/kgmatrix + cgmatrixeq/Va'
    derivative_order = 2
    #outputs = exodus
  [../]
  [./const]
    type = GenericConstantMaterial
    prop_names =  'kappa     mu      L   Dm      Db     Va      cvbubeq  cgbubeq gmb    gmm T     YXe'
    #prop_values = '0.84368e2 0.00293 0.1   2.3398  2.3398 0.0409  0.546    0.454   0.922  1.5 1200  0.2156'
    #prop_values = '0.84368e1 0.00293e-1 0.5   4.6796  4.6796  0.0409  0.546    0.454   0.922  1.5 1200  0.2156'
    prop_values = '0.84368e1 0.00293e-1 1    2.3398 2.3398  0.0409  0.546    0.454   0.922  1.5 1800  0.25'
    #prop_values = '0.84368e1 0.00293e-1 1    0.0078 0.0078  0.0409  0.546    0.454   0.922  1.5 1000  0.25'
    #prop_values = '2.21125e2 1.875  0.975e-3 0.1  0.1  0.0409  0.546    0.454   0.922  1.5 1200  0.2156'
  [../]
  [./cvmatrixeq]
    type = ParsedMaterial
    f_name = cvmatrixeq
    material_property_names = 'T'
    constant_names        = 'kB           Efv'  # in eV/atom
    constant_expressions  = '8.6173324e-5 3.0'
    function = 'exp(-Efv/(kB*T))'
  [../]
  [./cgmatrixeq]
    type = ParsedMaterial
    f_name = cgmatrixeq
    material_property_names = 'T'
    constant_names        = 'kB           Efg'  # in eV/atom
    constant_expressions  = '8.6173324e-5 3.0'
    function = 'exp(-Efg/(kB*T))'
  [../]
  [./kvmatrix_parabola]
    type = ParsedMaterial
    f_name = kvmatrix
    args = 'time'
    #function = '3.00625e3' # in eV/nm^3
    #function = '7.516' # in eV/nm^3
    function = '7.516e-2' # in eV/nm^3, decreased
    #function = '7.516e-4' # in eV/nm^3, decreased
    #outputs = exodus
  [../]
  [./kgmatrix_parabola]
    type = ParsedMaterial
    f_name = kgmatrix
    material_property_names = 'kvmatrix'
    function = 'kvmatrix'
  [../]
  [./kgbub_parabola]
    type = ParsedMaterial
    f_name = kgbub
    #function = '0.5625e3' # in eV/nm^3
    #function = '1.406' # in eV/nm^3
    function = '1.406e-2' # in eV/nm^3, decreased
    #function = '1.406e-4' # in eV/nm^3, decreased
    #outputs = exodus
  [../]
  [./kvbub_parabola]
    type = ParsedMaterial
    f_name = kvbub
    material_property_names = 'kgbub'
    function = 'kgbub'
  [../]
  [./Mobility_v]
    type = DerivativeParsedMaterial
    f_name = Dchiv
    material_property_names = 'Db chiv'
    args = 'time'
    function = 'if(time < 0, 100*Db*chiv, Db*chiv)'
    #function = 'Db*chiv'
    derivative_order = 2
    # outputs = exodus
  [../]
  [./Mobility_g]
    type = DerivativeParsedMaterial
    f_name = Dchig
    material_property_names = 'Dm chig'
    args = 'time'
    function = 'if(time < 0, 100*Dm*chig, Dm*chig)'
    #function = 'Dm*chig'
    derivative_order = 2
    # outputs = exodus
  [../]
  [./chiv]
    type = DerivativeParsedMaterial
    f_name = chiv
    material_property_names = 'Va hb kvbub hm kvmatrix '
    function = '(hm/kvmatrix + hb/kvbub) / Va^2'
    derivative_order = 2
    # outputs = exodus
  [../]
  [./chig]
    type = DerivativeParsedMaterial
    f_name = chig
    material_property_names = 'Va hb kgbub hm kgmatrix '
    function = '(hm/kgmatrix + hb/kgbub) / Va^2'
    derivative_order = 2
    # outputs = exodus
  [../]

  [./XeRate]
    type = ParsedMaterial
    f_name = XeRate
    material_property_names = 'hm'
    args = 'time XolotlXeRate'  # XolotlXeRate is in Xe/(nm^3 * s) & Va is in Xe/nm^3
    # function = 'if(time < 0, 0, XolotlXeRate * hm)'
    function = 'if(time < 0, 0, XolotlXeRate)'
    outputs = exodus
  [../]

  [./VacRate]
    type = ParsedMaterial
    f_name = VacRate
    material_property_names = 'XeRate YXe'
    function = 'XeRate / YXe'
    outputs = exodus
  [../]

  [./XeRate_ref]
    type = ParsedMaterial
    f_name = XeRate0
    material_property_names = 'Va hm'
    constant_names = 's0'
    constant_expressions = '2.0e-9'  # in atoms/(nm^3 * s)
    args = 'time bnds'
    function = 'if(time < 0, 0, if(bnds >= 0.9 ,s0, 0))'
    outputs = exodus
  [../]
  [./VacRate_ref]
    type = ParsedMaterial
    f_name = VacRate0
    material_property_names = 'YXe XeRate0'
    args = 'time'
    function = 'if(time < 0, 0, XeRate0 / YXe)'
    outputs = exodus
  [../]

  [./cg]
    type = ParsedMaterial
    f_name = cg_from_rhog
    material_property_names = 'Va rhogbub rhogmatrix hm hb'
    function = 'hb*Va*rhogbub + hm*Va*rhogmatrix'
    outputs = exodus
  [../]
  [./cv]
    type = ParsedMaterial
    f_name = cv_from_rhov
    material_property_names = 'Va rhovbub rhovmatrix hm hb'
    function = 'hb*Va*rhovbub + hm*Va*rhovmatrix'
    outputs = exodus
  [../]
[]

[UserObjects]
  [./voronoi]
    type = PolycrystalVoronoi
    rand_seed = 1
    int_width = 480
  [../]
[]

#[Adaptivity]
#  marker = errorfrac
#  max_h_level = 3
#  [./Indicators]
#    [./error]
#      type = GradientJumpIndicator
#      variable = bnds
#    [../]
#  [../]
#  [./Markers]
#    [./bound_adapt]
#      type = ValueThresholdMarker
#      third_state = DO_NOTHING
#      coarsen = 1.0
#      refine = 0.99
#      variable = bnds
#      invert = true
#    [../]
#    [./errorfrac]
#      type = ErrorFractionMarker
#      coarsen = 0.1
#      indicator = error
#      refine = 0.7
#    [../]
#  [../]
#[]

[Postprocessors]
  # [./number_DOFs]
  #   type = NumDOFs
  # [../]
  # [./dt]
  #   type = TimestepSize
  # [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  # Preconditioned JFNK (default)
  type = Transient
  nl_max_its = 15
  scheme = bdf2
  solve_type = NEWTON
  #solve_type = PJFNK
  #petsc_options_iname = '-pc_type -sub_pc_type'
  #petsc_options_value = 'asm      lu'
  # Use with solve_type = NEWTON in Executioner block
  petsc_options_iname = '-pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = 'bjacobi  gmres     30'  # default is 30, the higher the higher resolution but the slower

  l_max_its = 15
  l_tol = 1.0e-5
  nl_rel_tol = 1.0e-8
  start_time = -2e3
  #start_time = 0
  #num_steps = 1000
  end_time = 1.2e8
  #end_time = 1.2e6
  nl_abs_tol = 1e-10
  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.5
    growth_factor = 1.2
    cutback_factor = 0.8
    # adapt_log = true
  [../]
[]

[Outputs]
  [./exodus]
    type = Exodus
    interval = 10
    # interval = 1
    sync_times = '0 1.2e8'
    #sync_times = '0 1.2e6'
  [../]
  # checkpoint = true
  csv = true
  perf_graph = true
[]


[Postprocessors]
  # [./number_DOFs]
  #   type = NumDOFs
  # [../]
  [./dt]
    type = TimestepSize
  [../]
  [./porosity]
    type = ElementAverageValue
    variable = etab0
  [../]
[]
