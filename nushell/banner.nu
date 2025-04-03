# Fetch weather data
# get github events data
let github_token = $env.github_terminal_view_api_token
# parallelized the shit out of this bad bou
# TODO : Try to make this a background job? since nu is supporting this now.
let api_calls = [
{ http get "https://api.open-meteo.com/v1/forecast?latitude=22.5744&longitude=88.3629&current=temperature_2m,apparent_temperature,wind_speed_10m,rain&forecast_days=1"}
    {http get --headers ["Authorization" $"token ($github_token)"] "https://api.github.com/users/adityavikramsinha/events" }
] | par-each {|req| do $req}


# weather api
let current_weather = $api_calls       | get 0 | get current 
let temperature     = $current_weather | get temperature_2m
let app_temp        = $current_weather | get apparent_temperature 
let wind_speed      = $current_weather | get wind_speed_10m 
let rain            = $current_weather | get rain
# weather api glyph 
let temperature_glyph = if $temperature >= 30 { "☀️" } else { "🍃" }


let commit_count = $api_calls | get 1 | length

# I don't like it being this close to terminal, sorry.
let space = "            "

# get agg(up/down) network speeds, but there is no native support
# so we will have to just get it from the system it self
let network_table =  wmic nic where "NetEnabled=true" get Speed | lines | skip 1 | str trim | get 0 | split row " "
let network_speed = $network_table | get 0 | into int
let network_in_mbps = ( $network_speed / 1_000_000 )



# welcome message
let welcome = $"




($space) █████╗ ██╗   ██╗███████╗                 ($commit_count)
($space)██╔══██╗██║   ██║██╔════╝               ⾕ (sys host | get hostname)
($space)███████║██║   ██║███████╗               ↑⇣ (sys host | get uptime)
($space)██╔══██║╚██╗ ██╔╝╚════██║               ⛁  (sys mem | get used) / (sys mem | get total) [((sys mem | get used) / (sys mem | get total) * 100 | into int)%]
($space)██║  ██║ ╚████╔╝ ███████║               ᯤ  ($network_in_mbps)mbips
($space)╚═╝  ╚═╝  ╚═══╝  ╚══════╝               ($temperature_glyph) ($temperature)°C[($app_temp)] | ≈ ($wind_speed) km/h | ☔ ($rain)mm  





"

let $gradient = $welcome | ansi gradient --fgstart '0xF9E2AF' --fgend '0xd158d1'
print $gradient
