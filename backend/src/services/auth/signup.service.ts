import { User } from "../../interfaces/index.js";

export const signUp = async (user: User) => {

  /// Validate if all the required fields are present
//   if (!firstName)
//     throw new Exception("First name is required", ExceptionCodes.BAD_INPUT);
//   if (!lastName)
//     throw new Exception("Last name is required", ExceptionCodes.BAD_INPUT);
//   if (!role) throw new Exception("Role is required", ExceptionCodes.BAD_INPUT);
//   if (!email)
//     throw new Exception("Email is required", ExceptionCodes.BAD_INPUT);
//   if (!password)
//     throw new Exception("Password is required", ExceptionCodes.BAD_INPUT);
//   if (password.length < 6)
//     throw new Exception(
//       "Password must be at least 6 characters",
//       ExceptionCodes.BAD_INPUT
//     );

//   if (!Validators.isValidEmail(email))
//     throw new Exception("Invalid email", ExceptionCodes.UNAUTHORIZED);

//   const existingUser = await User.findOne({ email });
//   /// Already someone exists with the same email
//   if (existingUser && existingUser.isEmailVerified == false) {
//     await generateAndSendOtp(email);
//     throw new Exception(
//       "User already exists. OTP has been sent to your mail.",
//       ExceptionCodes.CONFLICT
//     );
//   } else if (existingUser) {
//     throw new Exception(
//       "User already exists. Please Sign in.",
//       ExceptionCodes.CONFLICT
//     );
//   }

//   /// New user thus hash the password
//   const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);

//   await User.create({
//     email,
//     password: hashedPassword,
//     firstName: firstName,
//     lastName: lastName,
//     role: role,
//   });
//   await generateAndSendOtp(email);
};
