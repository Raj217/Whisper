export const removeSecrets = (user) => {
  delete user.password;
  delete user.pexelsIDVisited;
  delete user.unsplashIDVisited;

  return user;
};
