clear all
set more off 

cd "/Users/asilvub/Documents/GitHub/Price_Level_EA" // change as you please

// You can find the data here 
// https://ec.europa.eu/eurostat/databrowser/view/prc_hicp_midx/default/table?lang=en&category=prc.prc_hicp
// Run this in case you want from the raw data 
// if not set use_raw = 0 and this will use the already created smaller excel file. This is the default.

global use_raw = 0


if $use_raw == 1{

	import delimited using "estat_prc_hicp_midx_en.csv", clear
	
	keep if coicop == "All-items HICP"
	keep if unit == "Index, 2005=100"
	
	export excel using "hicp_EA.xlsx", firstrow(var)  replace
	sort geo time_period
bys geo: gen t = _n
encode geo, gen(id)

xtset id t, m 

replace t= t + 36 * 12 - 1

gen v_2015 = obs_value if tin(2015m1,2015m12)
egen vb_2015 = mean(v_2015),by(geo)
rename obs_value b_2005

gen obs_value = (b_2005/vb_2015) * 100


twoway (line obs_value t if geo == "Austria") ///
       (line obs_value t if geo == "Belgium") ///
	   (line obs_value t if geo == "Cyprus") /// 
	   (line obs_value t if geo == "Germany") /// 
	   (line obs_value t if geo == "Estonia") /// 
	   (line obs_value t if geo == "Spain") /// 
	   (line obs_value t if geo == "France") /// 
	   (line obs_value t if geo == "Greece") /// 
	   (line obs_value t if geo == "Croatia") /// 
	   (line obs_value t if geo == "Ireland") /// 
	   (line obs_value t if geo == "Italy") /// 
	   (line obs_value t if geo == "Lithuania") /// 
	   (line obs_value t if geo == "Luxembourg") ///
	   (line obs_value t if geo == "Latvia") /// 
	   (line obs_value t if geo == "Malta") /// 
	   (line obs_value t if geo == "Netherlands", lpattern("--")) /// 
	   (line obs_value t if geo == "Portugal", lpattern("--")) /// 
	   (line obs_value t if geo == "Slovenia", lpattern("--")) /// 
	   (line obs_value t if geo == "Slovakia", lpattern("--")) /// 
	   (line obs_value t if id == 9, lpattern("--")) /// 
	   if tin(2015m1,2024m9), ///
	   legend(order(1 "Austria" 2 "Belgium" 3 "Cyprus" 4 "Germany" 5 "Estonia" ///
	                6 "Spain" 7 "France" 8 "Greece" 9 "Croatia" 10 "Ireland" ///
					11 "Italy" 12 "Lithuania" 13 "Luxembourg" 14 "Latvia" 15 "Malta" ///
					16 "Netherlands" 17 "Portugal" 18 "Slovenia" 19 "Slovakia" 20 "Euro Area")) ///
	   ytitle("Price Level (2015 = 100)") ylabel(80(20)160) ///
	   xtitle("") tlabel(2015m1 2016m1(12)2024m1 2024m9, angle(45))

graph export "euro_area_countries_price_level.pdf", replace


twoway (line obs_value t if geo == "Germany") ///
       (line obs_value t if geo == "Spain") ///
	   (line obs_value t if geo == "France") /// 
	   (line obs_value t if geo == "Italy") /// 
	   (line obs_value t if id == 9) /// 
	   if tin(2015m1,2024m9), ///
	   legend(order(1 "Germany" 2 "Spain" 3 "France" 4 "Italy" 5 "Euro Area")) ///
	   ytitle("Price Level (2015 = 100)") ylabel(90(10)130) ///
	   xtitle("") tlabel(2015m1 2016m1(12)2024m1 2024m9, angle(45))
graph export "selected_euro_area_countries_price_level.pdf", replace
}
else {

import excel using "hicp_EA.xlsx", firstrow case(lower) clear

sort geo time_period
bys geo: gen t = _n
encode geo, gen(id)

xtset id t, m 

replace t= t + 36 * 12 - 1

gen v_2015 = obs_value if tin(2015m1,2015m12)
egen vb_2015 = mean(v_2015),by(geo)
rename obs_value b_2005

gen obs_value = (b_2005/vb_2015) * 100


twoway (line obs_value t if geo == "Austria") ///
       (line obs_value t if geo == "Belgium") ///
	   (line obs_value t if geo == "Cyprus") /// 
	   (line obs_value t if geo == "Germany") /// 
	   (line obs_value t if geo == "Estonia") /// 
	   (line obs_value t if geo == "Spain") /// 
	   (line obs_value t if geo == "France") /// 
	   (line obs_value t if geo == "Greece") /// 
	   (line obs_value t if geo == "Croatia") /// 
	   (line obs_value t if geo == "Ireland") /// 
	   (line obs_value t if geo == "Italy") /// 
	   (line obs_value t if geo == "Lithuania") /// 
	   (line obs_value t if geo == "Luxembourg") ///
	   (line obs_value t if geo == "Latvia") /// 
	   (line obs_value t if geo == "Malta") /// 
	   (line obs_value t if geo == "Netherlands", lpattern("--")) /// 
	   (line obs_value t if geo == "Portugal", lpattern("--")) /// 
	   (line obs_value t if geo == "Slovenia", lpattern("--")) /// 
	   (line obs_value t if geo == "Slovakia", lpattern("--")) /// 
	   (line obs_value t if id == 9, lpattern("--")) /// 
	   if tin(2015m1,2024m9), ///
	   legend(order(1 "Austria" 2 "Belgium" 3 "Cyprus" 4 "Germany" 5 "Estonia" ///
	                6 "Spain" 7 "France" 8 "Greece" 9 "Croatia" 10 "Ireland" ///
					11 "Italy" 12 "Lithuania" 13 "Luxembourg" 14 "Latvia" 15 "Malta" ///
					16 "Netherlands" 17 "Portugal" 18 "Slovenia" 19 "Slovakia" 20 "Euro Area")) ///
	   ytitle("Price Level (2015 = 100)") ylabel(80(20)160) ///
	   xtitle("") tlabel(2015m1 2016m1(12)2024m1 2024m9, angle(45))

graph export "euro_area_countries_price_level.pdf", replace


twoway (line obs_value t if geo == "Germany") ///
       (line obs_value t if geo == "Spain") ///
	   (line obs_value t if geo == "France") /// 
	   (line obs_value t if geo == "Italy") /// 
	   (line obs_value t if id == 9) /// 
	   if tin(2015m1,2024m9), ///
	   legend(order(1 "Germany" 2 "Spain" 3 "France" 4 "Italy" 5 "Euro Area")) ///
	   ytitle("Price Level (2015 = 100)") ylabel(90(10)130) ///
	   xtitle("") tlabel(2015m1 2016m1(12)2024m1 2024m9, angle(45))
graph export "selected_euro_area_countries_price_level.pdf", replace
}
