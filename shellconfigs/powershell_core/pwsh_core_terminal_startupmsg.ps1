#Just Prints a Skeleton (: provided the password and the username are correct.
Function Get-ANSIEquivalent {

    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$RGB
    )

    process {
        $RGB = $RGB.Replace('#', '')
        $RGB = $RGB.Replace(' ', '')
        $r = [convert]::ToInt32($RGB.SubString(0, 2), 16)
        $g = [convert]::ToInt32($RGB.SubString(2, 2), 16)
        $b = [convert]::ToInt32($RGB.SubString(4, 2), 16)
        return "`e[38;2;$r;$g;$b`m"
    }
}

Function Get-BlockCharactersInRange{
  [OutputType([string])]
  Param([int] $BeginIndex, [int]$ElCount, $ColorChoices ,[string]$Separator ="")
  [string]$BlockCharacters = "███"
  [string]$Output = ""
  for($i = 0 ;$i -lt $ElCount ; $i++ ){
    $Output += ((Get-ANSIEquivalent -RGB $ColorChoices[$BeginIndex + $i])+$BlockCharacters + $Separator)
  }
  return $Output
}

Function Out-WelcomeMessage {

        Write-Host "...and who the fuck are u?:" -ForegroundColor DarkGreen -NoNewline
        $username = Read-Host

        if (-not ($username -eq "virile") ) {
            " Yeah right, u wish i'd let you in " | Write-Host -ForegroundColor White -BackgroundColor Red
            return
        }
        $WelcomeMSG
        [int]$timeForUser = Get-Date -Format "HH"
        if ($timeForUser -lt 12) {
            $WelcomeMSG = "Good Morning,${username}"
        }
        elseif ($timeForUser -gt 12 -and $timeForUser -lt 18) {
            $WelcomeMSG = "Good Afternoon,${username}"
        }
        elseif ($timeForUser -gt 18) {
            $WelcomeMSG = "Good Evening,${username}"
        }
        #System information to go with the skeleton
        $OS = (Get-WmiObject -class Win32_OperatingSystem).Caption
        $Username = $username
        $CPUName = "Intel64 Family 6 Model 142 Stepping 10 ~2208 Mhz"
        #for the RAM usage
        $CompObject = Get-WmiObject -Class WIN32_OperatingSystem
        $RAMUsagePercent = (
            (
      ($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory) / 1024 / 1024
            ) /
      ($CompObject.TotalVisibleMemorySize / 1024 / 1024)
        ) * 100
        $RAMTotal = $CompObject.TotalVisibleMemorySize / 1024 / 1024
        $Time = Get-Date -Format "HH:mm"
        $Date = Get-Date -Format "dd/MM/yyyy"
        $Architecture = $Env:PROCESSOR_ARCHITECTURE
        $colorsRGB =    "#eee3e7" , "#ead5dc" , "#eec9d2" , "#f4b6c2" , "#f6abb6" ,
                        "#011f4b" , "#03396c" , "#005b96" , "#6497b1" , "#b3cde0" ,
                        "#051e3e" , "#251e3e" , "#451e3e" , "#651e3e" , "#851e3e" ,
                        "#ee4035" , "#f37736" , "#fdf498" , "#7bc043" , "#0392cf" ,
                        "#eeeeee" , "#dddddd" , "#cccccc" , "#bbbbbb" , "#aaaaaa" ,
                        "#a8e6cf" , "#dcedc1" , "#ffd3b6" , "#ffaaa5" , "#ff8b94" ,
                        "#fff6e9" , "#ffefd7" , "#fffef9" , "#e3f0ff" , "#d2e7ff" ,
                        "#343d46" , "#4f5b66" , "#65737e" , "#a7adba" , "#c0c5ce" ,
                        "#e3c9c9" , "#f4e7e7" , "#eedbdb" , "#cecbcb" , "#cbdadb" ,
                        "#e0ac69" , "#f1c27d" , "#ffdbac"
        $RandomIndexNumber = Get-Random
        $RandomIndexNumber = $RandomIndexNumber % ($colorsRGB.Length+1)
        $RandomColor = $( Get-ANSIEquivalent -RGB $colorsRGB[$RandomIndexNumber] )
        $SkeletonASCIIArt = "$RandomColor
                    ::^!7JYYYJ?!~^^^..........::~!!!777~^
               .^!JJ?7J?~^:::................... ....^~777~.
            .^YPY?!~~~:....::............................~?YJ^
          :75P5!~~!^.....::...............................:~7JJ~.
        ^?JJJ~~!!~:.........................................^~!JY~                    `e[37m${WelcomeMSG}$RandomColor
      :J5?!777!^^.....:.....................................:^J!~YJ:
     7GY!!?77~^^^:...:...:..................................:.:7^^YY:
   :JB?!?7?!~^^^:...:..........................................^J7^YY                 `e[4mOSX INFO PWSH =:`e[0m$RandomColor
  :J@?!J^!?~^^^^...:......:............................:......: 7Y~^P7
  ?BP^!?^Y7~^^^:............:..........................:........^5Y^?G:
 ~PB7~~!7P!~:::.....:..:.:.:::...............:...................YP7~BJ               `e[90mCurrent-User            : `e[0m${UserName}$RandomColor
:YGP?^!!~J?!^:.........:.:.::::..............::..................5PJ!55               `e[37mCurrrent OS             : `e[0m${OS}`e[0m$RandomColor
~GPPY!~Y:^JJ!^....:........:::::..............~......:^^.........JYJ7?5               `e[31mCPU name                : `e[0m${CPUName}`e[0m$RandomColor
!Y!~JY^Y7:!J57^:.:::::.......:^^^:::..........^:....^7!....:....:?Y?!?G:              `e[32mAmount of RAM being used: `e[0m${RAMUsagePercent}% of ${RAMTotal} GB`e[0m$RandomColor
7J^.^?5?G7^~J5Y7~^^:::.........~~!~^~~:::......^.::^7!~~~!!:....^~?Y~75!              `e[33mTotal RAM               : `e[0m${RAMTotal}`e[0m$RandomColor
!5^ .:J5PPJ~~7JP5!::::..........:^~~!7?!!!^^^::^^^~?J5PP55?!^:^:..:!7775J             `e[34mTime                    : `e[0m${Time}`e[0m$RandomColor
~5^~^..!75#B5?7?JP~...........::^^~!7J5YYJ?7~^~~~7JPPGGGBG55J?77!~~^:^^?YJ^           `e[35mDate                    : `e[0m${Date}`e[0m$RandomColor
:YJ7?7~..:?GB#Y~7YJ^...::^:~~!!!!?JJYG57777JY!7!~7555P#@@@@@@@@@@&@&BY!:.P!           `e[36mOS Architecture         : `e[0m${Architecture}`e[0m$RandomColor
.YG!??J?7~^!JG@GJJ7~:^!7!!!77?Y5PB&&&&#BGPJ?!!^^^JJ5G#@@@@@@@@&&###&@@&PGG:
 !BP?7^!?5Y!!YB@BJ!77?J7JYG#&@@@@@@&@@@@@#GPY7?Y75GB&@@@@@@@&#GPPY5G&B&GG?
  JGY!~^.!JYYJG@Y^YJJ5G#&@@@&@@&&&&@@&#BBGY5G#PJ5YGP#@@@@@&&#G5P5JYY5G#?G~
  ^?Y5!~:.~77J#G.!GGB@@@&#BBB#@&##@@##GGJ5!7PP?~!!PJG@@&#BPP5YYYGB?~?J5~#!            $(Get-BlockCharactersInRange -BeginIndex 0 -ElCount 12 -ColorChoices $colorsRGB -Separator " ")`e[0m$RandomColor
   7JY5J^..~!P@~:?&@@@@&@&#BB#&##&&#5PBB#B5~JYJ77~JYY&&@&B55JJ7P&&#!~?!:GG^
    77JJ57. :Y&!~7#@&&@#BPBG#&#BG555PGB&@J55?.?57!!5?5&PPPJ??77?JY5!:YJ:J5G~:         $(Get-BlockCharactersInRange -BeginIndex 12 -ElCount 12 -ColorChoices $colorsRGB -Separator " ")`e[0m$RandomColor
    ~7!^^YP!.:P#!?5G&&BBGPY5B&G5YYYGB##&&?BG7^!5?J:?J!7PPJ7!77?!~~~!?#P.!!PG7:
  ^.:Y~! :7YJ~^#Y!PGB&PYYYG#B7PGYYJ5PPP#BB5?5:!?!~?7???:~JPGPJ77?7J5#5~::^?&?^        $(Get-BlockCharactersInRange -BeginIndex 24 -ElCount 12 -ColorChoices $colorsRGB -Separator " ")`e[0m$RandomColor
   ^:^Y?!..:~77G!7~GG##5Y&&P?!BY5G#BGG&@G77?^.!?~75YG?!Y!.:~J5Y??7P#Y~..::~GJ~
    :~5YY7^..:JG~:^:5#@@#&G5J5GBGB#&&&G7~~:..^?7Y&&&@#7:?J: ..^!^.^~?J!^:.:PP~        $(Get-BlockCharactersInRange -BeginIndex 36 -ElCount 12 -ColorChoices $colorsRGB -Separator " ")`e[0m$RandomColor
      !5?J7JJ?J!^.:.:7YPB#&&&@&B#BG5?~:..:..:7~?@@@@@@&Y~??:.~^^!~:..!55J??BJ
       J?!55~^:::..^:.:^!?????77Y?!~:::^~~::^PB#@@&B&&&#BY!^:JP#&Y!~:..~PPBP~
       :?PJ~::.....:~...:~?55P##J!YJJ!^^~!?YG@@P5&#PYY?P5BP:^!P5J?:~7??J#B5:
         ^??^......^~.....^!?GY:7B??JPBY~YP@@@&GYG#BP5G@BBP.:?5^:!?Y?!7??^
           !57^^^^!!^ .... ~G5!JG77??7G5.Y&@&&BBB7P&@@@&JBJ ^PP5?7!~
            ^?PPJPPY~:..::.!PYGP?!^:^~75?~B@@#PYP5^5GBG!YJ^ 7GG!:
              :!P@BY7!~7JY5B#&@#&BJ!:..^J7:!5BBPJJ7~5J~Y!:^.5B^.:
                 ~PGJ~^7J5G#P5YJPP5Y!:~. ^^.^!755J?~^!7^ !^^#?::
                  .!?J?7J?JY!. ..?J!!~^!^....~~~!7!Y7?~~!~~JB~
                     .::^::. .....?YY~!!YJ~:..:^!J5~JP?!^7YY!:
                                   ~JPPJ7J~^~~^::^!7~Y5!?57
                                     .^!!7!^^^~~~!JJJJ5J~."
        Write-Host "$SkeletonASCIIArt"
    }