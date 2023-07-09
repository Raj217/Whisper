import { unsplashProvider } from "./providers/unsplash-provider.service.js";

export const search = async (_query) => {
  var { query, page, per_page } = _query;

  return { res: unsplashProvider(query, page, per_page) };
};
