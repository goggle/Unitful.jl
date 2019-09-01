# Default dimensions and their abbreviations.
# The dimension symbols are generated by tab completion: \bfL is 𝐋, etc.
# At the expense of easy typing, this gives a visual cue to distinguish
# dimensions from units, and also helps prevent common namespace collisions.
@dimension 𝐋 "𝐋" Length
@dimension 𝐌 "𝐌" Mass
@dimension 𝐓 "𝐓" Time
@dimension 𝐈 "𝐈" Current
@dimension 𝚯 "𝚯" Temperature    # This one is \bfTheta
@dimension 𝐉 "𝐉" Luminosity
@dimension 𝐍 "𝐍" Amount
const RelativeScaleTemperature = Quantity{T, 𝚯, <:AffineUnits} where T
const AbsoluteScaleTemperature = Quantity{T, 𝚯, <:ScalarUnits} where T

# Define derived dimensions.
@derived_dimension Area                     𝐋^2
@derived_dimension Volume                   𝐋^3
@derived_dimension Density                  𝐌/𝐋^3
@derived_dimension Frequency                inv(𝐓)
@derived_dimension Velocity                 𝐋/𝐓
@derived_dimension Acceleration             𝐋/𝐓^2
@derived_dimension Force                    𝐌*𝐋/𝐓^2
@derived_dimension Pressure                 𝐌*𝐋^-1*𝐓^-2
@derived_dimension Energy                   𝐌*𝐋^2/𝐓^2
@derived_dimension Momentum                 𝐌*𝐋/𝐓
@derived_dimension Power                    𝐋^2*𝐌*𝐓^-3
@derived_dimension Charge                   𝐈*𝐓
@derived_dimension Voltage                  𝐈^-1*𝐋^2*𝐌*𝐓^-3
@derived_dimension ElectricalResistance     𝐈^-2*𝐋^2*𝐌*𝐓^-3
@derived_dimension ElectricalResistivity    𝐈^-2*𝐋^3*𝐌*𝐓^-3
@derived_dimension ElectricalConductance    𝐈^2*𝐋^-2*𝐌^-1*𝐓^3
@derived_dimension ElectricalConductivity   𝐈^2*𝐋^-3*𝐌^-1*𝐓^3
@derived_dimension Capacitance              𝐈^2*𝐋^-2*𝐌^-1*𝐓^4
@derived_dimension Inductance               𝐈^-2*𝐋^2*𝐌*𝐓^-2
@derived_dimension MagneticFlux             𝐈^-1*𝐋^2*𝐌*𝐓^-2
@derived_dimension DField                   𝐈*𝐓/𝐋^2
@derived_dimension EField                   𝐋*𝐌*𝐓^-3*𝐈^-1
@derived_dimension HField                   𝐈/𝐋
@derived_dimension BField                   𝐈^-1*𝐌*𝐓^-2
@derived_dimension Action                   𝐋^2*𝐌*𝐓^-1
@derived_dimension DynamicViscosity         𝐌*𝐋^-1*𝐓^-1
@derived_dimension KinematicViscosity       𝐋^2*𝐓^-1
@derived_dimension Wavenumber               inv(𝐋)
@derived_dimension ElectricDipoleMoment     𝐋*𝐓*𝐈
@derived_dimension ElectricQuadrupoleMoment 𝐋^2*𝐓*𝐈
@derived_dimension MagneticDipoleMoment     𝐋^2*𝐈
@derived_dimension Molarity                 𝐍/𝐋^3
@derived_dimension Molality                 𝐍/𝐌

# Define base units. This is not to imply g is the base SI unit instead of kg.
# See the documentation for further details.
# #key:   Symbol  Display  Name      Dimension   Prefixes?
@refunit  m       "m"      Meter     𝐋           true
@refunit  s       "s"      Second    𝐓           true
@refunit  A       "A"      Ampere    𝐈            true
@refunit  K       "K"      Kelvin    𝚯           true
@refunit  cd      "cd"     Candela   𝐉            true
@refunit  g       "g"      Gram      𝐌           true
@refunit  mol     "mol"    Mole      𝐍           true

# Angles and solid angles
@unit sr      "sr"      Steradian   1                       true
@unit rad     "rad"     Radian      1                       true
@unit °       "°"       Degree      pi/180                  false
# For numerical accuracy, specific to the degree
import Base: sind, cosd, tand, secd, cscd, cotd
for (_x,_y) in ((:sin,:sind), (:cos,:cosd), (:tan,:tand),
        (:sec,:secd), (:csc,:cscd), (:cot,:cotd))
    @eval ($_x)(x::Quantity{T, NoDims, typeof(°)}) where {T} = ($_y)(ustrip(x))
    @eval ($_y)(x::Quantity{T, NoDims, typeof(°)}) where {T} = ($_y)(ustrip(x))
