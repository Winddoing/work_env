SET sys_fonts_dir=c:\Windows\Fonts
SET my_fonts_dir=fonts

if not exist %my_fonts_dir% ( md %my_fonts_dir%)

:: 微软雅黑字体
call:export_font msyi.ttf, msyh.ttc, msyhbd.ttc, msyhl.ttc

:: 楷书常规 隶书常规 宋体常规 仿宋常规 黑体常规等
call:export_font SIMLI.TTF simsun.ttc simsunb.ttf simfang.ttf simhei.ttf simkai.ttf SIMYOU.TTF

pause

:export_font
set arg=(%1, %2, %3, %4, %5, %6, %7, %8, %9)
::for %%F in %export_need_fonts% do copy %sys_fonts_dir%\%%F %my_fonts_dir%
for %%F in %arg% do copy %sys_fonts_dir%\%%F %my_fonts_dir%
goto:eof
