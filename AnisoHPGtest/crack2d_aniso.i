[GlobalParams]
  displacements = 'disp_x disp_y'
[]

# [Mesh]
#   type = FileMesh
#   file = crack_mesh.e
#   uniform_refine = 3
# []
# [Mesh]
#   type = GeneratedMesh
#   dim = 2
#   nx = 200
#   ny = 200
#   ymax = 1
#   xmax = 1
# []
[Mesh]
  type = FileMesh
  file = crack_mesh.e
  # uniform_refine = 2
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./c]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./dcx]
    order = FIRST
    family = MONOMIAL
  [../]
  [./dcy]
    order = FIRST
    family = MONOMIAL
  [../]
[]


[Modules]
  [./TensorMechanics]
    [./Master]
      [./All]
        add_variables = true
        strain = SMALL
        additional_generate_output = 'strain_yy stress_yy stress_xx'
        planar_formulation = PLANE_STRAIN
      [../]
    [../]
  [../]
  # [./PhaseField]
  #   [./Nonconserved]
  #     [./c]
  #       free_energy = F
  #       kappa = kappa_op
  #       mobility = L
  #     [../]
  #   [../]
  # [../]
[]

[Kernels]
  [./pfbulk]
    type = AllenCahn
    variable = c
    mob_name = M
    f_name = F
  [../]
  # [./TensorMechanics]
  #   displacements = 'disp_x disp_y'
  # [../]
  [./solid_x]
    type = PhaseFieldFractureMechanicsOffDiag
    variable = disp_x
    component = 0
    c = c
  [../]
  [./solid_y]
    type = PhaseFieldFractureMechanicsOffDiag
    variable = disp_y
    component = 1
    c = c
  [../]
  [./dcdt]
    type = CoefTimeDerivative
    variable = c
    Coefficient = 1e-6
  [../]
  [./InterfacialE]
    type = AnisotropicGradEnergy
    variable = c
    mob_name = M
    kappa_name = Wsq_aniso
    gradient_component_names = 'dcx dcy'
  [../]
  # [./acint]
  #   type = ACInterface
  #   variable = c
  #   mob_name = M
  #   kappa_name = kappa_c
  # [../]
[]

[AuxKernels]
  [./stress_yy]
    type = RankTwoAux
    variable = stress_yy
    rank_two_tensor = stress
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  [../]
  [./get_dcx]
    type = VariableGradientComponent
    variable = dcx
    gradient_variable = c
    component = x
  [../]
  [./get_dcy]
    type = VariableGradientComponent
    variable = dcy
    gradient_variable = c
    component = y
  [../]
[]

[BCs]
  [./ydisp]
    type = FunctionPresetBC
    variable = disp_y
    boundary = 2
    function = 't'
  [../]
  [./yfix]
    type = PresetBC
    variable = disp_y
    boundary = '1'
    value = 0
  [../]
  [./xfix]
    type = PresetBC
    variable = disp_x
    boundary = 1
    value = 0
  [../]
[]

[Materials]
  [./pfbulkmat]
    type = GenericConstantMaterial
    prop_names = 'gc_prop l visco M delta'
    prop_values = '1e-3 5e-3 1e-4 1.0 0.4'
  [../]
  [./sin2theta]
    type = DerivativeParsedMaterial
    f_name = sin2theta
    args = 'dcx dcy'
    function = '2.0*dcx*dcy/(dcx^2 + dcy^2)'
    derivative_order = 2
  [../]
  [./cos2theta]
    type = DerivativeParsedMaterial
    f_name = cos2theta
    args = 'dcx dcy'
    function = '(dcx^2-dcy^2)/(dcx^2 + dcy^2)'
  [../]
  [./mat]
    type = DerivativeParsedMaterial
    f_name = Wsq_aniso
    material_property_names = 'gc_prop delta l cos2theta(dcx,dcy) sin2theta(dcx,dcy)'
    args = 'dcx dcy'
    function = 'if(dcx^2 + dcy^2 > 1e-10, gc_prop*l*(1 + delta * (cos2theta*0.5 + sin2theta*sqrt(3)/2))^2, gc_prop*l)'
   # constant_names       = 'sin2theta0  cos2theta0'
   # constant_expressions = '0.8660254 0.5'
    derivative_order = 2
  [../]
  [./damage_stress]
    type = ComputeLinearElasticPFFractureStress
    c = c
    E_name = 'elastic_energy'
    D_name = 'degradation'
    F_name = 'local_fracture_energy'
    decomposition_type = stress_spectral
    use_current_history_variable = true
  [../]
  [./degradation]
    type = DerivativeParsedMaterial
    f_name = degradation
    args = 'c'
    function = '(1.0-c)^2*(1.0 - eta) + eta'
    constant_names       = 'eta'
    constant_expressions = '1.0e-6'
    derivative_order = 2
  [../]
  [./local_fracture_energy]
    type = DerivativeParsedMaterial
    f_name = local_fracture_energy
    args = 'c'
    material_property_names = 'gc_prop l'
    function = 'c^2 * gc_prop / 2 / l'
    derivative_order = 2
  [../]
  [./fracture_driving_energy]
    type = DerivativeSumMaterial
    args = c
    sum_materials = 'elastic_energy local_fracture_energy'
    derivative_order = 2
    f_name = F
  [../]
  # [./L]
  #   type = ParsedMaterial
  #   f_name = L
  #   material_property_names = 'gc_prop visco'
  #   function = '1.0/gc_prop/visco'
  # [../]
  # [./kappa_c]
  #   type = ParsedMaterial
  #   f_name = kappa_c
  #   material_property_names = 'gc_prop l'
  #   function = 'gc_prop*l'
  # [../]
  # [./elasticity_tensor]
  #   type = ComputeElasticityTensor
  #   C_ijkl = '1.27e2 0.708e2 0.708e2 1.27e2 0.708e2 1.27e2 0.7355e2 0.7355e2 0.7355e2'
  #   fill_method = symmetric9
  #   euler_angle_1 = 0.0
  #   euler_angle_2 = 0.0
  #   euler_angle_3 = 0.0
  # [../]
  [./elasticity_tensor]
    type = ComputeElasticityTensor
    C_ijkl = '120.0 80.0'
    fill_method = symmetric_isotropic
  [../]
  # [./strain]
  #   type = ComputeSmallStrain
  # [../]
[]

[Preconditioning]
  active = 'smp'
  [./smp]
    type = SMP
    full = true
  [../]
[]


[Postprocessors]
  [./disp_y_top]
    type = SideAverageValue
    variable = disp_y
    boundary = 2
  [../]
  [./stressyy]
    type = ElementAverageValue
    variable = stress_yy
  [../]
  [./dintegral]
    type = ElementIntegralVariablePostprocessor
    variable = c
    execute_on = 'initial timestep_end'
  [../]
[]

[Executioner]
  type = Transient

  solve_type = PJFNK

  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu superlu_dist'

  nl_rel_tol = 1e-8
  l_max_its = 50
  nl_max_its = 100

  dt = 3e-6
  dtmin = 1e-10
  start_time = 0.0
  end_time = 0.015
  [Adaptivity]
    initial_adaptivity = 4
    max_h_level = 4
    refine_fraction = 0.95
    coarsen_fraction = 0.05
  []
[]

[Outputs]
  file_base = R30d04
  interval = 20
  exodus = true
  csv = true
  gnuplot = true
[]