end

# SI and related units
@unit Hz     "Hz"       Hertz       1/s                     true
@unit N      "N"        Newton      1kg*m/s^2               true
@unit Pa     "Pa"       Pascal      1N/m^2                  true
@unit J      "J"        Joule       1N*m                    true
@unit W      "W"        Watt        1J/s                    true
@unit C      "C"        Coulomb     1A*s                    true
@unit V      "V"        Volt        1W/A                    true
@unit Ω      "Ω"        Ohm         1V/A                    true
@unit S      "S"        Siemens     1/Ω                     true
@unit F      "F"        Farad       1s^4*A^2/(kg*m^2)       true
@unit H      "H"        Henry       1J/(A^2)                true
@unit T      "T"        Tesla       1kg/(A*s^2)             true
@unit Wb     "Wb"       Weber       1kg*m^2/(A*s^2)         true
@unit lm     "lm"       Lumen       1cd*sr                  true
@unit lx     "lx"       Lux         1lm/m^2                 true
@unit Bq     "Bq"       Becquerel   1/s                     true
@unit Gy     "Gy"       Gray        1J/kg                   true
@unit Sv     "Sv"       Sievert     1J/kg                   true
@unit kat    "kat"      Katal       1mol/s                  true
@unit percent "%"       Percent     1//100                  false
@unit permille "‰"      Permille    1//1000                 false

