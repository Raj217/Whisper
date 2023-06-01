import { Request, Response, NextFunction } from "express";

export const logger = (req: Request, res: Response, next: NextFunction) => {
  console.log("Request Type:", req.method);
  console.log("Route: ", req.url);
  next();
};
