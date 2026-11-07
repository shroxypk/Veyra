-- Decompiled with Veyra harvester
-- Instance: StarterGui.Permanent.Window.Info.Client.Contents
-- Class: ModuleScript
-- bytes: 28661

do
    local color = Color3.fromRGB(255, 255, 255)
    local color_1 = Color3.fromRGB(255, 255, 255)
    local color_2 = Color3.fromRGB(158, 191, 209)
    local color_3 = Color3.fromRGB(255, 85, 127)

    local _ = function(arg1) --[[ blue ]] -- line: 19
        -- upvalues:
        --  [1] color (copy)

        local v1 = color:ToHex()

        return `<font size='{24}' color='#{v1}'><b>{arg1}</b></font>`
    end

    local _ = function(arg2) --[[ gold ]] -- line: 20
        -- upvalues:
        --  [1] color_1 (copy)

        local v2 = color_1:ToHex()

        return `<font size='{24}' color='#{v2}'><b>{arg2}</b></font>`
    end

    local _ = function(arg3) --[[ pink ]] -- line: 21
        -- upvalues:
        --  [1] color_3 (copy)

        local v3 = color_3:ToHex()

        return `<font color='#{v3}'><b>{arg3}</b></font>`
    end

    local _ = function(arg4) --[[ key ]] -- line: 22
        -- upvalues:
        --  [1] color_2 (copy)

        local v4 = color_2:ToHex()

        return `<font color='#{v4}'><b>{arg4}</b></font>`
    end

    local t = {
        Starter = nil,
        Controls = nil,
        Magic = nil,
        Progression = nil,
        Quests = nil,
        Professions = nil,
        Missions = nil,
        Abilities = nil
    }
    do
        local t_1 = { Header = "STARTER GUIDE", Description = nil }
        local table_concat = table.concat
        local v5 = color:ToHex()
        local v6 = `<font size='{24}' color='#{v5}'><b>Getting Started</b></font>`
        local v7 = color_2:ToHex()
        local v8 = `<font color='#{v7}'><b>quests</b></font>`
        local v9 = `Your journey begins the moment you set foot in the world. Talk to the people you meet, take on their {v8}, and get a feel for combat as you go.`
        local v10 = color_1:ToHex()
        local v11 = `<font size='{24}' color='#{v10}'><b>Your Own Path</b></font>`
        local v12 = color_2:ToHex()
        local v13 = `<font color='#{v12}'><b>non-linear</b></font>`
        local v14 = `Progression is {v13}. There is no single route you have to follow, so you are free to grow your character however you like.`
        local v15 = color:ToHex()
        local v16 = `<font size='{24}' color='#{v15}'><b>Recommended</b></font>`
        local v17 = color_2:ToHex()
        local v18 = `<font color='#{v17}'><b>quests</b></font>`
        local v19 = color_2:ToHex()
        local v20 = `<font color='#{v19}'><b>explore</b></font>`
        local v21 = `If you're unsure where to start, complete {v18} around the world and {v20}. New areas hold new people, rewards and secrets, and quests are one of the steadiest ways to gain experience early on.`
        local v22 = color_2:ToHex()
        local v23 = `<font color='#{v22}'><b>controls</b></font>`
        local v24 = color_2:ToHex()
        local v25 = `<font color='#{v24}'><b>magic</b></font>`
        local v26 = color_2:ToHex()
        local v27 = `<font color='#{v26}'><b>abilities</b></font>`
        local v28 = color_2:ToHex()
        local v29 = `<font color='#{v28}'><b>progression</b></font>`
        t_1.Description = table_concat(
            {
                v6,
                v9,
                "",
                v11,
                v14,
                "",
                v16,
                v21,
                "",
                `Check out the other sections of this guide to learn about {v23}, {v25}, {v27} and {v29}.`
            },
            "\n"
        )
        t.Starter = t_1
    end
    do
        local t_3 = { Header = "CONTROLS", Description = nil, GamepadDescription = nil }
        local table_concat_1 = table.concat
        local v30 = color:ToHex()
        local v31 = `<font size='{24}' color='#{v30}'><b>Combat</b></font>`
        local v32 = color_2:ToHex()
        local v33 = `<font color='#{v32}'><b>Aerial M1</b></font>`
        local v34 = `{v33}  -  Jump + M1`
        local v35 = color_2:ToHex()
        local v36 = `<font color='#{v35}'><b>Aerial M2</b></font>`
        local v37 = `{v36}  -  Jump + M2 (while shift locked)`
        local v38 = color_2:ToHex()
        local v39 = `<font color='#{v38}'><b>Uppercut</b></font>`
        local v40 = `{v39}  -  Crouch + M1`
        local v41 = color_2:ToHex()
        local v42 = `<font color='#{v41}'><b>Misdirect</b></font>`
        local v43 = `{v42}  -  M1 + M2`
        local v44 = color_2:ToHex()
        local v45 = `<font color='#{v44}'><b>Critical</b></font>`
        local v46 = `{v45}  -  R`
        local v47 = color_1:ToHex()
        local v48 = `<font size='{24}' color='#{v47}'><b>Defense & Movement</b></font>`
        local v49 = color_2:ToHex()
        local v50 = `<font color='#{v49}'><b>Roll</b></font>`
        local v51 = `{v50}  -  Q`
        local v52 = color_2:ToHex()
        local v53 = `<font color='#{v52}'><b>Block</b></font>`
        local v54 = `{v53}  -  F`
        local v55 = color_2:ToHex()
        local v56 = `<font color='#{v55}'><b>Broom</b></font>`
        local v57 = `{v56}  -  Y`
        local v58 = color_2:ToHex()
        local v59 = `<font color='#{v58}'><b>Grip</b></font>`
        local v60 = `{v59}  -  B (on a downed player)`
        local v61 = color_2:ToHex()
        local v62 = `<font color='#{v61}'><b>Carry</b></font>`
        local v63 = `{v62}  -  V (on a downed player)`
        local v64 = color:ToHex()
        local v65 = `<font size='{24}' color='#{v64}'><b>Utility</b></font>`
        local v66 = color_2:ToHex()
        local v67 = `<font color='#{v66}'><b>Utility Spells</b></font>`
        local v68 = color_2:ToHex()
        local v69 = `<font color='#{v68}'><b>Quest Journal</b></font>`
        local v70 = `{v69}  -  J`
        local v71 = color_2:ToHex()
        local v72 = `<font color='#{v71}'><b>Map</b></font>`
        t_3.Description = table_concat_1(
            {
                v31,
                v34,
                v37,
                v40,
                v43,
                v46,
                "",
                v48,
                v51,
                v54,
                v57,
                v60,
                v63,
                "",
                v65,
                `{v67}  -  Hold U`,
                v70,
                `{v72}  -  M`
            },
            "\n"
        )

        function t_3.GamepadDescription(arg5) -- line: 66
            -- upvalues:
            --  [1] color (copy)
            --  [2] color_2 (copy)
            --  [3] color_1 (copy)

            local table_concat_2 = table.concat
            local v73 = color:ToHex()
            local v74 = `<font size='{24}' color='#{v73}'><b>Combat</b></font>`
            local v75 = color_2:ToHex()
            local v76 = `<font color='#{v75}'><b>Light Attack</b></font>`
            local v77 = arg5("RB")
            local v78 = `{v76}  -  {v77}`
            local v79 = color_2:ToHex()
            local v80 = `<font color='#{v79}'><b>Aerial M1</b></font>`
            local v81 = arg5("A")
            local v82 = arg5("RB")
            local v83 = `{v80}  -  {v81} + {v82}`
            local v84 = color_2:ToHex()
            local v85 = `<font color='#{v84}'><b>Aerial M2</b></font>`
            local v86 = arg5("A")
            local v87 = arg5("X")
            local v88 = arg5("RS")
            local v89 = `{v85}  -  {v86} + {v87} (while shift locked, {v88})`
            local v90 = color_2:ToHex()
            local v91 = `<font color='#{v90}'><b>Uppercut</b></font>`
            local v92 = arg5("B")
            local v93 = arg5("RB")
            local v94 = `{v91}  -  Crouch ({v92}) + {v93}`
            local v95 = color_2:ToHex()
            local v96 = `<font color='#{v95}'><b>Misdirect</b></font>`
            local v97 = arg5("RB")
            local v98 = arg5("X")
            local v99 = `{v96}  -  {v97} + {v98}`
            local v100 = color_2:ToHex()
            local v101 = `<font color='#{v100}'><b>Critical</b></font>`
            local v102 = arg5("LT")
            local v103 = arg5("RB")
            local v104 = `{v101}  -  Hold {v102} + {v103}`
            local v105 = color_1:ToHex()
            local v106 = `<font size='{24}' color='#{v105}'><b>Defense & Movement</b></font>`
            local v107 = color_2:ToHex()
            local v108 = `<font color='#{v107}'><b>Roll</b></font>`
            local v109 = arg5("Y")
            local v110 = `{v108}  -  {v109}`
            local v111 = color_2:ToHex()
            local v112 = `<font color='#{v111}'><b>Block</b></font>`
            local v113 = arg5("LB")
            local v114 = `{v112}  -  {v113}`
            local v115 = color_2:ToHex()
            local v116 = `<font color='#{v115}'><b>Sprint</b></font>`
            local v117 = arg5("LS")
            local v118 = arg5("LS")
            local v119 = `{v116}  -  Tap {v117} to toggle, hold {v118} for sprint attacks`
            local v120 = color_2:ToHex()
            local v121 = `<font color='#{v120}'><b>Crouch</b></font>`
            local v122 = arg5("B")
            local v123 = `{v121}  -  {v122}`
            local v124 = color_2:ToHex()
            local v125 = `<font color='#{v124}'><b>Ultimate</b></font>`
            local v126 = arg5("RT")
            local v127 = arg5("RB")
            local v128 = `{v125}  -  Hold {v126} + {v127}`
            local v129 = color_2:ToHex()
            local v130 = `<font color='#{v129}'><b>Shift Lock</b></font>`
            local v131 = arg5("RS")
            local v132 = `{v130}  -  Click {v131} to toggle`
            local v133 = color_2:ToHex()
            local v134 = `<font color='#{v133}'><b>Broom</b></font>`
            local v135 = color_2:ToHex()
            local v136 = `<font color='#{v135}'><b>Grip</b></font>`
            local v137 = arg5("LT")
            local v138 = arg5("RS")
            local v139 = `{v136}  -  Hold {v137} + {v138} (on a downed player)`
            local v140 = color_2:ToHex()
            local v141 = `<font color='#{v140}'><b>Carry</b></font>`
            local v142 = arg5("LT")
            local v143 = arg5("LS")
            local v144 = `{v141}  -  Hold {v142} + {v143} (on a downed player)`
            local v145 = color:ToHex()
            local v146 = `<font size='{24}' color='#{v145}'><b>Utility</b></font>`
            local v147 = color_2:ToHex()
            local v148 = `<font color='#{v147}'><b>Utility Spells</b></font>`
            local v149 = `{v148}  -  Hold D-Pad Right (aim with the right stick, release to cast)`
            local v150 = color_2:ToHex()
            local v151 = `<font color='#{v150}'><b>Quest Journal</b></font>`
            local v152 = `{v151}  -  Hold D-Pad Down`
            local v153 = color_2:ToHex()
            local v154 = `<font color='#{v153}'><b>Map</b></font>`
            local v155 = `{v154}  -  Tap D-Pad Down`
            local v156 = color_2:ToHex()
            local v157 = `<font color='#{v156}'><b>Menu</b></font>`
            local v158 = `{v157}  -  Tap D-Pad Left`
            local v159 = color_1:ToHex()
            local v160 = `<font size='{24}' color='#{v159}'><b>Hotbar</b></font>`
            local v161 = arg5("LT")
            local v162 = arg5("RT")
            local v163 = color_2:ToHex()
            local v164 = `<font color='#{v163}'><b>tool slot</b></font>`
            local v165 = `Hold {v161}, {v162} or both, then press a face button to use a {v164}.`
            local v166 = color_2:ToHex()
            local v167 = `<font color='#{v166}'><b>Settings > Controls</b></font>`

            return table_concat_2(
                {
                    v74,
                    v78,
                    v83,
                    v89,
                    v94,
                    v99,
                    v104,
                    "",
                    v106,
                    v110,
                    v114,
                    v119,
                    v123,
                    v128,
                    v132,
                    `{v134}  -  Tap D-Pad Right`,
                    v139,
                    v144,
                    "",
                    v146,
                    v149,
                    v152,
                    v155,
                    v158,
                    "",
                    v160,
                    v165,
                    `Change any of these in {v167}: press a button, or hold a trigger and press a button for a combo.`
                },
                "\n"
            )
        end

        t.Controls = t_3
    end
    do
        local t_6 = { Header = "MAGIC GUIDE", Description = nil }
        local table_concat_3 = table.concat
        local v168 = color:ToHex()
        local v169 = `<font size='{24}' color='#{v168}'><b>Obtaining Magic</b></font>`
        local v170 = color_2:ToHex()
        local v171 = `<font color='#{v170}'><b>level 15</b></font>`
        local v172 = color_2:ToHex()
        local v173 = `<font color='#{v172}'><b>library at Wisdom's Peak</b></font>`
        local v174 = `Once you reach {v171}, head to the {v173} to receive your magic.`
        local v175 = color_1:ToHex()
        local v176 = `<font size='{24}' color='#{v175}'><b>Progressing Your Magic</b></font>`
        local v177 = color_2:ToHex()
        local v178 = `<font color='#{v177}'><b>Inner Realm</b></font>`
        local v179 = `To level up your magic, travel to the {v178} and interact with tok found there.`
        local v180 = color:ToHex()
        local v181 = `<font size='{24}' color='#{v180}'><b>Unlocking Skills</b></font>`
        local v182 = color_2:ToHex()
        local v183 = `<font color='#{v182}'><b>Insight</b></font>`
        local v184 = color_2:ToHex()
        local v185 = `<font color='#{v184}'><b>Manahearts</b></font>`
        local v186 = `Magic skills are unlocked using {v183} and {v185}.`
        local v187 = color_1:ToHex()
        local v188 = `<font size='{24}' color='#{v187}'><b>Insight</b></font>`
        local v189 = color_2:ToHex()
        local v190 = `<font color='#{v189}'><b>knowledge</b></font>`
        local v191 = color_2:ToHex()
        local v192 = `<font color='#{v191}'><b>skills</b></font>`
        local v193 = color_2:ToHex()
        local v194 = `<font color='#{v193}'><b>traits</b></font>`
        local v195 = color_2:ToHex()
        local v196 = `<font color='#{v195}'><b>events</b></font>`
        local v197 = color_2:ToHex()
        local v198 = `<font color='#{v197}'><b>raids</b></font>`
        local v199 = color_2:ToHex()
        local v200 = `<font color='#{v199}'><b>enemies</b></font>`
        local v201 = color_2:ToHex()
        local v202 = `<font color='#{v201}'><b>bottom left</b></font>`
        local v203 = color_3:ToHex()
        local v204 = `<font color='#{v203}'><b>pink star</b></font>`
        local v205 = `Insight represents {v190} and is used to unlock {v192} and {v194}. It can be obtained through various means, such as completing {v196} and {v198} or defeating {v200}. Certain tasks yield more insight than others. Your Insight is shown at the {v202} of your screen, marked by a {v204}.`
        local v206 = color:ToHex()
        local v207 = `<font size='{24}' color='#{v206}'><b>Manahearts</b></font>`
        local v208 = color_2:ToHex()
        local v209 = `<font color='#{v208}'><b>chests</b></font>`
        local v210 = color_2:ToHex()
        local v211 = `<font color='#{v210}'><b>events</b></font>`
        local v212 = color_2:ToHex()
        local v213 = `<font color='#{v212}'><b>inventory</b></font>`
        local v214 = `Manahearts are found in {v209} earned by clearing {v211} that spawn around the world. Once obtained, they appear in your {v213}.`
        local v215 = color_1:ToHex()
        local v216 = color_2:ToHex()
        local v217 = `<font color='#{v216}'><b>passive traits</b></font>`
        local v218 = `Every magic has {v217} that can be unlocked, granting extra strength beyond your skills.`
        local v219 = color:ToHex()
        local v220 = `<font size='{24}' color='#{v219}'><b>Magic Mastery</b></font>`
        local v221 = color_2:ToHex()
        local v222 = `<font color='#{v221}'><b>damage</b></font>`
        local v223 = color_2:ToHex()
        local v224 = `<font color='#{v223}'><b>abilities</b></font>`
        local v225 = `Your magic grows stronger the more you use it. Dealing {v222} and using {v224} builds mastery and upgrades your magic over time.`
        local v226 = color_1:ToHex()
        local v227 = `<font size='{24}' color='#{v226}'><b>Grimoire Evolution</b></font>`
        local v228 = color_2:ToHex()
        local v229 = `<font color='#{v228}'><b>evolve</b></font>`
        t_6.Description = table_concat_3(
            {
                v169,
                v174,
                "",
                v176,
                v179,
                "",
                v181,
                v186,
                "",
                v188,
                v205,
                "",
                v207,
                v214,
                "",
                `<font size='{24}' color='#{v215}'><b>Passives</b></font>`,
                v218,
                "",
                v220,
                v225,
                "",
                v227,
                `Rumor has it that a grimoire can {v229} once it has been mastered. What it becomes is for you to discover...`
            },
            "\n"
        )
        t.Magic = t_6
    end
    t.Progression = {
        Category = true,
        Label = "There are many ways to grow stronger. Pick a topic to learn more.",
        Children = { "Quests", "Missions", "Professions" }
    }
    do
        local t_9 = {
            Header = "QUESTS",
            ButtonText = "Quests",
            Description = nil,
            GamepadDescription = nil
        }
        local table_concat_4 = table.concat
        local v230 = color:ToHex()
        local v231 = `<font size='{24}' color='#{v230}'><b>Discovering Quests</b></font>`
        local v232 = color_2:ToHex()
        local v233 = `<font color='#{v232}'><b>overworld</b></font>`
        local v234 = `Quests are scattered throughout the {v233}, offering new challenges and opportunities as you explore. Each quest provides a unique experience and another way to progress through the world.`
        local v235 = color_1:ToHex()
        local v236 = `<font size='{24}' color='#{v235}'><b>Locating Quests</b></font>`
        local v237 = color_2:ToHex()
        local v238 = `<font color='#{v237}'><b>M</b></font>`
        local v239 = color_2:ToHex()
        local v240 = `<font color='#{v239}'><b>map</b></font>`
        local v241 = `Press {v238} to open your {v240}. Nearby available quests are marked on the map, making them easier to locate. Explore different areas to discover more quests and challenges.`
        local v242 = color:ToHex()
        local v243 = `<font size='{24}' color='#{v242}'><b>Quest Objectives</b></font>`
        local v244 = color_2:ToHex()
        local v245 = `<font color='#{v244}'><b>objectives</b></font>`
        local v246 = `Quests can involve multiple {v245}, ranging from gathering specific items and solving puzzles to defeating enemies and completing various tasks. Some quests may require several steps before they can be completed.`
        local v247 = color_1:ToHex()
        local v248 = `<font size='{24}' color='#{v247}'><b>Quest Rewards</b></font>`
        local v249 = color_2:ToHex()
        local v250 = `<font color='#{v249}'><b>experience</b></font>`
        t_9.Description = table_concat_4(
            {
                v231,
                v234,
                "",
                v236,
                v241,
                "",
                v243,
                v246,
                "",
                v248,
                `Completing quests rewards you with {v250} and other valuable rewards to aid your journey. Quests provide an alternative way to grow stronger, develop your character, and progress through the world.`
            },
            "\n"
        )

        function t_9.GamepadDescription(_) -- line: 153
            -- upvalues:
            --  [1] color (copy)
            --  [2] color_2 (copy)
            --  [3] color_1 (copy)

            local table_concat_5 = table.concat
            local v251 = color:ToHex()
            local v252 = `<font size='{24}' color='#{v251}'><b>Discovering Quests</b></font>`
            local v253 = color_2:ToHex()
            local v254 = `<font color='#{v253}'><b>overworld</b></font>`
            local v255 = `Quests are scattered throughout the {v254}, offering new challenges and opportunities as you explore. Each quest provides a unique experience and another way to progress through the world.`
            local v256 = color_1:ToHex()
            local v257 = `<font size='{24}' color='#{v256}'><b>Locating Quests</b></font>`
            local v258 = color_2:ToHex()
            local v259 = `<font color='#{v258}'><b>D-Pad Down</b></font>`
            local v260 = color_2:ToHex()
            local v261 = `<font color='#{v260}'><b>map</b></font>`
            local v262 = `Tap {v259} to open your {v261}. Nearby available quests are marked on the map, making them easier to locate. Explore different areas to discover more quests and challenges.`
            local v263 = color:ToHex()
            local v264 = `<font size='{24}' color='#{v263}'><b>Quest Objectives</b></font>`
            local v265 = color_2:ToHex()
            local v266 = `<font color='#{v265}'><b>objectives</b></font>`
            local v267 = `Quests can involve multiple {v266}, ranging from gathering specific items and solving puzzles to defeating enemies and completing various tasks. Some quests may require several steps before they can be completed.`
            local v268 = color_1:ToHex()
            local v269 = `<font size='{24}' color='#{v268}'><b>Quest Rewards</b></font>`
            local v270 = color_2:ToHex()
            local v271 = `<font color='#{v270}'><b>experience</b></font>`

            return table_concat_5(
                {
                    v252,
                    v255,
                    "",
                    v257,
                    v262,
                    "",
                    v264,
                    v267,
                    "",
                    v269,
                    `Completing quests rewards you with {v271} and other valuable rewards to aid your journey. Quests provide an alternative way to grow stronger, develop your character, and progress through the world.`
                },
                "\n"
            )
        end

        t.Quests = t_9
    end
    do
        local t_12 = { Header = "PROFESSIONS", ButtonText = "Professions", Description = nil }
        local table_concat_6 = table.concat
        local v272 = color:ToHex()
        local v273 = `<font size='{24}' color='#{v272}'><b>Learning a Trade</b></font>`
        local v274 = color_2:ToHex()
        local v275 = `<font color='#{v274}'><b>Mining</b></font>`
        local v276 = color_2:ToHex()
        local v277 = `<font color='#{v276}'><b>Harvesting</b></font>`
        local v278 = color_2:ToHex()
        local v279 = `<font color='#{v278}'><b>Crafting</b></font>`
        local v280 = color_2:ToHex()
        local v281 = `<font color='#{v280}'><b>Alchemy</b></font>`
        local v282 = color_2:ToHex()
        local v283 = `<font color='#{v282}'><b>Broom Flying</b></font>`
        local v284 = color_2:ToHex()
        local v285 = `<font color='#{v284}'><b>Combat</b></font>`
        local v286 = color_2:ToHex()
        local v287 = `<font color='#{v286}'><b>level 30</b></font>`
        local v288 = `Professions grow as you use them: {v275}, {v277}, {v279}, {v281}, {v283} and {v285}. Each one levels up to {v287}.`
        local v289 = color_1:ToHex()
        local v290 = `<font size='{24}' color='#{v289}'><b>Ranks</b></font>`
        local v291 = color_2:ToHex()
        local v292 = `<font color='#{v291}'><b>5 levels</b></font>`
        local v293 = color_2:ToHex()
        local v294 = `<font color='#{v293}'><b>rank challenge</b></font>`
        local v295 = color_2:ToHex()
        local v296 = `<font color='#{v295}'><b>Professions</b></font>`
        local v297 = `Every {v292} is a new rank, from Novice to Grandmaster. Some rank-ups need you to pass a {v294} first, started from the {v296} page of your menu.`
        local v298 = color:ToHex()
        local v299 = `<font size='{24}' color='#{v298}'><b>Rewards</b></font>`
        local v300 = color_2:ToHex()
        local v301 = `<font color='#{v300}'><b>Locked Essence</b></font>`
        local v302 = color_2:ToHex()
        local v303 = `<font color='#{v302}'><b>quality</b></font>`
        local v304 = color_2:ToHex()
        local v305 = `<font color='#{v304}'><b>titles</b></font>`
        t_12.Description = table_concat_6(
            {
                v273,
                v288,
                "",
                v290,
                v297,
                "",
                v299,
                `Each level grants {v301} and experience, with bigger rewards at every rank. Higher levels also improve the {v303} of the materials you gather, and certain ranks unlock {v305}.`
            },
            "\n"
        )
        t.Professions = t_12
    end
    do
        local t_14 = { Header = "BIRD SYSTEM", ButtonText = "Bird System", Description = nil }
        local table_concat_7 = table.concat
        local v306 = color_2:ToHex()
        local v307 = `<font color='#{v306}'><b>Mission Orders</b></font>`
        local v308 = `Browse available {v307} and fulfill the Guild's requests.`
        local v309 = color:ToHex()
        local v310 = `<font size='{24}' color='#{v309}'><b>Mission Tokens</b></font>`
        local v311 = color_2:ToHex()
        local v312 = `<font color='#{v311}'><b>Guild Hall</b></font>`
        local v313 = color_2:ToHex()
        local v314 = `<font color='#{v313}'><b>missions</b></font>`
        local v315 = `Vouchers from the {v312} that grant clearance to undertake {v314}. New tokens are periodically issued to replenish your supply.`
        local v316 = color_1:ToHex()
        local v317 = `<font size='{24}' color='#{v316}'><b>Requesting a Mission</b></font>`
        local v318 = color_2:ToHex()
        local v319 = `<font color='#{v318}'><b>utility spells</b></font>`
        local v320 = color_2:ToHex()
        local v321 = `<font color='#{v320}'><b>Mission Bird</b></font>`
        local v322 = `Open your {v319} (Hold U) and select {v321} to request a mission.`
        local v323 = color:ToHex()
        local v324 = `<font size='{24}' color='#{v323}'><b>Completing Missions</b></font>`
        local v325 = color_2:ToHex()
        local v326 = `<font color='#{v325}'><b>time limit</b></font>`
        t_14.Description = table_concat_7(
            {
                v308,
                "",
                v310,
                v315,
                "",
                v317,
                v322,
                "",
                v324,
                `Each mission comes with a {v326}. Complete the Guild's request before the timer runs out to claim your reward. If time expires, the mission is failed.`
            },
            "\n"
        )
        t.Missions = t_14
    end
    do
        local t_16 = { Header = "ABILITIES", Description = nil }
        local table_concat_8 = table.concat
        local v327 = color:ToHex()
        local v328 = `<font size='{24}' color='#{v327}'><b>Unlocking Abilities</b></font>`
        local v329 = color_2:ToHex()
        local v330 = `<font color='#{v329}'><b>trainers</b></font>`
        local v331 = color_2:ToHex()
        local v332 = `<font color='#{v331}'><b>Grimoire Echo</b></font>`
        local v333 = color_2:ToHex()
        local v334 = `<font color='#{v333}'><b>Inner Realm</b></font>`
        local v335 = `Weapon abilities are learned from {v330} found throughout the world. Magic abilities are taught by your {v332} in the {v334}.`
        local v336 = color_1:ToHex()
        local v337 = `<font size='{24}' color='#{v336}'><b>Requirements</b></font>`
        local v338 = color_2:ToHex()
        local v339 = `<font color='#{v338}'><b>skill points</b></font>`
        local v340 = color_2:ToHex()
        local v341 = `<font color='#{v340}'><b>stat requirements</b></font>`
        t_16.Description = table_concat_8(
            {
                v328,
                v335,
                "",
                v337,
                `Each ability costs {v339} to unlock and has {v341} you must meet first. Invest your stats with the abilities you want in mind.`
            },
            "\n"
        )
        t.Abilities = t_16
    end

    return t
end
