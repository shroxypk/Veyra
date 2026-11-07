"""Regression checks for F1-F4 defect fixes."""
import unittest
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]

class F1MigrationTests(unittest.TestCase):
    """F1: loadLearned forward reference fix."""

    def test_saveLearned_forward_declared(self):
        """saveLearned must be forward-declared before loadLearned."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        # Forward declaration must appear before loadLearned definition
        forward_idx=code.find("local saveLearned")
        load_idx=code.find("local function loadLearned")
        self.assertGreaterEqual(forward_idx, 0, "local saveLearned not found")
        self.assertGreaterEqual(load_idx, 0, "local function loadLearned not found")
        self.assertLess(forward_idx, load_idx,
            "forward declaration must come before loadLearned")

    def test_loadLearned_called_after_saveLearned(self):
        """loadLearned() call must be after saveLearned definition."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        save_def=code.find("saveLearned=function()")
        call_idx=code.find("\nloadLearned()")
        self.assertGreaterEqual(save_def, 0, "saveLearned=function() not found")
        self.assertGreaterEqual(call_idx, 0, "loadLearned() call not found")
        self.assertLess(save_def, call_idx,
            "loadLearned() must be called after saveLearned is defined")

    def test_migration_still_present(self):
        """Migration from selfImproving.bias must still work."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn("old.bias", code)
        self.assertIn("learned.assets[id].parryOffset=val", code)
        self.assertIn("saveLearned()", code)


class F2DebounceTests(unittest.TestCase):
    """F2: debounced saveLearned."""

    def test_setAsset_does_not_call_saveLearned(self):
        """setAsset must not call saveLearned directly (debounced)."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        # Find setAsset function body
        start=code.find("local function setAsset(")
        end=code.find("end\n", start)
        body=code[start:end]
        self.assertNotIn("saveLearned()", body,
            "setAsset must use markLearnedDirty(), not saveLearned()")
        self.assertIn("markLearnedDirty()", body)

    def test_incAssetStat_does_not_call_saveLearned(self):
        """incAssetStat must not call saveLearned directly."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        start=code.find("local function incAssetStat(")
        end=code.find("end\n", start)
        body=code[start:end]
        self.assertNotIn("saveLearned()", body,
            "incAssetStat must use markLearnedDirty(), not saveLearned()")
        self.assertIn("markLearnedDirty()", body)

    def test_flushLearnedIfNeeded_exists(self):
        """Flush function must exist and be called from step()."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn("local function flushLearnedIfNeeded()", code)
        self.assertIn("flushLearnedIfNeeded()", code)
        # Must be called in step()
        step_start=code.find("local function step()")
        step_body=code[step_start:step_start+3000]
        self.assertIn("flushLearnedIfNeeded()", step_body)

    def test_stop_force_saves(self):
        """state.stop() must call saveLearned()."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        stop_start=code.find("function state.stop()")
        stop_body=code[stop_start:stop_start+500]
        self.assertIn("saveLearned()", stop_body)


class F3DodgeOrphanTests(unittest.TestCase):
    """F3: dodge must only take roll-kind orphans."""

    def test_dodge_filters_by_kind(self):
        """auto_dodge.lua must filter orphans by kind."""
        code=(ROOT/"src/auto_dodge.lua").read_text(encoding="utf-8")
        self.assertIn('o.kind ~= "parry"', code,
            "dodge must filter out parry-kind orphans")
        self.assertIn("for _,o in ipairs(parry.orphans)", code)

    def test_dodge_header_documents_kind(self):
        """Header comment must document the kind contract."""
        code=(ROOT/"src/auto_dodge.lua").read_text(encoding="utf-8")
        self.assertIn('kind="roll"', code,
            "header must document roll-kind orphan contract")


class F4CoverageTests(unittest.TestCase):
    """F4: correct C4 coverage metric."""

    def test_roll_duration_config(self):
        """ROLL_DURATION must be config-driven with default 0.45."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('cfg("rollDuration",0.45)', code)

    def test_roll_duration_learned(self):
        """rollDuration must be learned from StateDuration_Rolling."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn('StateDuration_Rolling', code)
        self.assertIn('state.rollDuration', code)

    def test_coveredFor_function(self):
        """coveredFor must implement the correct metric."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn("local function coveredFor(mode)", code)
        self.assertIn("rollDur+0.03", code)

    def test_canDash_gate(self):
        """Roll-first must check CanDash availability."""
        code=(ROOT/"src/auto_parry.lua").read_text(encoding="utf-8")
        self.assertIn("CanDash()", code)
        self.assertIn("canRollNow", code)


if __name__=="__main__":
    unittest.main()