# Temperature
@affineunit °C "°C"     (27315//100)K

# Common units of time
@unit minute "minute"   Minute                60s           false
@unit hr     "hr"       Hour                  3600s         false
@unit d      "d"        Day                   86400s        false
@unit wk     "wk"       Week                  604800s       false
@unit rps    "rps"      RevolutionsPerSecond  1/s           false
@unit rpm    "rpm"      RevolutionsPerMinute  1/minute      false

# Area
# The hectare is used more frequently than any other power-of-ten of an are.
@unit a      "a"        Are         100m^2                  false
const ha = Unitful.FreeUnits{(Unitful.Unit{:Are, 𝐋^2}(2, 1//1),), 𝐋^2}()
@unit b      "b"        Barn        100fm^2                 true

# Volume
# `l` is also an acceptable symbol for liters
@unit L      "L"        Liter       m^3//1000                true
for p in (:y, :z, :a, :f, :p, :n, :μ, :µ, :m, :c, :d,
    Symbol(""), :da, :h, :k, :M, :G, :T, :P, :E, :Z, :Y)
    Core.eval(Unitful, :(const $(Symbol(p,:l)) = $(Symbol(p,:L))))
end

# Molarity
@unit M      "M"        Molar       1mol/L                  true

# Energy
const q = 1.602_176_634e-19*C        # CODATA 2018; `e` means 2.718...
@unit eV     "eV"       eV          q*V                     true

# For convenience
@unit Hz2π   "Hz2π"     AngHertz    2π/s                    true
@unit bar    "bar"      Bar         100000Pa                true
@unit atm    "atm"      Atmosphere  101325Pa                false
@unit Torr   "Torr"     Torr        101325Pa//760           true

# Constants (2018 CODATA values)        (uncertainties in final digits)
const c0 = 299_792_458*m/s              # exact
@unit c      "c"        SpeedOfLight 1c0                    false
const μ0 = 4π*(1//10)^7*H/m         # exact (but gets promoted to Float64...)
const µ0 = μ0                       # magnetic constant
const ɛ0 = 1/(μ0*c^2)               # exact, electric constant; changes here may affect
const ϵ0 = ɛ0                           # test of issue 79.
const Z0 = μ0*c                     # exact, impedance of free space
const G  = 6.674_30e-11*m^3/kg/s^2  # (15) gravitational constant
const gn = 9.80665*m/s^2            # exact, standard acceleration of gravity
const h  = 6.626_070_15e-34*J*s     # exact, Planck constant
const ħ  = h/2π                     # hbar
const Φ0 = h/(2q)                   # Superconducting magnetic flux quantum
const me = 9.109_383_7015e-31*kg    # (28) electron rest mass
const mn = 1.674_927_498_04e-27*kg  # (95) neutron rest mass
const mp = 1.672_621_923_69e-27*kg  # (51) proton rest mass
const μB = q*ħ/(2*me)               # Bohr magneton
const µB = μB
const Na = 6.022_140_76e23/mol      # exact, Avogadro constant
const k  = 1.380_649e-23*(J/K)      # exact, Boltzmann constant
const R  = Na*k                     # molar gas constant
const σ  = π^2*k^4/(60*ħ^3*c^2)     # Stefan-Boltzmann constant
const R∞ = 10_973_731.568_160/m     # (21) Rydberg constant
@unit u      "u" UnifiedAtomicMassUnit 1.660_539_066_60e-27*kg false # (50)

# Acceleration
@unit ge     "ge"       EarthGravity gn                     false


# CGS units
@unit Gal    "Gal"      Gal         1cm/s^2                 true
@unit dyn    "dyn"      Dyne        1g*cm/s^2               true
@unit erg    "erg"      Erg         1g*cm^2/s^2             true
@unit Ba     "Ba"       Barye       1g/cm/s^2               true
@unit P      "P"        Poise       1g/cm/s                 true
@unit St     "St"       Stokes      1cm^2/s                 true


#########
# Shared Imperial / US customary units

# Length
#key: Symbol    Display    Name                 Equivalent to           10^n prefixes?
@unit inch      "inch"     Inch                 (254//10000)*m          false
@unit mil       "mil"      Mil                  (1//1000)*inch          false
@unit ft        "ft"       Foot                 12inch                  false
@unit yd        "yd"       Yard                 3ft                     false
@unit mi        "mi"       Mile                 1760yd                  false

# Area
@unit ac        "ac"       Acre                 (316160658//78125)*m^2  false

# Temperatures
@unit Ra        "Ra"      Rankine               (5//9)*K                false
@affineunit °F  "°F"      (45967//100)Ra

# Masses
@unit lb        "lb"       Pound                0.45359237kg            false # is exact
@unit oz        "oz"       Ounce                lb//16                  false
@unit slug      "slug"     Slug                 1lb*ge*s^2/ft           false
@unit dr        "dr"       Dram                 oz//16                  false
@unit gr        "gr"       Grain                (32//875)*dr            false

# Force
@unit lbf       "lbf"      PoundsForce          1lb*ge                  false

# Energy
# Use ISO 31-4 for BTU definition
@unit cal       "cal"      Calorie              4.184J                  true
@unit btu       "btu"      BritishThermalUnit   1055.06J                false

# Pressure
@unit psi       "psi"      PoundsPerSquareInch  1lbf/inch^2             false

#########
# Logarithmic scales and units

@logscale dB    "dB"       Decibel      10      10      false
@logscale B     "B"        Bel          10      1       false
@logscale Np    "Np"       Neper        ℯ       1//2    true
@logscale cNp   "cNp"      Centineper   ℯ       50      true

@logunit  dBHz  "dB-Hz"    Decibel      1Hz
@logunit  dBm   "dBm"      Decibel      1mW
@logunit  dBV   "dBV"      Decibel      1V
@logunit  dBu   "dBu"      Decibel      sqrt(0.6)V
@logunit  dBμV  "dBμV"     Decibel      1μV
@logunit  dBSPL "dBSPL"    Decibel      20μPa
@logunit  dBFS  "dBFS"     Decibel      RootPowerRatio(1)
@logunit  dBΩ   "dBΩ"      Decibel      1Ω
@logunit  dBS   "dBS"      Decibel      1S

const dBµV = dBμV   # different character encoding of μ

# TODO: some more dimensions?
isrootpower_dim(::typeof(dimension(W)))         = false
isrootpower_dim(::typeof(dimension(V)))         = true
isrootpower_dim(::typeof(dimension(A)))         = true
isrootpower_dim(::typeof(dimension(Pa)))        = true
isrootpower_dim(::typeof(dimension(W/m^2/Hz)))  = false     # spectral flux dens.
isrootpower_dim(::typeof(dimension(W/m^2)))     = false     # intensity
isrootpower_dim(::typeof(dimension(W/m^2/m)))   = false
isrootpower_dim(::typeof(𝐋^3))                  = false     # reflectivity
isrootpower_dim(::typeof(dimension(Ω)))         = true
isrootpower_dim(::typeof(dimension(S)))         = true
isrootpower_dim(::typeof(dimension(Hz)))        = false
isrootpower_dim(::typeof(dimension(J)))         = false

#########

# `using Unitful.DefaultSymbols` will bring the following into the calling namespace:
# - Dimensions 𝐋,𝐌,𝐓,𝐈,𝚯,𝐉,𝐍
# - Base and derived SI units, with SI prefixes
#   - Candela conflicts with `Base.cd` so it is not brought in (issue #102)
# - Degrees: °

# The following line has two different character encodings for μ
const si_prefixes = (:y, :z, :a, :f, :p, :n, :μ, :µ, :m, :c, :d,
    Symbol(""), :da, :h, :k, :M, :G, :T, :P, :E, :Z, :Y)

const si_no_prefix = (:m, :s, :A, :K, :g, :mol, :rad, :sr, :Hz, :N, :Pa, #:cd,
    :J, :W, :C, :V, :F, :Ω, :S, :Wb, :T, :H, :lm, :lx, :Bq, :Gy, :Sv, :kat)

baremodule DefaultSymbols
    import Unitful

    for u in (:𝐋,:𝐌,:𝐓,:𝐈,:𝚯,:𝐉,:𝐍)
        Core.eval(DefaultSymbols, Expr(:import, Expr(:(.), :Unitful, u)))
        Core.eval(DefaultSymbols, Expr(:export, u))
    end

    for p in Unitful.si_prefixes
        for u in Unitful.si_no_prefix
            Core.eval(DefaultSymbols, Expr(:import, Expr(:(.), :Unitful, Symbol(p,u))))
            Core.eval(DefaultSymbols, Expr(:export, Symbol(p,u)))
        end
    end

    Core.eval(DefaultSymbols, Expr(:import, Expr(:(.), :Unitful, :°C)))
    Core.eval(DefaultSymbols, Expr(:export, :°C))

    Core.eval(DefaultSymbols, Expr(:import, Expr(:(.), :Unitful, :°)))
    Core.eval(DefaultSymbols, Expr(:export, :°))
end

#########

preferunits(kg) # others done in @refunit

"""
    Unitful.promote_to_derived()
Defines promotion rules to use derived SI units in promotion for common dimensions
of quantities:

- `J` (joule) for energy
- `N` (newton) for force
- `W` (watt) for power
- `Pa` (pascal) for pressure
- `C` (coulomb) for charge
- `V` (volt) for voltage
- `Ω` (ohm) for resistance
- `F` (farad) for capacitance
- `H` (henry) for inductance
- `Wb` (weber) for magnetic flux
- `T` (tesla) for B-field
- `J*s` (joule-second) for action

If you want this as default behavior (it was for versions of Unitful prior to 0.1.0),
consider invoking this function in your `.juliarc.jl` file which is loaded when
you open Julia. This function is not exported.
"""
function promote_to_derived()
    eval(quote
         Unitful.promote_unit(::S, ::T) where
         {S<:EnergyFreeUnits, T<:EnergyFreeUnits} = Unitful.J
         Unitful.promote_unit(::S, ::T) where
         {S<:ForceFreeUnits, T<:ForceFreeUnits} = Unitful.N
         Unitful.promote_unit(::S, ::T) where
         {S<:PowerFreeUnits, T<:PowerFreeUnits} = Unitful.W
         Unitful.promote_unit(::S, ::T) where
         {S<:PressureFreeUnits, T<:PressureFreeUnits} = Unitful.Pa
         Unitful.promote_unit(::S, ::T) where
         {S<:ChargeFreeUnits, T<:ChargeFreeUnits} = Unitful.C
         Unitful.promote_unit(::S, ::T) where
         {S<:VoltageFreeUnits, T<:VoltageFreeUnits} = Unitful.V
         Unitful.promote_unit(::S, ::T) where
         {S<:ElectricalResistanceFreeUnits, T<:ElectricalResistanceFreeUnits} = Unitful.Ω
         Unitful.promote_unit(::S, ::T) where
         {S<:CapacitanceFreeUnits, T<:CapacitanceFreeUnits} = Unitful.F
         Unitful.promote_unit(::S, ::T) where
         {S<:InductanceFreeUnits, T<:InductanceFreeUnits} = Unitful.H
         Unitful.promote_unit(::S, ::T) where
         {S<:MagneticFluxFreeUnits, T<:MagneticFluxFreeUnits} = Unitful.Wb
         Unitful.promote_unit(::S, ::T) where
         {S<:BFieldFreeUnits, T<:BFieldFreeUnits} = Unitful.T
         Unitful.promote_unit(::S, ::T) where
         {S<:ActionFreeUnits, T<:ActionFreeUnits} = Unitful.J * Unitful.s
        end)
    nothing
end
