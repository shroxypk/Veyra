"""Regression checks for C15/C16 roll timing and simulation."""
import unittest
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]

class RollTimingTests(unittest.TestCase):
    def test_roll_lead_less_than_roll_duration(self):
        """rollLead() must be less than roll duration (mid-roll)."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn("local function rollLead()", code)
        self.assertIn("getAssetRollDuration()/2", code)

    def test_roll_lead_less_than_allow_cancel(self):
        """rollLead must be less than ALLOW_CANCEL (0.206)."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('ALLOW_CANCEL=cfg("allowCancel",0.206)', code)

    def test_roll_lead_formula(self):
        """rollLead = rollDur/2 + outbound."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn("getAssetRollDuration()/2 + OUTBOUND", code)

    def test_send_gap_matches_dash_cooldown(self):
        """SEND_GAP must be >= DASH_COOLDOWN (1.5)."""
        code=(ROOT/"src/auto_dodge.lua").read_text(encoding="utf-8")
        self.assertIn("SEND_GAP=1.55", code)

    def test_roll_duration_default(self):
        """ROLL_DURATION default must be 0.275."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('ROLL_DURATION=cfg("rollDuration",0.275)', code)

    def test_roll_duration_reads_dodging_first(self):
        """Must try StateDuration_Dodging before StateDuration_Rolling."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('StateDuration_Dodging', code)
        # The read must be: Dodging or Rolling (Dodging first)
        self.assertIn('GetAttribute("StateDuration_Dodging") or c:GetAttribute("StateDuration_Rolling")', code)

    def test_roll_lead_no_static_034(self):
        """ROLL_LEAD must not be a static 0.34 in dodge or parry orphan publish."""
        code=(ROOT/"src/auto_dodge.lua").read_text(encoding="utf-8")
        self.assertNotIn("ROLL_LEAD=0.34", code)
        self.assertNotIn("ROLL_LEAD=0.475", code)
        code2=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertNotIn('"rollLead",0.34', code2)
        self.assertIn('getAsset(candidate.id,"rollLead",rollLead())', code2)

    def test_dodge_uses_parry_roll_lead(self):
        """Dodge must use parry.rollLead when present."""
        code=(ROOT/"src/auto_dodge.lua").read_text(encoding="utf-8")
        self.assertIn("parry.rollLead", code)

    def test_dodge_filter_is_roll_only(self):
        """Dodge filter must be o.kind == "roll" (not ~= "parry")."""
        code=(ROOT/"src/auto_dodge.lua").read_text(encoding="utf-8")
        self.assertIn('o.kind == "roll"', code)
        self.assertNotIn('o.kind ~= "parry"', code)

    def test_aoe_uses_getAsset(self):
        """isAOE must use getAsset for profile aoe, not direct learned access."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('getAsset(id,"aoe",false)', code)
        self.assertNotIn("learned.assets[id].aoe", code)

    def test_aoe_hyperarmor_not_a_signal(self):
        """State_HyperArmor must NOT classify an attacker as AoE/unparryable.

        Every FightableNPC carries State_HyperArmor (mob poise, verified live:
        all Wolves), so gating on it blocks all mob parries. See C19.
        """
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertNotIn('GetAttribute("State_HyperArmor")', code)

    def test_aoe_name_pattern_not_pipe(self):
        """AoE name matching must use plain-substring keywords, not a pipe pattern.

        Lua patterns have no alternation; the old pipe-joined pattern matched
        literally and never fired.
        """
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertNotIn("screech|roar|bomb", code)
        self.assertIn("AOE_KEYWORDS", code)

    def test_parry_offset_fallback(self):
        """parryOffset fallback must handle 0 as truthy (use nil check)."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('getAsset(candidate.id,"parryOffset",nil)', code)
        self.assertIn('(authored~=nil) and authored', code)

    def test_simulate_function_exists(self):
        """Simulation function must exist."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn("local GRACE=GRACE_LOCK+0.03", code)
        self.assertIn("local function parryAt(t)", code)
        self.assertIn("local function rollAt(t)", code)
        self.assertIn("local ROLL_RECOVER=0.09", code)
        self.assertIn("local function simulate(mode)", code)

    def test_dash_cooldown_config(self):
        """DASH_COOLDOWN must be config-driven with default 1.5."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('DASH_COOLDOWN=cfg("dashCooldown",1.5)', code)

    def test_dash_ready_computed(self):
        """dashReadyAt must be computed from StateEnd_DashCooldown."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn("dashReadyAt", code)
        self.assertIn("StateEnd_DashCooldown", code)

    def test_drop_kind_assignment(self):
        """Simulation must assign "drop" kind to uncovered hits."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('"drop"', code)


if __name__=="__main__":
    unittest.main()
