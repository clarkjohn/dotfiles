import sublime
import sublime_plugin
import os
import time
from collections import defaultdict

# === CONFIGURATION ===
AUTOSAVE_ROOT = os.path.expanduser("~/ws/sublime/autosave")
AUTOSAVE_INTERVAL = 60       # seconds between autosaves per file
MAX_VERSIONS_PER_FILE = 10   # keep only the latest N versions

# === INTERNAL STATE ===
last_saved_time = defaultdict(lambda: 0)
last_saved_content = {}

class DailyRollingAutoSave(sublime_plugin.EventListener):
    def on_modified_async(self, view):
        # Skip empty buffers
        if view.size() == 0:
            return

        # Get buffer content
        content = view.substr(sublime.Region(0, view.size()))
        if not content.strip():
            return

        # Use filename if available, otherwise untitled-ID
        filename = view.file_name()
        if filename:
            base = os.path.basename(filename)
        else:
            base = f"untitled-{view.id()}"

        # Skip if content hasn't changed since last save
        last_content = last_saved_content.get(view.id())
        if last_content == content:
            return

        # Throttle autosave frequency
        now = time.time()
        if now - last_saved_time[view.id()] < AUTOSAVE_INTERVAL:
            return

        # Build today's autosave directory
        today = time.strftime("%Y-%m-%d")
        today_dir = os.path.join(AUTOSAVE_ROOT, today)
        os.makedirs(today_dir, exist_ok=True)

        # Generate timestamped filename
        timestamp = time.strftime("%H%M%S")
        safe_name = f"{base}-{timestamp}.txt"
        save_path = os.path.join(today_dir, safe_name)

        # Write autosave snapshot
        try:
            with open(save_path, "w", encoding="utf-8") as f:
                f.write(content)
        except Exception as e:
            print("DailyRollingAutoSave Error:", e)
            return

        # Update tracking state
        last_saved_time[view.id()] = now
        last_saved_content[view.id()] = content

        # Cleanup older versions globally
        self.cleanup_old_versions(base)

    def cleanup_old_versions(self, base):
        """
        Keeps only the latest N autosave versions per file across all days.
        """
        try:
            # Find all matching autosave files across daily subfolders
            matches = []
            for root, _, files in os.walk(AUTOSAVE_ROOT):
                for f in files:
                    if f.startswith(base + "-") and f.endswith(".txt"):
                        full_path = os.path.join(root, f)
                        matches.append(full_path)

            # Nothing to do if within limit
            if len(matches) <= MAX_VERSIONS_PER_FILE:
                return

            # Sort by modification time (oldest first)
            matches.sort(key=lambda path: os.path.getmtime(path))

            # Remove oldest versions beyond limit
            for old_file in matches[:-MAX_VERSIONS_PER_FILE]:
                os.remove(old_file)

        except Exception as e:
            print("DailyRollingAutoSave Cleanup Error:", e)