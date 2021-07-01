[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 120
  ny = 120
  xmin = 0
  xmax = 1200
  # xmax = 2400
  ymin = 0
  ymax = 1200
  # ymax = 600
[]

[Modules]
  [./PhaseField]
    [./GrandPotential]
      switching_function_names = 'hb hm'
      anisotropic = false

      chemical_potentials = 'wv wg'
      mobilities = 'Dchiv Dchig'
      susceptibilities = 'chiv chig'
      free_energies_w = 'rhovbub rhovmatrix rhogbub rhogmatrix'

      # gamma_gr = gmm
      gamma_gr = gm_final
      mobility_name_gr = L
      kappa_gr = kappa
      free_energies_gr = 'omegab omegam'

      additional_ops = 'bubble'
      # gamma_grxop = gmb
      gamma_grxop = gm_final
      mobility_name_op = L
      kappa_op = kappa
      free_energies_op = 'omegab omegam'
    [../]
  [../]
[]

[GlobalParams]
  op_num = 5
  grain_num = 5
  var_name_base = etam
  numbub = 14
  bubspac = 150
  radius = 44
  int_width = 30
[]

[UserObjects]
  [./voronoi]
    type = PolycrystalVoronoi
    coloring_algorithm = bt # We must use bt to force the UserObject to assign one grain to each op
    rand_seed = 2
  [../]
[]

[Variables]
  [./wv]
  [../]
  [./wg]
  [../]
  [./bubble]
  [../]
  [./PolycrystalVariables]
  [../]
[]

[AuxVariables]
  [./bnds]
  [../]
  [./XolotlXeRate]
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
  [./bnds_aux]
    type = BndsCalcAux
    variable = bnds
  [../]
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
  [./PolycrystalICs]
    [./PolycrystalVoronoiVoidIC]
      invalue = 1.0
      outvalue = 0.0
      polycrystal_ic_uo = voronoi
    [../]
  [../]
  [./bnds]
    type = ConstantIC
    variable = bnds
    value = 1
  [../]
  [./bubble_IC]
    variable = bubble
    type = PolycrystalVoronoiVoidIC
    structure_type = voids
    invalue = 1.0
    outvalue = 0.0
    polycrystal_ic_uo = voronoi
  [../]
  [./IC_wv]
    variable = wv
    type = PolycrystalVoronoiVoidIC
    structure_type = voids
    invalue = 0.0
    outvalue = 0.0
    polycrystal_ic_uo = voronoi
  [../]
  [./IC_wg]
    variable = wg
    type = PolycrystalVoronoiVoidIC
    structure_type = voids
    invalue = 0.0
    outvalue = 0.0
    polycrystal_ic_uo = voronoi
  [../]
[]

[BCs]
[]

[Kernels]
  [./Source_v]
    type = MaskedBodyForce
    variable = wv
    value = 1
    mask = VacRate0
  [../]
  [./Source_g]
    type = MaskedBodyForce
    variable = wg
    value = 1
    mask = XeRate0
  [../]
[]

[Materials]
  [./hb]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = hb
    all_etas = 'bubble etam0 etam1 etam2 etam3 etam4'
    phase_etas = 'bubble'
    outputs = exodus
  [../]
  [./hm]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = hm
    all_etas = 'bubble etam0 etam1 etam2 etam3 etam4'
    phase_etas = 'etam0 etam1 etam2 etam3 etam4'
    outputs = exodus
  [../]
  # Chemical contribution to grand potential of bubble
  [./omegab]
    type = DerivativeParsedMaterial
    args = 'wv wg'
    f_name = omegab
    material_property_names = 'Va kvbub cvbubeq kgbub cgbubeq'
    function = '-0.5*wv^2/Va^2/kvbub-wv/Va*cvbubeq-0.5*wg^2/Va^2/kgbub-wg/Va*cgbubeq'
    derivative_order = 2
    outputs = exodus
  [../]

  # Chemical contribution to grand potential of matrix
  [./omegam]
    type = DerivativeParsedMaterial
    args = 'wv wg'
    f_name = omegam
    material_property_names = 'Va kvmatrix cvmatrixeq kgmatrix cgmatrixeq'
    function = '-0.5*wv^2/Va^2/kvmatrix-wv/Va*cvmatrixeq-0.5*wg^2/Va^2/kgmatrix-wg/Va*cgmatrixeq'
    derivative_order = 2
    outputs = exodus
  [../]

  # Densities
  [./rhovbub]
    type = DerivativeParsedMaterial
    args = 'wv'
    f_name = rhovbub
    material_property_names = 'Va kvbub cvbubeq'
    function = 'wv/Va^2/kvbub + cvbubeq/Va'
    derivative_order = 2
    outputs = exodus
  [../]
  [./rhovmatrix]
    type = DerivativeParsedMaterial
    args = 'wv'
    f_name = rhovmatrix
    material_property_names = 'Va kvmatrix cvmatrixeq'
    function = 'wv/Va^2/kvmatrix + cvmatrixeq/Va'
    derivative_order = 2
    outputs = exodus
  [../]
  [./rhogbub]
    type = DerivativeParsedMaterial
    args = 'wg'
    f_name = rhogbub
    material_property_names = 'Va kgbub cgbubeq'
    function = 'wg/Va^2/kgbub + cgbubeq/Va'
    derivative_order = 2
    outputs = exodus
  [../]
  [./rhogmatrix]
    type = DerivativeParsedMaterial
    args = 'wg'
    f_name = rhogmatrix
    material_property_names = 'Va kgmatrix cgmatrixeq'
    function = 'wg/Va^2/kgmatrix + cgmatrixeq/Va'
    derivative_order = 2
    outputs = exodus
  [../]
  [./const]
    type = GenericConstantMaterial
    # prop_names =  'D_surf D_gb D_grain   kappa     mu     L        Va      cvbubeq  cgbubeq gmb 	 gmm T     YXe'
    # prop_values = '5e-1    1e-1   1e-2   2.21125e2 1.875  0.975e-3 0.0409  0.546    0.454   0.922  1.5 1200  0.2156'
    # prop_names =  'D_grain  L_bubble  L_GB     kappa     mu     Va      cvbubeq  cgbubeq gmb 	 gmm T     YXe'
    # prop_values = '0.0212   1e-3     3.6e-4  2.21125e2 1.875  0.0409  0.546    0.454    0.922  1.5 1200  0.2156'
    prop_names =  'D_grain  L_bubble  L_GB     kappa     mu     Va      cvbubeq  cgbubeq     gmb 	 gmm   T     YXe'
    prop_values = '0.0212   1e-3     3.6e-4  2.21125e2  1.875  0.0409    0.546    0.454     11.2   1.5  1200  0.2156'
    # prop_names =  'D_grain  L   kappa     mu     Va      cvbubeq  cgbubeq gmb 	 gmm T     YXe'
    # prop_values = '0.0212  1e-3  2.21125e2 1.875 0.0409  0.546    0.454   11.2  1.5 1200  0.2156'
  [../]
  [./gm_final]
    type = DerivativeParsedMaterial
    f_name = gm_final
    material_property_names = 'gmb gmm H_trans'
    function = 'gmm*(1-H_trans)+gmb*H_trans'
    derivative_order = 2
    outputs = exodus
  [../]
  [./L]
    type = DerivativeParsedMaterial
    f_name = L
    material_property_names = 'L_bubble L_GB H_trans'
    function = 'L_GB*(1-H_trans)+L_bubble*H_trans'
    derivative_order = 2
    outputs = exodus
  [../]
  [./H_trans]
    type = DerivativeParsedMaterial
    f_name = H_trans
    args = 'bubble'
    # function = '1+1/sinh(-20*bubble-0.881371)'
    function = 'if(bubble < 0.3, 6*(bubble/0.3)^5-15*(bubble/0.3)^4+10*(bubble/0.3)^3,1)'
    derivative_order = 2
    outputs = exodus
  [../]
  # [./D_grain]
  #   type = DerivativeParsedMaterial
  #   f_name = D_grain
  #   constant_names = 'D_o Q K'
  #   constant_expressions = '2e11 2.4 8.617e-5'
  #   material_property_names = 'T'
  #   function = 'D_o*exp(-Q/(K*T))'
  # [../]
  [./D_gb]
    type = DerivativeParsedMaterial
    f_name = D_gb
    material_property_names = 'D_grain'
    # function = '1e1*D_grain'
    function = '10*D_grain'
  [../]
  [./D_surf]
    type = DerivativeParsedMaterial
    f_name = D_surf
    material_property_names = 'D_grain'
    # function = '5e1*D_grain'
    function = '50*D_grain'
  [../]
  [./Dg_eff]
    type = ParsedMaterial
    f_name = Dg
    material_property_names = 'D_gb D_grain D_surf g_GB g_grain g_surf'
    function = '(D_gb*g_GB+D_grain*g_grain+D_surf*g_surf)'
    outputs = exodus
  [../]
  [./Dv_eff]
    type = ParsedMaterial
    f_name = Dv
    material_property_names = 'D_gb D_grain D_surf g_GB g_grain g_surf'
    function = '20*(D_gb*g_GB+D_grain*g_grain+D_surf*g_surf)'
    outputs = exodus
  [../]
  [./g_GB]
    type = ParsedMaterial
    f_name = g_GB
    args = 'etam0 etam1 etam2 etam3 etam4'
    function ='2*(etam0*etam1+etam0*etam2+etam0*etam3+etam0*etam4+etam1*etam0+etam1*etam2+etam1*etam3+etam1*etam4+etam2*etam0+etam2*etam1+etam2*etam3+etam2*etam4+etam3*etam0+etam3*etam1+etam3*etam2+etam3*etam4+etam4*etam0+etam4*etam1+etam4*etam2+etam4*etam3)'
    outputs = exodus
  [../]
  [./g_grain]
    type = ParsedMaterial
    f_name = g_grain
    function = '1'
    outputs = exodus
  [../]
  [./g_surf]
    type = ParsedMaterial
    f_name = g_surf
    args = 'bubble'
    function = '4*(bubble/0.5)^2*(1-bubble)^2'
    outputs = exodus
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
    function = '3.00625e3' # in eV/nm^3
    outputs = exodus
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
    function = '0.5625e3' # in eV/nm^3
    outputs = exodus
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
    material_property_names = 'Dv chiv'
    function = 'Dv*chiv'
    derivative_order = 2
    outputs = exodus
  [../]
  [./Mobility_g]
    type = DerivativeParsedMaterial
    f_name = Dchig
    material_property_names = 'Dg chig'
    function = 'Dg*chig'
    derivative_order = 2
    outputs = exodus
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
    args = 'XolotlXeRate'  # XolotlXeRate is in Xe/(nm^3 * s) & Va is in Xe/nm^3
    # function = 'XolotlXeRate * hm'
    function = 'XolotlXeRate'
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
    constant_expressions = '2.35e-9'  # in atoms/(nm^3 * s)
    function = 's0 * hm'
    outputs = exodus
  [../]
  [./VacRate_ref]
    type = ParsedMaterial
    f_name = VacRate0
    material_property_names = 'YXe XeRate0'
    function = 'XeRate0 / YXe'
    outputs = exodus
  [../]
  [./cg]
    type = ParsedMaterial
    f_name = cg_from_rhog
    material_property_names = 'Va rhogbub rhogmatrix hm hb'
    function = 'hb*Va*rhogbub + hm*Va*rhogmatrix'
    outputs = exodus
  [../]
  [./gas_conc]
    type = ParsedMaterial
    f_name = gas_conc
    args = 'cg'
    function = '(cg)/(1200*1200)'
    outputs = exodus
  [../]
  [./cv]
    type = ParsedMaterial
    f_name = cv_from_rhov
    material_property_names = 'Va rhovbub rhovmatrix hm hb'
    function = 'hb*Va*rhovbub + hm*Va*rhovmatrix'
    outputs = exodus
  [../]
  [./vac_conc]
    type = ParsedMaterial
    f_name = vac_conc
    args = 'cv'
    function = '(cv)/(1200*1200)'
    outputs = exodus
  [../]
[]

[Postprocessors]
  [./gas_concentration]
    type = ElementIntegralMaterialProperty
    mat_prop = gas_conc
    outputs = csv
  [../]
  [./vacancy_concentration]
    type = ElementIntegralMaterialProperty
    mat_prop = vac_conc
    outputs = csv
  [../]
  [./dt]
    type = TimestepSize
  [../]
  [./elapsed]
    type = PerfGraphData
    section_name = "Root"
    data_type = total
  [../]
  [./num_nonlinear_residuals]
    type = NumNonlinearIterations
  [../]
  [./num_linear_residuals]
    type = NumLinearIterations
  [../]
  [./feature_counter]
    type = FeatureFloodCount
    variable = bubble
    compute_var_to_feature_map = true
    execute_on = 'initial timestep_end'
  [../]
  [./Volume]
    type = VolumePostprocessor
    execute_on = 'initial'
  [../]
  [./volume_fraction]
    type = FeatureVolumeFraction
    mesh_volume = Volume
    feature_volumes = feature_volumes
    execute_on = 'initial timestep_end'
  [../]
[]

[VectorPostprocessors]
  [./feature_volumes]
    type = FeatureVolumeVectorPostprocessor
    flood_counter = feature_counter
    execute_on = 'initial timestep_end'
    outputs = csv
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  scheme = bdf2
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -sub_pc_type -pc_asm_overlap -pc_factor_levels'
  petsc_options_value = 'asm      lu              1             2'
  nl_max_its = 15
  l_max_its = 15
  l_tol = 1.0e-3
  # nl_max_its = 20
  # l_max_its = 40
  # l_tol = 1e-04
  nl_rel_tol = 1.0e-8
  end_time = 1e8
  nl_abs_tol = 1e-9
  [./TimeStepper]
    type = IterationAdaptiveDT
    optimal_iterations = 5
    growth_factor = 1.2
    cutback_factor = 0.8
    # dt = 0.5
    dt = 1
    # adapt_log = true
  [../]
[]

[Outputs]
  [./exodus]
    type = Exodus
  [../]
  perf_graph = true
[]
