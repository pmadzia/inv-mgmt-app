import CheckboxSelectAll from "@stimulus-components/checkbox-select-all"

export default class extends CheckboxSelectAll {
  static targets = [...CheckboxSelectAll.targets, "action"]

  toggle(event) {
    const checked = event.target.checked
    this.checkboxTargets.forEach((box) => (box.checked = checked))
    this.refresh()
  }

  refresh() {
    super.refresh()
    const any = this.checkboxTargets.some((box) => box.checked)
    this.actionTargets.forEach((button) => (button.disabled = !any))
  }
}