# Length unit: nm
# Time unit: s
# Energy unit: eV
# Energy scale: 64 GPa = 400 eV/nm^3

[Mesh]
  #[gmg]
  #  type = DistributedRectilinearMeshGenerator
  #  dim = 2
  #  nx = 50
  #  ny = 50
  #  #nz = 2
  #  xmin = 0
  #  xmax = 20000
  #  ymin = 0
  #  ymax = 20000
  #  #zmin = 0
  #  #zmax = 400
  #  uniform_refine = 2
  #[]
  type = GeneratedMesh
  dim = 3
  nx = 50
  ny = 50
  nz = 2
  xmin = 0
  xmax = 20000
  ymin = 0
  ymax = 20000
  zmin = 0
  zmax = 200
  uniform_refine = 2
  #parallel_type = DISTRIBUTED
[]

[GlobalParams]
  op_num = 5
  grain_num = 5
  var_name_base = etam
  numbub = 2
  bubspac = 2500
  radius = 733
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

  #For use of Grain Tracker
  [./unique_grains]
    order = FIRST
    family = MONOMIAL
  [../]
  [./var_indices]
    order = FIRST
    family = MONOMIAL
  [../]

  [./halos]
    order = FIRST
    family = MONOMIAL
  [../]
  [./halo0] #We need the 'op_num' number of halos here; so we need 8 halo variables
    order = FIRST
    family = MONOMIAL
  [../]
  [./halo1]
    order = FIRST
    family = MONOMIAL
  [../]
  [./halo2]
    order = FIRST
    family = MONOMIAL
  [../]
  [./halo3]
    order = FIRST
    family = MONOMIAL
  [../]
  [./halo4]
    order = FIRST
    family = MONOMIAL
  [../]
#  [./halo5]
#    order = FIRST
#    family = MONOMIAL
#  [../]
#  [./halo6]
#    order = FIRST
#    family = MONOMIAL
#  [../]
#  [./halo7]
#    order = FIRST
#    family = MONOMIAL
#  [../]
#  [./halo8]
#    order = FIRST
#    family = MONOMIAL
#  [../]
#  [./halo9]
#    order = FIRST
#    family = MONOMIAL
#  [../]
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

  #For use of Grain Tracker
  [./BndsCalc]
    type = BndsCalcAux
    variable = bnds
    execute_on = 'initial timestep_end'
  [../]
  [./unique_grains]
    type = FeatureFloodCountAux
    variable = unique_grains
    flood_counter = grain_tracker
    field_display = UNIQUE_REGION
  [../]
  [./var_indices]
    type = FeatureFloodCountAux
    variable = var_indices
    flood_counter = grain_tracker
    field_display = VARIABLE_COLORING
  [../]
  [./halo0]
    type = FeatureFloodCountAux
    variable = halo0
    map_index = 0
    field_display = HALOS
    flood_counter = grain_tracker
  [../]
  [./halo1]
    type = FeatureFloodCountAux
    variable = halo1
    map_index = 1
    field_display = HALOS
    flood_counter = grain_tracker
  [../]
  [./halo2]
    type = FeatureFloodCountAux
    variable = halo2
    map_index = 2
    field_display = HALOS
    flood_counter = grain_tracker
  [../]
  [./halo3]
    type = FeatureFloodCountAux
    variable = halo3
    map_index = 3
    field_display = HALOS
    flood_counter = grain_tracker
  [../]
  [./halo4]
    type = FeatureFloodCountAux
    variable = halo4
    map_index = 4
    field_display = HALOS
    flood_counter = grain_tracker
  [../]
#  [./halo5]
#    type = FeatureFloodCountAux
#    variable = halo5
#    map_index = 5
#    field_display = HALOS
#    flood_counter = grain_tracker
#  [../]
#  [./halo6]
#    type = FeatureFloodCountAux
#    variable = halo6
#    map_index = 6
#    field_display = HALOS
#    flood_counter = grain_tracker
#  [../]
#  [./halo7]
#    type = FeatureFloodCountAux
#    variable = halo7
#    map_index = 7
#    field_display = HALOS
#    flood_counter = grain_tracker
#  [../]
#  [./halo8]
#    type = FeatureFloodCountAux
#    variable = halo8
#    map_index = 8
#    field_display = HALOS
#    flood_counter = grain_tracker
#  [../]
#  [./halo9]
#    type = FeatureFloodCountAux
#    variable = halo9
#    map_index = 9
#    field_display = HALOS
#    flood_counter = grain_tracker
#  [../]
[]

