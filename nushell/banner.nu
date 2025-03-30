# Fetch weather data
let weather_stack_api_key = $env.weather_stack_api_key
let weather_data = http get $"http://api.weatherstack.com/current?access_key=($weather_stack_api_key)&query=Kolkata"


# get github events data
let github_token = $env.github_terminal_view_api_token
let events_data =  curl -s -H $"Authorization: token ($github_token)" "https://api.github.com/users/adityavikramsinha/events" | from json

# commit count
let commit_count = $events_data | where type == "PushEvent" | length

# weather related pre processing
let pm2_5 = $weather_data | get current.air_quality.pm2_5 | into int
let temperature = $weather_data | get current.temperature
let precip = $weather_data | get current.precip
let temperature_glyph = if $temperature >= 30 { "☀️" } else { "🍃" }
let air_quality_glyph = if $pm2_5 >= 50 { "🕱" } else { if $pm2_5 >= 35 { "⚠" } else { "✅" } }


# I dont like it being this close to terminal, sorry.
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
($space)╚═╝  ╚═╝  ╚═══╝  ╚══════╝               ($temperature_glyph) ($temperature)°C | ($air_quality_glyph) AQI ($pm2_5) | ($precip)% chances to get laid




"

let $gradient = $welcome | ansi gradient --fgstart '0xF9E2AF' --fgend '0xd158d1'
print $gradient
