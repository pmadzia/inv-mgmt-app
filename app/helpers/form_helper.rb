module FormHelper
  def email_validation
    {
      oninvalid: "this.setCustomValidity(this.validity.valueMissing ?
      '#{t("validation.email.empty")}' : '#{t("validation.email.invalid")}')",
      oninput: "this.setCustomValidity(''); this.checkValidity()"
    }
  end

  def password_validation
    {
      oninvalid: "this.setCustomValidity(this.validity.valueMissing ?
      '#{t("validation.password.empty")}' : '#{t("validation.password.short")}')",
      oninput: "this.setCustomValidity(''); this.checkValidity()"
    }
  end

  def name_validation
    {
      oninvalid: "this.setCustomValidity('#{t("validation.name.empty")}')",
      oninput: "this.setCustomValidity(''); this.checkValidity()"
    }
  end
end