[ICs]
  # [./bnds]
  #   type = ConstantIC
  #   variable = bnds
  #   value = 1
  # [../]
  [./PolycrystalICs]
    [./PolycrystalVoronoiVoidIC]
      invalue = 1.0
      outvalue = 0.0
      polycrystal_ic_uo = voronoi
    [../]
  [../]
  [./bubble_IC]
    variable = etab0
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

  #[./etab0_IC]
  #  type = SmoothCircleIC
  #  variable = etab0
  #  invalue = 1
  #  outvalue = 0
  #  x1 = 4500
  #  y1 = 4500
  #  radius = 733
  #  int_width = 480
  #[../]
  #[./etam0_IC]
  #  type = SmoothCircleIC
  #  variable = etam0
  #  invalue = 0
  #  outvalue = 1
  #  x1 = 4500
  #  y1 = 4500
  #  radius = 733
  #  int_width = 480
  #[../]
  #[./IC_wv]
  #  type = ConstantIC
  #  variable = wv
  #  value = 0
  #[../]
  #[./IC_wg]
  #  type = ConstantIC
  #  variable = wg
  #  value = 0
  #[../]
[]



[BCs]
  [./Periodic]
    [./All]
      auto_direction = 'x y z'
    [../]
  [../]

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

[Modules]
  [./PhaseField]
    [./GrandPotential]
      switching_function_names = 'hb hm'
      anisotropic = 'false false'

      chemical_potentials = 'wv wg'
      mobilities = 'Dchiv Dchig'
      susceptibilities = 'chiv chig'
      free_energies_w = 'rhovbub rhovmatrix rhogbub rhogmatrix'

      # chemical_potentials = 'wg'
      # mobilities = 'Dchig'
      # susceptibilities = 'chig'
      # free_energies_w = 'rhogbub rhogmatrix'

      # gamma_gr = gamma
      gamma_gr = gmm
      mobility_name_gr = L_op
      kappa_gr = kappa
      free_energies_gr = 'omegab omegam'

      additional_ops = 'etab0'
      gamma_grxop = gmb
      mobility_name_op = L_op
      kappa_op = kappa
      free_energies_op = 'omegab omegam'
    [../]
  [../]
[]

[Kernels]


  #[./Source_v]
  #  type = MaskedBodyForce
  #  variable = wv
  #  value = 1
  #  mask = VacRate0
  #[../]
  [./Source_v]
    type = MaskedBodyForce
    variable = wv
    value = 1
    mask = VacRate
  [../]

  #[./Source_g]
  #  type = MaskedBodyForce
  #  variable = wg
  #  value = 1
  #  mask = XeRate0
  #[../]
  [./Source_g]
    type = MaskedBodyForce
    variable = wg
    value = 1 # for unit conversion between PF app and Xolotl
    mask = XeRate
  [../]
[]

[Materials]
  [./hb]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = hb
    #all_etas = 'etab0 etam0 etam1 etam2 etam3 etam4 etam5 etam6 etam7 etam8 etam9 etam10 etam11 etam12 etam13 etam14 etam15 etam16 etam17 etam18 etam19 etam20 etam21 etam22 etam23 etam24'
    #all_etas = 'etab0 etam0 etam1 etam2 etam3 etam4 etam5 etam6 etam7 etam8 etam9'
    all_etas = 'etab0 etam0 etam1 etam2 etam3 etam4'
    phase_etas = 'etab0'
    #outputs = exodus
  [../]
  [./hm]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = hm
    #all_etas = 'etab0 etam0 etam1 etam2 etam3 etam4 etam5 etam6 etam7 etam8 etam9'
    all_etas = 'etab0 etam0 etam1 etam2 etam3 etam4'
    phase_etas = 'etam0 etam1 etam2 etam3 etam4'
    #all_etas = 'etab0 etam0 etam1 etam2 etam3 etam4 etam5 etam6 etam7 etam8 etam9 etam10 etam11 etam12 etam13 etam14 etam15 etam16 etam17 etam18 etam19 etam20 etam21 etam22 etam23 etam24'
    #phase_etas = 'etam0 etam1 etam2 etam3 etam4 etam5 etam6 etam7 etam8 etam9 etam10 etam11 etam12 etam13 etam14 etam15 etam16 etam17 etam18 etam19 etam20 etam21 etam22 etam23 etam24'
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
    prop_names =  'kappa     mu         L      Dm     Db      Va      cvbubeq  cgbubeq gmb    gmm T     YXe'
    prop_values = '0.84368e1 0.00293e-1 0.0049 2.3398 2.3398  0.0409  0.546    0.454   0.922  1.5 1800  0.2156'
  [../]
  [./relaxation_parameter]
    type = GenericConstantMaterial
    prop_names = 'rlx_factor'
    prop_values = '1000'
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
    #function = '7.516' # scaled by 64 GPa
    function = '0.11' # in eV/nm^3, decreased
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
    function = '1.406' # scaled by 64 GPa
    #function = '1.406e-2' # in eV/nm^3, decreased
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
    material_property_names = 'Db chiv rlx_factor'
    args = 'time'
    function = 'if(time < 0, rlx_factor*Db*chiv, Db*chiv)'
    #function = 'Db*chiv'
    derivative_order = 2
    # outputs = exodus
  [../]
  [./Mobility_g]
    type = DerivativeParsedMaterial
    f_name = Dchig
    material_property_names = 'Dm chig rlx_factor'
    args = 'time'
    function = 'if(time < 0, rlx_factor*Dm*chig, Dm*chig)'
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
    constant_expressions = '2.35e-9'  # in atoms/(nm^3 * s)
    args = 'time'
    function = 'if(time < 0, 0, s0 * hm)'
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
  [./L_op]
    type = ParsedMaterial
    f_name = L_op
    material_property_names = 'L rlx_factor'
    args = 'time'
    function = 'if(time < 0, rlx_factor*L, L)'
    outputs = exodus
  [../]
