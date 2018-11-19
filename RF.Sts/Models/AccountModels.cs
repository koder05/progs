using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;

using RF.Common;

namespace RF.WebApp.Models
{
	public class ChangePasswordModel : RegisterModel
	{
        [Required(ErrorMessage = "Требуется Текущий пароль")]
		[DataType(DataType.Password)]
		[Display(Name = "Текущий пароль")]
		public string OldPassword { get; set; }

		public bool OldPswNotRequired { get; set; }
	}

	public class LoginModel
	{
        [Required(ErrorMessage = "Требуется СНИЛС")]
		[Display(Name = "СНИЛС (11 цифр)")]
		public string Login { get; set; }

		internal string UserName 
		{
			get
			{
				return Utils.ClearInsuranceCertificate(this.Login);
			}
		}

        [Required(ErrorMessage = "Требуется Пароль")]
		[DataType(DataType.Password)]
		[Display(Name = "Пароль")]
		public string Password { get; set; }

		[Display(Name = "Оставаться в системе")]
		public bool RememberMe { get; set; }
	}

	public class RegisterModel : RemindPasswordModel
	{
        [Required(ErrorMessage = "Требуется Новый пароль")]
		//[PasswordComplexity(ErrorMessage="Пароль не соответствует критериям")]
		[DataType(DataType.Password)]
		[Display(Name = "Новый пароль")]
		public string Password { get; set; }

		[DataType(DataType.Password)]
		[Display(Name = "Подтверждение")]
		[Compare("Password", ErrorMessage = "Пароль и его подтверждение не совпадают.")]
		public string ConfirmPassword { get; set; }
	}

	public class RemindPasswordModel
	{
        [Required(ErrorMessage = "Требуется СНИЛС")]
        [Display(Name = "СНИЛС (11 цифр)")]
		public string Login { get; set; }

		internal string UserName
		{
			get
			{
				return Utils.ClearInsuranceCertificate(this.Login);
			}
		}

        [Required(ErrorMessage = "Email")]
		[DataType(DataType.EmailAddress, ErrorMessage="Неверный формат email")]
		[RegularExpression(@"^[^а-яА-Я@^]+@([\w\d-+_]+\.)+\w+$", ErrorMessage = "Неверный формат email")]
		[Display(Name = "Email")]
		public string Email { get; set; }
	}
}