[]

[UserObjects]
  [./voronoi]
    type = PolycrystalVoronoi
    rand_seed = 10
    # int_width = 480
    coloring_algorithm = jp
    output_adjacency_matrix = false
  [../]

  [./grain_tracker]
    type = GrainTracker
    threshold = 0.5
    connecting_threshold = 0.5
    compute_halo_maps = true
    remap_grains = true
  [../]
[]

#[Adaptivity]
#  marker = errorfrac
#  max_h_level = 2
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
  [./numgrain]
    type = ElementExtremeValue
    variable = unique_grains
  [../]

  [./porosity]
    type = ElementAverageValue
    variable = etab0
  [../]

  [./gas_conc_interg]
    type = ElementAverageValue
    variable = cg
  [../]

  [./gas_conc_intrag]
    type = ElementAverageValue
    variable = XolotlXeMono
  [../]

  [./porefrac_intrag]
    type = ElementAverageValue
    variable = XolotlVolumeFraction
  [../]

[] #End of Postprocessors block

[Adaptivity]
  [./Indicators]
    [./bnds_indicator]
      type = GradientJumpIndicator
      variable = bnds
    [../]
  [../]
  [./Markers]
    [./error_marker]
      type = ErrorFractionMarker
      coarsen = 0.1
      indicator = bnds_indicator
      refine = 0.7
    [../]
    [./gradbnds]
      type = ValueThresholdMarker
      variable = bnds
      coarsen = 0.1
      refine = 0.7
    [../]
    [./combo]
      type = ComboMarker
      markers = 'error_marker'
    [../]
  [../]
  max_h_level = 2
  marker = combo
[]

[Preconditioning]
  [./SMP]
    type = SMP
    coupled_groups = 'etab0,wg etab0,wv'
  [../]
[]

[Executioner]
  # Preconditioned JFNK (default)
  type = Transient
  nl_max_its = 15
  scheme = bdf2
  #solve_type = NEWTON
  solve_type = PJFNK
  #petsc_options_iname = '-pc_type -sub_pc_type'
  #petsc_options_value = 'asm      lu'
  # Use with solve_type = NEWTON in Executioner block
  petsc_options_iname = '-pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = 'bjacobi  gmres     30'  # default is 30, the higher the higher resolution but the slower

  l_max_its = 15
  l_tol = 1.0e-5
  nl_rel_tol = 1.0e-8
  start_time = 0
  #num_steps = 1000
  #end_time = 1.2e8
  end_time = 1.0e4
  nl_abs_tol = 1e-10
  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.1
    growth_factor = 1.2
    cutback_factor = 0.6
    # adapt_log = true
  [../]
[]

[Outputs]
  [./exodus]
    type = Exodus
    #interval = 10
    interval = 1
    #sync_times = '0 1.2e6'
    sync_times = '0 1.0e4'
  [../]
  # checkpoint = true
  csv = true
  perf_graph = true
[]

[MultiApps]
  [./sub_app]
    type = TransientMultiApp
    positions = '0 0 0'
    input_files = 'xolotl_subapp.i'
    app_type = coupling_xolotlApp
    execute_on = TIMESTEP_END
    library_path = 'lib'
[../]
[]

[Transfers]
  [./fromsubrate]
    type = MultiAppMeshFunctionTransfer
    direction = from_multiapp
    multi_app = sub_app
    source_variable = Auxv
    variable = XolotlXeRate
    execute_on = SAME_AS_MULTIAPP
  [../]
  #[./fromsubmono]
  #  type = MultiAppMeshFunctionTransfer
  #  direction = from_multiapp
  #  multi_app = sub_app
  #  source_variable = AuxMono
  #  variable = XolotlXeMono
  #  execute_on = SAME_AS_MULTIAPP
  #[../]
  #[./fromsubfrac]
  #  type = MultiAppMeshFunctionTransfer
  #  direction = from_multiapp
  #  multi_app = sub_app
  #  source_variable = AuxFrac
  #  variable = XolotlVolumeFraction
  #  execute_on = SAME_AS_MULTIAPP
  #[../]
  [./tosub]
    type = MultiAppMeshFunctionTransfer
    direction = to_multiapp
    multi_app = sub_app
    source_variable = bnds
    variable = AuxGB
    #execute_on = TIMESTEP_BEGIN
    execute_on = SAME_AS_MULTIAPP
  [../]
[]
